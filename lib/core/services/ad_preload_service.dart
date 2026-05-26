import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../constants/admob_constants.dart';
import 'admob_service.dart';

/// Pre-loads one banner per home tab so each screen can show an ad instantly.
class AdPreloadService {
  AdPreloadService._();

  static final AdPreloadService instance = AdPreloadService._();

  static const String bangla = 'bangla';
  static const String english = 'english';
  static const String math = 'math';
  static const String arabic = 'arabic';

  static const List<String> slots = [bangla, english, math, arabic];

  final Map<String, BannerAd?> _readyAds = {};
  final Set<String> _loadingSlots = {};

  /// Starts warming all home tab slots. Safe to call multiple times.
  void warmAll() {
    if (!AdMobService.instance.isInitialized) return;
    for (final slot in slots) {
      _warmSlot(slot);
    }
  }

  /// Returns a pre-loaded ad for [slot] if ready; always starts loading a replacement.
  BannerAd? consume(String slot) {
    final ad = _readyAds.remove(slot);
    _loadingSlots.remove(slot);
    _warmSlot(slot);
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
          },
          onAdFailedToLoad: (failedAd, error) {
            failedAd.dispose();
            _loadingSlots.remove(slot);
            if (kDebugMode) {
              debugPrint('Banner preload [$slot] failed: ${error.message}');
            }
          },
        ),
      );
      await ad.load();
    } catch (e) {
      _loadingSlots.remove(slot);
      if (kDebugMode) {
        debugPrint('Banner preload [$slot] error: $e');
      }
    }
  }

  void disposeAll() {
    for (final ad in _readyAds.values) {
      ad?.dispose();
    }
    _readyAds.clear();
    _loadingSlots.clear();
  }
}
