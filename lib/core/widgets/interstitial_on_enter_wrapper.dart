import 'package:flutter/material.dart';

import '../services/admob_service.dart';
import '../services/interstitial_ad_service.dart';
import 'interstitial_gate.dart';

/// Shows an optional interstitial when the user opens a lesson screen.
class InterstitialOnEnterWrapper extends StatefulWidget {
  final Widget child;

  const InterstitialOnEnterWrapper({
    super.key,
    required this.child,
  });

  @override
  State<InterstitialOnEnterWrapper> createState() =>
      _InterstitialOnEnterWrapperState();
}

class _InterstitialOnEnterWrapperState extends State<InterstitialOnEnterWrapper> {
  bool _attempted = false;

  @override
  void initState() {
    super.initState();
    AdMobService.instance.addListener(_onAdMobReady);
    InterstitialAdService.instance.addListener(_onInterstitialReady);
    WidgetsBinding.instance.addPostFrameCallback((_) => _tryShowInterstitial());
    InterstitialAdService.instance.preload();
  }

  void _onAdMobReady() {
    if (AdMobService.instance.isInitialized) {
      InterstitialAdService.instance.preload();
      _tryShowInterstitial();
    }
  }

  void _onInterstitialReady() {
    _tryShowInterstitial();
  }

  void _tryShowInterstitial() {
    if (!mounted || _attempted) return;
    if (!AdMobService.instance.isInitialized) {
      AdMobService.instance.initialize();
      return;
    }
    if (!InterstitialAdService.instance.isReady) {
      InterstitialAdService.instance.preload();
      return;
    }

    _attempted = true;
    InterstitialGate.runAfterOptionalAd(after: () {});
  }

  @override
  void dispose() {
    AdMobService.instance.removeListener(_onAdMobReady);
    InterstitialAdService.instance.removeListener(_onInterstitialReady);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
