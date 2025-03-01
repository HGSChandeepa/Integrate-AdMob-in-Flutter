import 'package:admob/services/ads/banner_ad_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAdWidget extends StatefulWidget {
  final bool isTopAd;

  const BannerAdWidget({super.key, required this.isTopAd});

  @override
  _BannerAdWidgetState createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  final BannerAdHelper _adManager = BannerAdHelper();
  BannerAd? _bannerAd;
  bool _isAdLoaded = false;

  @override
  void initState() {
    super.initState();
    _adManager.loadBannerAd((ad, loaded) {
      if (mounted) {
        setState(() {
          _bannerAd = ad;
          _isAdLoaded = loaded;
        });
      }
    });
  }

  @override
  void dispose() {
    _adManager.disposeBannerAd();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isAdLoaded || _bannerAd == null) return SizedBox.shrink();

    return SizedBox(
      width: _bannerAd!.size.width.toDouble(),
      height: _bannerAd!.size.height.toDouble(),
      child: AdWidget(ad: _bannerAd!),
    );
  }
}
