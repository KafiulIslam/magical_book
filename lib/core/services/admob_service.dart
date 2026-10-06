import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'interstitial_ad_service.dart';

/// Initializes Google Mobile Ads with child-directed settings for Shishu Path.
class AdMobService extends ChangeNotifier {
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
      await MobileAds.instance.updateRequestConfiguration(
        RequestConfiguration(
          tagForChildDirectedTreatment: TagForChildDirectedTreatment.yes,
          tagForUnderAgeOfConsent: TagForUnderAgeOfConsent.yes,
          maxAdContentRating: MaxAdContentRating.g,
        ),
      );
      await MobileAds.instance.initialize();

      _initialized = true;

      if (kDebugMode) {
        debugPrint('AdMob initialized.');
      }

      InterstitialAdService.instance.preload();
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        debugPrint('AdMob init failed: $e');
      }
    } finally {
      _initializing = false;
    }
  }
}
