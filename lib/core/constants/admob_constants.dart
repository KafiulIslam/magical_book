import 'package:flutter/foundation.dart';

/// AdMob IDs for Shishu Path.
///
/// **Before release:**
/// 1. Replace [androidAppId] / [iosAppId] in AndroidManifest.xml and Info.plist.
/// 2. Set production ad unit IDs below.
/// 3. Configure child-directed / Families settings in the AdMob console.
class AdMobConstants {
  AdMobConstants._();

  // ---------------------------------------------------------------------------
  // App IDs (must match AndroidManifest.xml and ios/Runner/Info.plist)
  // ---------------------------------------------------------------------------

  static const androidAppId = 'ca-app-pub-6871786334119508~7611803840';

  /// Replace when iOS app is registered in AdMob.
  static const iosAppId = 'ca-app-pub-3940256099942544~1458002511';

  // ---------------------------------------------------------------------------
  // Production ad unit IDs (Android)
  // ---------------------------------------------------------------------------

  static const productionBannerAndroid =
      'ca-app-pub-6871786334119508/9283892443';
  static const productionInterstitialAndroid =
      'ca-app-pub-6871786334119508/4386411683';

  /// Replace when iOS ad units are created in AdMob.
  static const productionBannerIos = 'ca-app-pub-XXXXXXXXXXXXXXXX/YYYYYYYYYY';
  static const productionInterstitialIos =
      'ca-app-pub-XXXXXXXXXXXXXXXX/YYYYYYYYYY';

  // ---------------------------------------------------------------------------
  // Google official test ad unit IDs
  // ---------------------------------------------------------------------------

  static const testBannerAndroid = 'ca-app-pub-3940256099942544/6300978111';
  static const testBannerIos = 'ca-app-pub-3940256099942544/2934735716';
  static const testInterstitialAndroid =
      'ca-app-pub-3940256099942544/1033173712';
  static const testInterstitialIos = 'ca-app-pub-3940256099942544/4411468910';

  /// Minimum gap between interstitial impressions (kids app best practice).
  static const interstitialCooldown = Duration(seconds: 90);

  static String get bannerAdUnitId {
    if (kDebugMode) {
      return defaultTargetPlatform == TargetPlatform.iOS
          ? testBannerIos
          : testBannerAndroid;
    }
    return defaultTargetPlatform == TargetPlatform.iOS
        ? productionBannerIos
        : productionBannerAndroid;
  }

  static String get interstitialAdUnitId {
    if (kDebugMode) {
      return defaultTargetPlatform == TargetPlatform.iOS
          ? testInterstitialIos
          : testInterstitialAndroid;
    }
    return defaultTargetPlatform == TargetPlatform.iOS
        ? productionInterstitialIos
        : productionInterstitialAndroid;
  }
}
