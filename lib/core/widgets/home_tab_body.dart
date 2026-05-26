import 'package:flutter/material.dart';

import 'ad_banner_widget.dart';

/// Home tab layout: banner under AppBar, then scrollable content.
/// Banner is only used on main category screens (Families policy).
class HomeTabBody extends StatelessWidget {
  final Widget child;
  final String bannerSlotId;

  const HomeTabBody({
    super.key,
    required this.child,
    required this.bannerSlotId,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: AdBannerWidget(slotId: bannerSlotId),
        ),
        const SizedBox(height: 16),
        Expanded(child: child),
      ],
    );
  }
}
