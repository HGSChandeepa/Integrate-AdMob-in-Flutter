import 'package:flutter/material.dart';
import '../ads/banner_ad_widget.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flutter AdMob Ads")),
      body: Column(
        children: [
          // Top Banner Ad
          BannerAdWidget(isTopAd: true),

          Expanded(
            child: Center(
              child: Text(
                "Your App Content Here",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),

          // Bottom Banner Ad
          BannerAdWidget(isTopAd: false),
        ],
      ),
    );
  }
}
