import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../constants/admob_constants.dart';
import '../services/ad_preload_service.dart';
import '../services/admob_service.dart';

/// Adaptive banner for main tab home screens only (Families policy).
class AdBannerWidget extends StatefulWidget {
  const AdBannerWidget({
    super.key,
    required this.slotId,
  });

  final String slotId;

  @override
  State<AdBannerWidget> createState() => _AdBannerWidgetState();
}

class _AdBannerWidgetState extends State<AdBannerWidget> {
  static const _maxLoadAttempts = 5;
  static const _retryDelay = Duration(seconds: 3);

  BannerAd? _bannerAd;
  bool _loaded = false;
  bool _isLoading = false;
  int _loadAttempts = 0;
  Timer? _retryTimer;

  @override
  void initState() {
    super.initState();
    AdMobService.instance.addListener(_onAdMobReady);
    AdPreloadService.instance.addListener(_onPreloadUpdated);
    AdMobService.instance.initialize();
    WidgetsBinding.instance.addPostFrameCallback((_) => _ensureBanner());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _ensureBanner();
  }

  void _onAdMobReady() {
    if (!mounted) return;
    AdPreloadService.instance.warmSlot(widget.slotId);
    _ensureBanner();
  }

  void _onPreloadUpdated() {
    if (!mounted || _loaded) return;
    _tryAttachFromPool();
  }

  void _tryAttachFromPool() {
    if (_loaded) return;

    final preloaded = AdPreloadService.instance.takeIfReady(widget.slotId);
    if (preloaded != null) {
      _bannerAd?.dispose();
      _bannerAd = preloaded;
      _isLoading = false;
      _loadAttempts = 0;
      _retryTimer?.cancel();
      setState(() => _loaded = true);
    }
  }

  void _ensureBanner() {
    if (_loaded || _isLoading) return;

    if (!AdMobService.instance.isInitialized) {
      AdMobService.instance.initialize();
      return;
    }

    _tryAttachFromPool();
    if (_loaded) return;

    _loadDirect();
  }

  Future<void> _loadDirect() async {
    if (_isLoading || _loaded || !mounted) return;
    if (!AdMobService.instance.isInitialized) return;

    _isLoading = true;

    final width = MediaQuery.sizeOf(context).width.truncate();
    final adSize =
        await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(width) ??
            AdSize.banner;

    if (!mounted) {
      _isLoading = false;
      return;
    }

    if (AdPreloadService.instance.isReady(widget.slotId)) {
      _isLoading = false;
      _tryAttachFromPool();
      return;
    }

    final banner = BannerAd(
      adUnitId: AdMobConstants.bannerAdUnitId,
      size: adSize,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          if (!mounted) return;
          _isLoading = false;
          _loadAttempts = 0;
          _retryTimer?.cancel();
          setState(() => _loaded = true);
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          if (_bannerAd == ad) _bannerAd = null;
          _isLoading = false;
          if (kDebugMode) {
            debugPrint(
              'Banner [${widget.slotId}] failed: ${error.message}',
            );
          }
          _scheduleRetry();
        },
      ),
    );

    _bannerAd = banner;
    await banner.load();
  }

  void _scheduleRetry() {
    if (!mounted || _loaded) return;

    _loadAttempts++;
    if (_loadAttempts > _maxLoadAttempts) return;

    _retryTimer?.cancel();
    _retryTimer = Timer(_retryDelay, () {
      if (!mounted || _loaded) return;
      _tryAttachFromPool();
      if (!_loaded) _loadDirect();
    });
  }

  @override
  void dispose() {
    _retryTimer?.cancel();
    AdMobService.instance.removeListener(_onAdMobReady);
    AdPreloadService.instance.removeListener(_onPreloadUpdated);
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ad = _bannerAd;

    if (_loaded && ad != null) {
      final height = ad.size.height.toDouble();
      if (height > 0) {
        return SizedBox(
          width: double.infinity,
          height: height,
          child: AdWidget(ad: ad),
        );
      }
    }

    if (_isLoading || !AdMobService.instance.isInitialized) {
      return const SizedBox(
        height: AdPreloadService.placeholderHeight,
      );
    }

    return const SizedBox.shrink();
  }
}
