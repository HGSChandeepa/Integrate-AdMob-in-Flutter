import 'package:admob/widgets/banner_widget.dart';
import 'package:flutter/material.dart';

class BannerScreen extends StatelessWidget {
  const BannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flutter AdMob Ads")),
      body: Column(
        children: [
          BannerAdWidget(isTopAd: true), // Top Banner

          Expanded(
            child: Center(
              child: Text(
                "Your App Content Here",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),

          BannerAdWidget(isTopAd: false), // Bottom Banner
        ],
      ),
    );
  }
}
