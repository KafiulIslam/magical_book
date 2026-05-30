import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../constants/admob_constants.dart';
import 'admob_service.dart';

/// Loads and caches one interstitial at a time for natural navigation breaks.
class InterstitialAdService {
  InterstitialAdService._();

  static final InterstitialAdService instance = InterstitialAdService._();

  static const _maxLoadAttempts = 3;

  InterstitialAd? _interstitialAd;
  bool _isLoading = false;
  int _loadAttempts = 0;

  bool get isReady => _interstitialAd != null;

  void preload() {
    if (!AdMobService.instance.isInitialized) return;
    if (_isLoading || _interstitialAd != null) return;

    _isLoading = true;
    InterstitialAd.load(
      adUnitId: AdMobConstants.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          _isLoading = false;
          _loadAttempts = 0;
        },
        onAdFailedToLoad: (error) {
          _interstitialAd = null;
          _isLoading = false;
          _loadAttempts++;
          if (kDebugMode) {
            debugPrint('Interstitial load failed: ${error.message}');
          }
          if (_loadAttempts <= _maxLoadAttempts) {
            preload();
          }
        },
      ),
    );
  }

  /// Removes and returns the cached ad when it is about to be shown.
  InterstitialAd? takeReadyAd() {
    final ad = _interstitialAd;
    _interstitialAd = null;
    return ad;
  }
}
