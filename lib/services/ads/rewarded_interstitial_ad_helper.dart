import 'package:admob/services/ads/ad_id_config.dart';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class RewardedInterstitialAdHelper {
  RewardedInterstitialAd? _rewardedInterstitialAd;
  final Function(RewardItem) onUserEarnedReward;
  final Function onAdDismissed;
  bool _isAdLoading = false;

  RewardedInterstitialAdHelper({
    required this.onUserEarnedReward,
    required this.onAdDismissed,
  });

  void loadRewardedInterstitialAd() {
    if (_isAdLoading || _rewardedInterstitialAd != null) return;

    _isAdLoading = true;
    RewardedInterstitialAd.load(
      adUnitId: AdHelper.rewardedAdUnitId,
      request: AdRequest(),
      rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          if (kDebugMode) {
            print('Rewarded interstitial ad loaded successfully');
          }
          _isAdLoading = false;
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              if (kDebugMode) {
                print('Ad dismissed');
              }
              ad.dispose();
              onAdDismissed();
              loadRewardedInterstitialAd();
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              if (kDebugMode) {
                print('Failed to show ad: ${error.message}');
              }
              ad.dispose();
              loadRewardedInterstitialAd();
            },
          );
          _rewardedInterstitialAd = ad;
        },
        onAdFailedToLoad: (err) {
          if (kDebugMode) {
            print('Failed to load rewarded interstitial ad: ${err.message}');
          }
          _isAdLoading = false;
          _rewardedInterstitialAd = null;
        },
      ),
    );
  }

  void showAd() {
    if (_rewardedInterstitialAd == null) {
      if (kDebugMode) {
        print('Warning: Attempt to show ad before loading');
      }
      onAdDismissed();
      return;
    }

    _rewardedInterstitialAd!.show(
      onUserEarnedReward: (_, reward) {
        onUserEarnedReward(reward);
      },
    );
  }
}
