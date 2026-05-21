import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../constants/admob_constants.dart';

/// Loads and shows interstitial ads at natural navigation breaks.
class InterstitialAdService {
  InterstitialAdService._();

  static final InterstitialAdService instance = InterstitialAdService._();

  InterstitialAd? _interstitialAd;
  bool _isLoading = false;
  DateTime? _lastShownAt;

  bool get isReady => _interstitialAd != null;

  void preload() {
    if (_isLoading || _interstitialAd != null) return;

    _isLoading = true;
    InterstitialAd.load(
      adUnitId: AdMobConstants.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          _isLoading = false;
        },
        onAdFailedToLoad: (error) {
          _interstitialAd = null;
          _isLoading = false;
        },
      ),
    );
  }

  bool _canShow() {
    if (_interstitialAd == null) return false;
    if (_lastShownAt == null) return true;
    return DateTime.now().difference(_lastShownAt!) >=
        AdMobConstants.interstitialCooldown;
  }

  /// Intercepts back navigation: show ad if ready, then pop.
  Future<void> handleBackNavigation(BuildContext context) async {
    if (!_canShow()) {
      if (context.mounted) context.pop();
      preload();
      return;
    }

    final ad = _interstitialAd!;
    _interstitialAd = null;

    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (dismissedAd) {
        dismissedAd.dispose();
        _lastShownAt = DateTime.now();
        preload();
        if (context.mounted) context.pop();
      },
      onAdFailedToShowFullScreenContent: (failedAd, error) {
        failedAd.dispose();
        preload();
        if (context.mounted) context.pop();
      },
    );

    ad.show();
  }
}
