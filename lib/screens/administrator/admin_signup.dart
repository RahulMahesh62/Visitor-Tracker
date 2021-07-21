import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminSignUp extends StatefulWidget {
  @override
  _AdminSignUpState createState() => _AdminSignUpState();
}

class _AdminSignUpState extends State<AdminSignUp> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
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
                "ADMIN SIGN-UP",
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
                    "assets/images/signup.png",
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
                        child: Text("SIGN UP"),
                        onPressed: () {
                          _signUp();
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _signUp() async {
    final String emailTXT = _emailController.text.trim();
    final String passwordTXT = _passwordController.text;

    if (emailTXT.isNotEmpty && passwordTXT.isNotEmpty) {
      _auth
          .createUserWithEmailAndPassword(
              email: emailTXT, password: passwordTXT)
          .then((user) {
        //Successful signup
        _db.collection("admin_users").doc(user.user.uid).set({
          "email": emailTXT,
          "last_seen": DateTime.now(),
          "signup_method": user.user.providerData[0].providerId
        });
        //Show success alert-dialog
        showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                title: Text("Success"),
                content: Text("Sign Up successful, you are now logged In!"),
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
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            });
      }).catchError((e) {
        //Show Errors if any
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
                    "OK",
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
