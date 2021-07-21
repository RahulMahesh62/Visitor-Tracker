import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:introduction_screen/introduction_screen.dart';

import 'package:visitor_tracker/services/auth_state.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => Auth()),
      (route) => false,
    );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset("assets/images/$assetName", width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(
        fontSize: 28.0,
        fontWeight: FontWeight.w700,
        color: Color(0xff6C63FF),
      ),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      pages: [
        PageViewModel(
          title: "Welcome to VisitorTracker",
          body:
              "A modern solution to register your footprints at public places",
          image: _buildImage('welcome.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "You choose what you need",
          body:
              "Use application either as Admin or Visitor depending upon your need",
          image: _buildImage('both.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Pass your details as Visitor",
          body:
              "Enter and locally save your details. Generate and show QR code at public places to mark your footprint",
          image: _buildImage('ovisitor.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Collect visitor details as Admin",
          body:
              "Collect visitor details by scanning their QR code and upload them to the online database",
          image: _buildImage('oadmin.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Manage and Notify your visitors",
          body:
              "Manage your visitors as Admin and send push notifications to the visitors in case of any emergency",
          image: _buildImage('local-notif.png'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      //rtl: true, // Display as right-to-left
      skip: InkWell(
        child: const Text(
          'Skip',
          style: TextStyle(
            fontSize: 20,
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: () => _onIntroEnd(context),
      ),
      next: const Icon(
        Icons.arrow_forward,
        size: 30,
        color: Color(0xff6C63FF),
      ),
      done: const Text('Done',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xff6C63FF),
          )),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Colors.grey,
        activeColor: Color(0xff6C63FF),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
