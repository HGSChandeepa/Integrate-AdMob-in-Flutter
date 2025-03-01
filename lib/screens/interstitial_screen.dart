import 'package:admob/screens/next_screen.dart';
import 'package:flutter/material.dart';
import '../services/ads/interstitial_ad_helper.dart';

class InterstitialAdScreen extends StatefulWidget {
  const InterstitialAdScreen({super.key});

  @override
  _InterstitialAdScreenState createState() => _InterstitialAdScreenState();
}

class _InterstitialAdScreenState extends State<InterstitialAdScreen> {
  late InterstitialAdHelper _adHelper;

  @override
  void initState() {
    super.initState();
    _adHelper = InterstitialAdHelper(
      onAdDismissed: () {
        // Navigate to the next screen after the ad is closed
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NextScreen()),
        );
      },
    );
    _adHelper.loadInterstitialAd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Interstitial Ad Example")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _adHelper.showAd();
          },
          child: Text("Show Interstitial Ad"),
        ),
      ),
    );
  }
}
