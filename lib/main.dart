import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'ads/interstitial_ad_helper.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late InterstitialAdHelper _adHelper;

  @override
  void initState() {
    super.initState();
    _adHelper = InterstitialAdHelper(onAdDismissed: _moveToNextScreen);
    _adHelper.loadInterstitialAd(); // Load ad when app starts
  }

  void _moveToNextScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SecondScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Interstitial Ad Example")),
      // body: Center(
      //   child: ElevatedButton(
      //     onPressed: () {
      //       _adHelper
      //           .showAd(); // Show ad and move to next screen after dismissal
      //     },
      //     child: Text("Show Interstitial Ad"),
      //   ),
      // ),
      body: HomeScreen(),
    );
  }
}

// Example Second Screen
class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Next Screen")),
      body: Center(child: Text("You moved to the next screen!")),
    );
  }
}
