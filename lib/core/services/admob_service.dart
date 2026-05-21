import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'interstitial_ad_service.dart';

/// Initializes Google Mobile Ads with child-directed settings for Shishu Path.
class AdMobService {
  AdMobService._();

  static final AdMobService instance = AdMobService._();

  bool _initialized = false;

  bool get isInitialized => _initialized;

  Future<void> initialize() async {
    if (_initialized) return;

    await MobileAds.instance.initialize();

    // Shishu Path is a kids learning app — request child-appropriate ads.
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

    InterstitialAdService.instance.preload();
  }
}
