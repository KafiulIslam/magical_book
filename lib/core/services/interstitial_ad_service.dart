import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../constants/admob_constants.dart';
import 'admob_service.dart';

/// Loads and caches one interstitial for lesson-exit navigation breaks.
class InterstitialAdService extends ChangeNotifier {
  InterstitialAdService._();

  static final InterstitialAdService instance = InterstitialAdService._();

  static const _maxLoadAttempts = 5;
  static const _retryDelay = Duration(seconds: 3);

  InterstitialAd? _interstitialAd;
  bool _isLoading = false;
  int _loadAttempts = 0;
  Timer? _retryTimer;

  bool get isReady => _interstitialAd != null;

  void preload() {
    if (!AdMobService.instance.isInitialized) {
      AdMobService.instance.initialize();
      return;
    }
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
          _retryTimer?.cancel();
          notifyListeners();
        },
        onAdFailedToLoad: (error) {
          _interstitialAd = null;
          _isLoading = false;
          if (kDebugMode) {
            debugPrint('Interstitial load failed: ${error.message}');
          }
          _scheduleRetry();
          notifyListeners();
        },
      ),
    );
  }

  void _scheduleRetry() {
    _loadAttempts++;
    if (_loadAttempts > _maxLoadAttempts) return;

    _retryTimer?.cancel();
    _retryTimer = Timer(_retryDelay, () {
      if (_interstitialAd != null) return;
      preload();
    });
  }

  /// Removes and returns the cached ad when it is about to be shown.
  InterstitialAd? takeReadyAd() {
    final ad = _interstitialAd;
    _interstitialAd = null;
    return ad;
  }

  void disposeCached() {
    _retryTimer?.cancel();
    _interstitialAd?.dispose();
    _interstitialAd = null;
    _isLoading = false;
  }
}
