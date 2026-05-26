import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../services/admob_service.dart';
import '../services/banner_ad_service.dart';

/// Adaptive banner for main tab home screens only (Families policy).
class AdBannerWidget extends StatefulWidget {
  const AdBannerWidget({super.key});

  @override
  State<AdBannerWidget> createState() => _AdBannerWidgetState();
}

class _AdBannerWidgetState extends State<AdBannerWidget> {
  final _bannerService = BannerAdService.instance;
  BannerAd? _bannerAd;

  @override
  void initState() {
    super.initState();
    _bannerService.addListener(_onBannerUpdated);
    AdMobService.instance.initializeInBackground();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _requestBanner();
  }

  int _bannerWidth(BuildContext context) {
    return (MediaQuery.sizeOf(context).width - 32).truncate();
  }

  void _requestBanner() {
    if (_bannerAd != null) return;

    final width = _bannerWidth(context);
    final ready = _bannerService.takeBanner(width);
    if (ready != null) {
      _attachBanner(ready);
      return;
    }

    _bannerService.preload(width);
  }

  void _onBannerUpdated() {
    if (!mounted || _bannerAd != null) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || _bannerAd != null) return;
      _requestBanner();
    });
  }

  void _attachBanner(BannerAd banner) {
    setState(() => _bannerAd = banner);
  }

  @override
  void dispose() {
    _bannerService.removeListener(_onBannerUpdated);
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final banner = _bannerAd;

    if (banner != null) {
      return Center(
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(4),
          ),
          child: SizedBox(
            width: banner.size.width.toDouble(),
            height: banner.size.height.toDouble(),
            child: AdWidget(ad: banner),
          ),
        ),
      );
    }

    return const SizedBox(
      height: BannerAdService.placeholderHeight,
    );
  }
}
