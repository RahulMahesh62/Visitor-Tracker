import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class VisitorOption extends StatefulWidget {
  @override
  _VisitorOptionState createState() => _VisitorOptionState();
}

class _VisitorOptionState extends State<VisitorOption> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 30,
              ),
              Text(
                "WELCOME VISITOR",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff6C63FF),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  width: width * 0.5,
                  child: Image.asset(
                    "assets/images/visitor.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  children: [
                    Container(
                      height: height * 0.07,
                      width: width * 0.8,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/visitordetails");
                        },
                        child: Center(
                          child: Text(
                            "Enter personal details",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: Color(0xffC6C7C4).withOpacity(0.5),
                          elevation: 0.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(21),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  children: [
                    Container(
                      height: height * 0.07,
                      width: width * 0.8,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/qrcodegenerator");
                        },
                        child: Center(
                          child: Text(
                            "Generate QR Code",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: Color(0xffC6C7C4).withOpacity(0.5),
                          elevation: 0.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(21),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  children: [
                    Container(
                      height: height * 0.08,
                      width: width * 0.8,
                      child: ElevatedButton(
                        onPressed: () async {
                          await _auth.signOut();
                          _googleSignIn.signOut();
                          Navigator.of(context).pop();
                        },
                        child: Center(
                          child: Text(
                            "LOGOUT",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: Color(0xff6C63FF),
                          elevation: 0.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(21),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
