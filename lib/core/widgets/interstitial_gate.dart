import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../services/ad_throttle_service.dart';
import '../services/interstitial_ad_service.dart';

/// Shows an interstitial only when allowed; navigation never waits on an ad.
class InterstitialGate {
  InterstitialGate._();

  static void runAfterOptionalAd({
    required VoidCallback after,
  }) {
    if (!AdThrottleService.instance.canShowInterstitialNow() ||
        !InterstitialAdService.instance.isReady) {
      InterstitialAdService.instance.preload();
      Future.microtask(after);
      return;
    }

    final ad = InterstitialAdService.instance.takeReadyAd();
    if (ad == null) {
      InterstitialAdService.instance.preload();
      Future.microtask(after);
      return;
    }

    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (InterstitialAd dismissed) {
        dismissed.dispose();
        AdThrottleService.instance.recordInterstitialShown();
        InterstitialAdService.instance.preload();
        Future.microtask(after);
      },
      onAdFailedToShowFullScreenContent:
          (InterstitialAd dismissed, AdError error) {
        dismissed.dispose();
        InterstitialAdService.instance.preload();
        Future.microtask(after);
      },
    );

    ad.show();
  }

  /// Natural break: optional interstitial, then pop the current lesson screen.
  static void runAfterOptionalAdThenPop(BuildContext context) {
    runAfterOptionalAd(
      after: () {
        if (context.mounted) {
          context.pop();
        }
      },
    );
  }
}
