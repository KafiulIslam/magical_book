import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../constants/admob_constants.dart';
import '../services/ad_preload_service.dart';

/// Adaptive banner for main tab home screens only (Families policy).
class AdBannerWidget extends StatefulWidget {
  const AdBannerWidget({
    super.key,
    required this.slotId,
  });

  /// Pre-load slot — must match [AdPreloadService] slot ids.
  final String slotId;

  @override
  State<AdBannerWidget> createState() => _AdBannerWidgetState();
}

class _AdBannerWidgetState extends State<AdBannerWidget> {
  BannerAd? _bannerAd;
  bool _loaded = false;
  bool _loadStarted = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadBanner());
  }

  Future<void> _loadBanner() async {
    if (_loadStarted || !mounted) return;
    _loadStarted = true;

    final preloaded = AdPreloadService.instance.consume(widget.slotId);
    if (preloaded != null) {
      _bannerAd = preloaded;
      if (mounted) setState(() => _loaded = true);
      return;
    }

    final width = MediaQuery.sizeOf(context).width.truncate();
    final adSize =
        await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(width) ??
            AdSize.banner;

    if (!mounted) return;

    _bannerAd = BannerAd(
      adUnitId: AdMobConstants.bannerAdUnitId,
      size: adSize,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          if (!mounted || _bannerAd == null) return;
          setState(() => _loaded = true);
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          if (_bannerAd == ad) _bannerAd = null;
          _loadStarted = false;
          if (mounted) setState(() => _loaded = false);
        },
      ),
    );

    await _bannerAd!.load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ad = _bannerAd;
    if (!_loaded || ad == null) {
      return const SizedBox.shrink();
    }

    final height = ad.size.height.toDouble();
    if (height <= 0) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      width: double.infinity,
      height: height,
      child: AdWidget(ad: ad),
    );
  }
}
