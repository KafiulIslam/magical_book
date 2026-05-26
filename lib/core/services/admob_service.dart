import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'banner_ad_service.dart';

/// Initializes Google Mobile Ads with child-directed settings for Shishu Path.
class AdMobService {
  AdMobService._();

  static final AdMobService instance = AdMobService._();

  bool _initialized = false;
  bool _initializing = false;

  bool get isInitialized => _initialized;

  /// Starts SDK init in the background — never block [runApp] on this.
  void initializeInBackground() {
    if (_initialized || _initializing) return;
    _initializing = true;
    unawaited(_initialize());
  }

  Future<void> _initialize() async {
    try {
      await MobileAds.instance.initialize().timeout(
            const Duration(seconds: 15),
          );

      await MobileAds.instance.updateRequestConfiguration(
        RequestConfiguration(
          tagForChildDirectedTreatment: TagForChildDirectedTreatment.yes,
          maxAdContentRating: MaxAdContentRating.g,
          tagForUnderAgeOfConsent: TagForUnderAgeOfConsent.yes,
        ),
      );

      _initialized = true;

      if (kDebugMode) {
        debugPrint('AdMob initialized (test ad units in debug mode).');
      }

      _preloadBanner();
      BannerAdService.instance.onAdMobReady();
    } on TimeoutException {
      if (kDebugMode) {
        debugPrint('AdMob init timed out — app continues without ads.');
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('AdMob init failed: $e');
      }
    } finally {
      _initializing = false;
    }
  }

  void _preloadBanner() {
    final view = WidgetsBinding.instance.platformDispatcher.views.firstOrNull;
    if (view == null) return;

    final width =
        (view.physicalSize.width / view.devicePixelRatio - 32).truncate();
    BannerAdService.instance.preload(width);
  }
}
