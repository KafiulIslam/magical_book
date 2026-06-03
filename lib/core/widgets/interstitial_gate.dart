import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../services/ad_throttle_service.dart';
import '../services/admob_service.dart';
import '../services/interstitial_ad_service.dart';

/// Shows an interstitial only when allowed; navigation never waits on an ad.
class InterstitialGate {
  InterstitialGate._();

  static void runAfterOptionalAd({
    required VoidCallback after,
  }) {
    if (!AdMobService.instance.isInitialized) {
      InterstitialAdService.instance.preload();
      Future.microtask(after);
      return;
    }

    if (!AdThrottleService.instance.canShowInterstitialNow()) {
      InterstitialAdService.instance.preload();
      Future.microtask(after);
      return;
    }

    if (!InterstitialAdService.instance.isReady) {
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

    var actionRan = false;
    void runAfterOnce() {
      if (actionRan) return;
      actionRan = true;
      Future.microtask(after);
    }

    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (_) {},
      onAdDismissedFullScreenContent: (InterstitialAd dismissed) {
        dismissed.dispose();
        AdThrottleService.instance.recordInterstitialShown();
        InterstitialAdService.instance.preload();
        runAfterOnce();
      },
      onAdFailedToShowFullScreenContent:
          (InterstitialAd dismissed, AdError error) {
        dismissed.dispose();
        if (kDebugMode) {
          debugPrint('Interstitial show failed: ${error.message}');
        }
        InterstitialAdService.instance.preload();
        runAfterOnce();
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
