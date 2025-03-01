import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../services/ads/rewarded_interstitial_ad_helper.dart';

class RewardedInterstitialScreen extends StatefulWidget {
  const RewardedInterstitialScreen({super.key});

  @override
  _RewardedInterstitialScreenState createState() =>
      _RewardedInterstitialScreenState();
}

class _RewardedInterstitialScreenState
    extends State<RewardedInterstitialScreen> {
  late RewardedInterstitialAdHelper _adHelper;

  @override
  void initState() {
    super.initState();
    _adHelper = RewardedInterstitialAdHelper(
      onUserEarnedReward: (RewardItem reward) {
        // Handle the reward
        print('User earned reward of ${reward.amount} ${reward.type}');
      },
      onAdDismissed: () {
        // Handle ad dismissal
        print('Ad was dismissed');
      },
    );
    _adHelper.loadRewardedInterstitialAd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Rewarded Interstitial Ad Example")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _adHelper.showAd();
          },
          child: Text("Show Rewarded Interstitial Ad"),
        ),
      ),
    );
  }
}
