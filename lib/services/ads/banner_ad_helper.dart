import 'package:admob/services/ads/ad_id_config.dart';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAdHelper {
  late BannerAd _bannerAd;

  void loadBannerAd(Function(BannerAd?, bool) onAdLoaded) {
    _bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          onAdLoaded(ad as BannerAd, true);
        },
        onAdFailedToLoad: (ad, err) {
          if (kDebugMode) {
            print('Failed to load banner ad: ${err.message}');
          }
          ad.dispose();
          onAdLoaded(null, false);
        },
      ),
    );

    _bannerAd.load();
  }

  void disposeBannerAd() {
    _bannerAd.dispose();
  }
}
