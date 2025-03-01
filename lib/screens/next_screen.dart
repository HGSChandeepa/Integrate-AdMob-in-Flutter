import 'package:flutter/material.dart';

class NextScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Next Screen")),
      body: Center(
        child: Text(
          "You have successfully navigated after the ad!",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
