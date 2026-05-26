import 'package:flutter/material.dart';

import 'ad_banner_widget.dart';

/// Home tab layout: banner under AppBar, then scrollable content.
/// Banner is only used on main category screens (Families policy).
class HomeTabBody extends StatelessWidget {
  final Widget child;

  const HomeTabBody({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: AdBannerWidget(),
        ),
        const SizedBox(height: 16),
        Expanded(child: child),
      ],
    );
  }
}
