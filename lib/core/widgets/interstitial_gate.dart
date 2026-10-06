import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../services/ad_throttle_service.dart';
import '../services/admob_service.dart';
import '../services/interstitial_ad_service.dart';

/// Shows one interstitial at a lesson exit when an ad is ready and the cooldown
/// has passed. Leaving the lesson continues immediately when no ad is ready.
class InterstitialGate {
  InterstitialGate._();

  static bool _exitInProgress = false;

  /// Lesson back/tab change: show a ready interstitial, then allow the pop.
  static Future<bool> onLessonExit(
    BuildContext context,
    GoRouterState state,
  ) async {
    if (_exitInProgress) return false;
    _exitInProgress = true;
    try {
      final done = Completer<void>();
      runAfterOptionalAd(
        after: () {
          if (!done.isCompleted) done.complete();
        },
      );
      await done.future.timeout(
        const Duration(seconds: 45),
        onTimeout: () {},
      );
      return true;
    } finally {
      _exitInProgress = false;
    }
  }

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
