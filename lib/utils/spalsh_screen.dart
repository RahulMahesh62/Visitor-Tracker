import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

import 'package:visitor_tracker/utils/onboarding.dart';

class SplashScreenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 4,
      navigateAfterSeconds: OnBoardingPage(),
      backgroundColor: Colors.white,
      title: Text(
        'Visitor Tracker',
        style: TextStyle(
          color: Color(0xff6C63FF),
          fontSize: 30,
        ),
      ),
      image: Image.asset("assets/images/splash.png"),
      loadingText: Text(
        "Initializing",
        style: TextStyle(
          color: Colors.black,
          fontSize: 24,
        ),
      ),
      photoSize: 100.0,
      loaderColor: Color(0xff6C63FF),
    );
  }
}
