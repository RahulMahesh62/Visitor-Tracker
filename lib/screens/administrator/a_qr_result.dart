import 'package:flutter/material.dart';

class QRCodeResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            height: height,
            width: width,
            color: Colors.white,
            child: Center(
              child: Text(
                "QR CODE RESULT",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff6C63FF),
                ),
              ),
            )),
      ),
    );
  }
}
