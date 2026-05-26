import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../constants/admob_constants.dart';
import 'admob_service.dart';

/// Preloads banners so home tabs can show an ad immediately when possible.
class BannerAdService extends ChangeNotifier {
  BannerAdService._();

  static final BannerAdService instance = BannerAdService._();

  BannerAd? _readyBanner;
  bool _isLoading = false;
  int? _readyForWidth;

  /// Typical adaptive banner height while loading (avoids layout jump).
  static const double placeholderHeight = 50;

  bool get hasReadyBanner => _readyBanner != null;

  /// Starts loading a banner if none is ready for [width].
  Future<void> preload(int width) async {
    if (width <= 0 || _isLoading) return;
    if (_readyBanner != null && _readyForWidth == width) return;

    if (_readyBanner != null && _readyForWidth != width) {
      _readyBanner?.dispose();
      _readyBanner = null;
      _readyForWidth = null;
    }

    if (!AdMobService.instance.isInitialized) return;

    _isLoading = true;
    notifyListeners();

    try {
      final size =
          await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(width);
      if (size == null) {
        _isLoading = false;
        notifyListeners();
        return;
      }

      final banner = BannerAd(
        adUnitId: AdMobConstants.bannerAdUnitId,
        size: size,
        request: const AdRequest(),
        listener: BannerAdListener(
          onAdLoaded: (ad) {
            _readyBanner?.dispose();
            _readyBanner = ad as BannerAd;
            _readyForWidth = width;
            _isLoading = false;
            notifyListeners();
          },
          onAdFailedToLoad: (ad, error) {
            ad.dispose();
            _isLoading = false;
            if (kDebugMode) {
              debugPrint('Banner preload failed: ${error.message}');
            }
            notifyListeners();
          },
        ),
      );

      await banner.load();
    } catch (e) {
      _isLoading = false;
      if (kDebugMode) {
        debugPrint('Banner preload error: $e');
      }
      notifyListeners();
    }
  }

  /// Returns a loaded banner for [width] and starts preloading the next one.
  BannerAd? takeBanner(int width) {
    if (_readyBanner == null || _readyForWidth != width) return null;

    final banner = _readyBanner;
    _readyBanner = null;
    _readyForWidth = null;
    unawaited(preload(width));
    return banner;
  }

  /// Called when AdMob SDK finishes initializing so widgets retry loading.
  void onAdMobReady() {
    notifyListeners();
  }
}
