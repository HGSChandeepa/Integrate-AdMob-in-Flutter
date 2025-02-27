import 'package:admob/ads/ad_helper.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class InterstitialAdHelper {
  InterstitialAd? _interstitialAd;
  final Function onAdDismissed; // Callback when ad is dismissed
  bool _isAdLoading = false;

  InterstitialAdHelper({required this.onAdDismissed});

  // Load Interstitial Ad
  void loadInterstitialAd() {
    if (_isAdLoading || _interstitialAd != null) return;

    _isAdLoading = true;
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          print('Interstitial ad loaded successfully');
          _isAdLoading = false;
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              print('Ad dismissed');
              onAdDismissed();
              ad.dispose();
              loadInterstitialAd();
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              print('Failed to show ad: ${error.message}');
              ad.dispose();
              loadInterstitialAd();
            },
          );
          _interstitialAd = ad;
        },
        onAdFailedToLoad: (err) {
          print('Failed to load interstitial ad: ${err.message}');
          _isAdLoading = false;
          _interstitialAd = null;
        },
      ),
    );
  }

  // Show Interstitial Ad
  void showAd() {
    if (_interstitialAd == null) {
      print('Warning: Attempt to show ad before loading');
      onAdDismissed();
      return;
    }

    _interstitialAd!.show();
  }
}
