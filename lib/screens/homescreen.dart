import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeScreen extends StatelessWidget {
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
                height: 25,
              ),
              Text(
                "WELCOME",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff6C63FF),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Image.asset(
                  "assets/images/option.png",
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(
                height: 45,
              ),
              Text(
                "Select type of User",
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Container(
                        height: height * 0.15,
                        width: width * 0.35,
                        decoration: BoxDecoration(
                          color: Color(0xffC6C7C4).withOpacity(0.4),
                          borderRadius: BorderRadius.circular(21),
                        ),
                        // ignore: deprecated_member_use
                        child: FlatButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "/adminoption");
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.admin_panel_settings_outlined,
                                color: Color(0xff6C63FF),
                                size: 45,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Admin",
                                style: TextStyle(
                                  color: Color(0xff6C63FF),
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 35,
                    ),
                    Flexible(
                      child: Container(
                        height: height * 0.15,
                        width: width * 0.35,
                        decoration: BoxDecoration(
                          color: Color(0xffC6C7C4).withOpacity(0.4),
                          borderRadius: BorderRadius.circular(21),
                        ),
                        // ignore: deprecated_member_use
                        child: FlatButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "/visitoroption");
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.person,
                                color: Color(0xff6C63FF),
                                size: 45,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Visitor",
                                style: TextStyle(
                                  color: Color(0xff6C63FF),
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 25,
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
