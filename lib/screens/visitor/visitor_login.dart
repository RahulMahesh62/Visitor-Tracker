import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

class VisitorLogin extends StatefulWidget {
  @override
  _VisitorLoginState createState() => _VisitorLoginState();
}

class _VisitorLoginState extends State<VisitorLogin> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

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
                  width: width * 0.8,
                  child: Image.asset(
                    "assets/images/login.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                      ),
                      child: Container(
                        height: height * 0.07,
                        width: width * 0.8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(21),
                          color: Color(0xffC6C7C4).withOpacity(0.5),
                        ),
                        child: Center(
                          child: TextFormField(
                            controller: _emailController,
                            cursorColor: Color(0xff6C63FF),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Enter Email",
                              hintStyle: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0,
                                ),
                                child: Icon(
                                  Icons.email_outlined,
                                  color: Colors.grey,
                                  size: 25,
                                ),
                              ),
                            ),
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                      ),
                      child: Container(
                        height: height * 0.07,
                        width: width * 0.8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(21),
                          color: Color(0xffC6C7C4).withOpacity(0.5),
                        ),
                        child: Center(
                          child: TextFormField(
                            controller: _passwordController,
                            cursorColor: Color(0xff6C63FF),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Enter Password",
                              hintStyle: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0,
                                ),
                                child: Icon(
                                  Icons.lock,
                                  color: Colors.grey,
                                  size: 25,
                                ),
                              ),
                            ),
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                            textInputAction: TextInputAction.next,
                            obscureText: true,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      height: height * 0.08,
                      width: width * 0.8,
                      child: ElevatedButton(
                        child: Text("LOGIN"),
                        onPressed: () {
                          _signIn();
                        },
                        style: TextButton.styleFrom(
                          elevation: 0.0,
                          backgroundColor: Color(0xff6C63FF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(21),
                          ),
                          textStyle: TextStyle(
                            fontSize: 24,
                          ),
                          padding: EdgeInsets.all(8.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextButton(
                      child: Text(
                        "New here? Sign Up using Email",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xff6C63FF),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, "/visitorsignup");
                      },
                    ),
                    SizedBox(
                      height: 13,
                    ),
                    InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FaIcon(
                            FontAwesomeIcons.google,
                            color: Colors.red,
                            size: 22,
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          TextButton(
                            child: Text(
                              'Login using Google',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.red,
                              ),
                            ),
                            onPressed: () {
                              _signInUsingGoogle();
                            },
                          ),
                        ],
                      ),
                      onTap: () {},
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

  void _signIn() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text;

    if (email.isNotEmpty && password.isNotEmpty) {
      _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((user) {
        _db.collection("visitor_users").doc(user.user.uid).set({
          "email": email,
          "last_seen": DateTime.now(),
          "signup_method": user.user.providerData[0].providerId
        });
        showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                title: Text("Success"),
                content: Text("Sign In Success"),
                actions: <Widget>[
                  // ignore: deprecated_member_use
                  FlatButton(
                    child: Text(
                      "OK",
                      style: TextStyle(
                        color: Color(0xff6C63FF),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                  ),
                ],
              );
            });
      }).catchError((e) {
        showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                title: Text("Error"),
                content: Text("${e.message}"),
                actions: <Widget>[
                  // ignore: deprecated_member_use
                  FlatButton(
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                  ),
                ],
              );
            });
      });
    } else {
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: Text("Error"),
              content: Text("Please provide Email and Password!"),
              actions: <Widget>[
                // ignore: deprecated_member_use
                FlatButton(
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                ),
                // ignore: deprecated_member_use
                FlatButton(
                  child: Text(
                    "OK",
                    style: TextStyle(
                      color: Color(0xff6C63FF),
                    ),
                  ),
                  onPressed: () {
                    _emailController.text = "";
                    _passwordController.text = "";
                    Navigator.of(ctx).pop();
                  },
                ),
              ],
            );
          });
    }
  }

  void _signInUsingGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      final User user = (await _auth.signInWithCredential(credential)).user;
      print("Signed In " + user.displayName);

      if (user != null) {
        //Successful signup
        _db.collection("visitor_users").doc(user.uid).set({
          "displayName": user.displayName,
          "email": user.email,
          "last_seen": DateTime.now(),
          "signup_method": user.providerData[0].providerId
        });
      }
    } catch (e) {
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: Text("Error"),
              content: Text("${e.message}"),
              actions: <Widget>[
                // ignore: deprecated_member_use
                FlatButton(
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                ),
              ],
            );
          });
    }
  }
}
