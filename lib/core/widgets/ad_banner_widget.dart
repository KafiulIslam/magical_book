import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../constants/admob_constants.dart';
import '../services/admob_service.dart';

/// One adaptive banner shared by the four home tabs.
///
/// Only the visible home tab mounts this widget, so a tab change reuses the
/// loaded ad instead of requesting four banners at once.
class AdBannerWidget extends StatefulWidget {
  const AdBannerWidget({super.key});

  @override
  State<AdBannerWidget> createState() => _AdBannerWidgetState();
}

class _AdBannerWidgetState extends State<AdBannerWidget> {
  final _SharedBanner _banner = _SharedBanner.instance;

  @override
  void initState() {
    super.initState();
    AdMobService.instance.addListener(_onAdMobReady);
    _banner.addListener(_onBannerUpdated);
    AdMobService.instance.initialize();
    WidgetsBinding.instance.addPostFrameCallback((_) => _ensureBanner());
  }

  void _onAdMobReady() {
    if (!mounted) return;
    _ensureBanner();
  }

  void _onBannerUpdated() {
    if (!mounted) return;
    setState(() {});
  }

  void _ensureBanner() {
    if (!mounted || !AdMobService.instance.isInitialized) return;
    _banner.ensureLoaded(MediaQuery.sizeOf(context).width);
  }

  @override
  void dispose() {
    AdMobService.instance.removeListener(_onAdMobReady);
    _banner.removeListener(_onBannerUpdated);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ad = _banner.ad;

    if (_banner.loaded && ad != null) {
      final height = ad.size.height.toDouble();
      if (height > 0) {
        return SizedBox(
          width: double.infinity,
          height: height,
          child: AdWidget(key: ValueKey(ad), ad: ad),
        );
      }
    }

    if (_banner.loading || !AdMobService.instance.isInitialized) {
      return const SizedBox(height: _SharedBanner.placeholderHeight);
    }

    return const SizedBox.shrink();
  }
}

class _SharedBanner {
  _SharedBanner._();

  static final _SharedBanner instance = _SharedBanner._();

  static const placeholderHeight = 50.0;
  static const _maxLoadAttempts = 5;
  static const _retryDelay = Duration(seconds: 3);

  final Set<VoidCallback> _listeners = {};

  BannerAd? ad;
  bool loaded = false;
  bool loading = false;
  int _attempts = 0;
  int _generation = 0;
  Timer? _retryTimer;
  double _width = 0;

  void addListener(VoidCallback listener) {
    final wasEmpty = _listeners.isEmpty;
    _listeners.add(listener);
    if (wasEmpty && !loaded) {
      _attempts = 0;
    }
  }

  void removeListener(VoidCallback listener) {
    _listeners.remove(listener);
    if (_listeners.isNotEmpty) return;

    _retryTimer?.cancel();
    _generation++;
    final current = ad;
    ad = null;
    loaded = false;
    loading = false;
    current?.dispose();
  }

  void ensureLoaded(double width) {
    if (width > 0) _width = width;
    if (loaded || loading || _listeners.isEmpty) return;
    loading = true;
    _notify();
    unawaited(_load());
  }

  Future<void> _load() async {
    final generation = _generation;
    final width = _width.truncate();
    final adSize = width > 0
        ? await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
              width,
            ) ??
            AdSize.banner
        : AdSize.banner;

    if (generation != _generation || _listeners.isEmpty) {
      if (generation == _generation) {
        loading = false;
        _notify();
      }
      return;
    }

    final banner = BannerAd(
      adUnitId: AdMobConstants.bannerAdUnitId,
      size: adSize,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          if (generation != _generation) return;
          loaded = true;
          loading = false;
          _attempts = 0;
          _retryTimer?.cancel();
          _notify();
        },
        onAdFailedToLoad: (failedAd, error) {
          if (generation != _generation) return;
          failedAd.dispose();
          if (identical(ad, failedAd)) ad = null;
          loaded = false;
          loading = false;
          if (kDebugMode) {
            debugPrint('Banner failed: ${error.message}');
          }
          _scheduleRetry();
          _notify();
        },
      ),
    );

    ad = banner;
    try {
      await banner.load();
    } catch (e) {
      if (generation != _generation) return;
      banner.dispose();
      if (identical(ad, banner)) ad = null;
      loaded = false;
      loading = false;
      if (kDebugMode) {
        debugPrint('Banner failed: $e');
      }
      _scheduleRetry();
      _notify();
    }
  }

  void _scheduleRetry() {
    if (_listeners.isEmpty) return;

    _attempts++;
    if (_attempts > _maxLoadAttempts) return;

    _retryTimer?.cancel();
    _retryTimer = Timer(_retryDelay, () {
      if (_listeners.isEmpty || loaded) return;
      ensureLoaded(_width);
    });
  }

  void _notify() {
    for (final listener in List<VoidCallback>.from(_listeners)) {
      listener();
    }
  }
}
