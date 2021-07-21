import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:visitor_tracker/screens/visitor/visitor_login.dart';
import 'package:visitor_tracker/screens/visitor/visitor_option.dart';

class VisitorHome extends StatefulWidget {
  @override
  _VisitorHomeState createState() => _VisitorHomeState();
}

class _VisitorHomeState extends State<VisitorHome> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: _auth.authStateChanges(),
        builder: (ctx, AsyncSnapshot<User> snapshot) {
          if (snapshot.hasData) {
            User user = snapshot.data;
            if (user != null) {
              return VisitorOption();
            } else {
              return VisitorLogin();
            }
          }
          return VisitorLogin();
        },
      ),
    );
  }
}
