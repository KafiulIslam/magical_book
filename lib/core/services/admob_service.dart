import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'ad_preload_service.dart';

/// Initializes Google Mobile Ads with child-directed settings for Shishu Path.
class AdMobService {
  AdMobService._();

  static final AdMobService instance = AdMobService._();

  bool _initialized = false;
  bool _initializing = false;

  bool get isInitialized => _initialized;

  /// Fire-and-forget — never block app launch on ad SDK init.
  void initialize() {
    if (_initialized || _initializing) return;
    _initializing = true;
    unawaited(_initialize());
  }

  Future<void> _initialize() async {
    try {
      await MobileAds.instance.initialize();

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

      AdPreloadService.instance.warmAll();
    } catch (e) {
      if (kDebugMode) {
        debugPrint('AdMob init failed: $e');
      }
    } finally {
      _initializing = false;
    }
  }
}
