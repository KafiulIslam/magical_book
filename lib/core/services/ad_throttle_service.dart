import '../constants/admob_constants.dart';

/// App-wide minimum gap between full-screen interstitial impressions.
class AdThrottleService {
  AdThrottleService._();

  static final AdThrottleService instance = AdThrottleService._();

  DateTime? _lastInterstitialShownAt;

  bool canShowInterstitialNow() {
    if (_lastInterstitialShownAt == null) return true;
    return DateTime.now().difference(_lastInterstitialShownAt!) >=
        AdMobConstants.interstitialCooldown;
  }

  void recordInterstitialShown() {
    _lastInterstitialShownAt = DateTime.now();
  }
}
