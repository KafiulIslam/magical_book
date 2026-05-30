import 'package:flutter/material.dart';

import 'interstitial_gate.dart';

/// Intercepts back from a lesson/detail screen and may show an interstitial
/// before returning to the home tab (Families: natural break only).
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
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        InterstitialGate.runAfterOptionalAdThenPop(context);
      },
      child: child,
    );
  }
}
