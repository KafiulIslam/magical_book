/// Production AdMob IDs for the Shishu Path Android release.
///
/// The app ID must match `com.google.android.gms.ads.APPLICATION_ID`
/// in android/app/src/main/AndroidManifest.xml.
class AdMobConstants {
  AdMobConstants._();

  static const androidAppId = 'ca-app-pub-6871786334119508~7611803840';

  static const bannerAdUnitId = 'ca-app-pub-6871786334119508/9283892443';

  static const interstitialAdUnitId = 'ca-app-pub-6871786334119508/4386411683';

  /// Minimum gap between interstitial impressions.
  /// A few minutes keeps the ad at a natural break between lessons.
  static const interstitialCooldown = Duration(minutes: 3);
}
