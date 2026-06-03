import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../constants/admob_constants.dart';
import 'admob_service.dart';

/// Pre-loads one banner per home tab so each screen can show an ad instantly.
class AdPreloadService extends ChangeNotifier {
  AdPreloadService._();

  static final AdPreloadService instance = AdPreloadService._();

  static const String bangla = 'bangla';
  static const String english = 'english';
  static const String math = 'math';
  static const String arabic = 'arabic';

  static const List<String> slots = [bangla, english, math, arabic];

  /// Reserved height while a banner is loading (avoids layout jump).
  static const double placeholderHeight = 50;

  static const _maxLoadAttempts = 5;
  static const _retryDelay = Duration(seconds: 3);

  final Map<String, BannerAd?> _readyAds = {};
  final Set<String> _loadingSlots = {};
  final Map<String, int> _loadAttempts = {};

  bool isReady(String slot) => _readyAds[slot] != null;

  /// Starts warming all home tab slots. Safe to call multiple times.
  void warmAll() {
    if (!AdMobService.instance.isInitialized) return;
    for (final slot in slots) {
      warmSlot(slot);
    }
  }

  void warmSlot(String slot) {
    _warmSlot(slot);
  }

  /// Returns a ready pre-loaded ad for [slot], or null.
  BannerAd? takeIfReady(String slot) {
    final ad = _readyAds.remove(slot);
    if (ad != null) {
      _loadingSlots.remove(slot);
      _loadAttempts.remove(slot);
      warmSlot(slot);
    }
    return ad;
  }

  void _warmSlot(String slot) {
    if (_readyAds.containsKey(slot) || _loadingSlots.contains(slot)) return;
    if (!AdMobService.instance.isInitialized) return;

    _loadingSlots.add(slot);
    unawaited(_loadForSlot(slot));
  }

  Future<void> _loadForSlot(String slot) async {
    try {
      final view = WidgetsBinding.instance.platformDispatcher.views.firstOrNull;
      if (view == null) {
        _loadingSlots.remove(slot);
        _scheduleRetry(slot);
        return;
      }

      final logicalWidth =
          (view.physicalSize.width / view.devicePixelRatio).truncate();

      final adSize =
          await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
                logicalWidth,
              ) ??
              AdSize.banner;

      BannerAd? ad;
      ad = BannerAd(
        adUnitId: AdMobConstants.bannerAdUnitId,
        size: adSize,
        request: const AdRequest(),
        listener: BannerAdListener(
          onAdLoaded: (_) {
            _readyAds[slot] = ad;
            _loadingSlots.remove(slot);
            _loadAttempts[slot] = 0;
            notifyListeners();
          },
          onAdFailedToLoad: (failedAd, error) {
            failedAd.dispose();
            _loadingSlots.remove(slot);
            if (kDebugMode) {
              debugPrint('Banner preload [$slot] failed: ${error.message}');
            }
            _scheduleRetry(slot);
            notifyListeners();
          },
        ),
      );

      ad.load();
    } catch (e) {
      _loadingSlots.remove(slot);
      if (kDebugMode) {
        debugPrint('Banner preload [$slot] error: $e');
      }
      _scheduleRetry(slot);
    }
  }

  void _scheduleRetry(String slot) {
    final attempts = (_loadAttempts[slot] ?? 0) + 1;
    _loadAttempts[slot] = attempts;
    if (attempts > _maxLoadAttempts) return;

    Future.delayed(_retryDelay, () {
      if (!AdMobService.instance.isInitialized) return;
      if (_readyAds.containsKey(slot)) return;
      _warmSlot(slot);
    });
  }

  void disposeAll() {
    for (final ad in _readyAds.values) {
      ad?.dispose();
    }
    _readyAds.clear();
    _loadingSlots.clear();
    _loadAttempts.clear();
  }
}
