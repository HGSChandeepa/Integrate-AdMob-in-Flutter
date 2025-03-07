import 'package:admob/services/ads/ad_id_config.dart';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAdHelper {
  BannerAd? _bannerAd;
  bool _isLoadingAd = false;
  int _retryAttempt = 0;
  static const int maxRetries = 3;
  static const Duration retryDelay = Duration(seconds: 5);

  void loadBannerAd(Function(BannerAd?, bool) onAdLoaded) {
    if (_isLoadingAd) return;
    _isLoadingAd = true;

    _bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          _isLoadingAd = false;
          _retryAttempt = 0;
          onAdLoaded(_bannerAd, true);
        },
        onAdFailedToLoad: (ad, error) {
          if (kDebugMode) {
            print('Failed to load banner ad: ${error.message}');
          }
          ad.dispose();
          _bannerAd = null;
          _isLoadingAd = false;

          if (_retryAttempt < maxRetries) {
            _retryAttempt++;
            Future.delayed(retryDelay, () {
              loadBannerAd(onAdLoaded);
            });
          } else {
            onAdLoaded(null, false);
          }
        },
      ),
    );

    _bannerAd?.load();
  }

  void disposeBannerAd() {
    _bannerAd?.dispose();
    _bannerAd = null;
    _isLoadingAd = false;
    _retryAttempt = 0;
  }
}
