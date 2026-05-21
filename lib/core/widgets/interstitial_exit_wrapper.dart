import 'package:flutter/material.dart';

import '../services/interstitial_ad_service.dart';

/// Shows an interstitial (when ready) before popping a detail screen.
class InterstitialExitWrapper extends StatelessWidget {
  final Widget child;

  const InterstitialExitWrapper({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        await InterstitialAdService.instance.handleBackNavigation(context);
      },
      child: child,
    );
  }
}
