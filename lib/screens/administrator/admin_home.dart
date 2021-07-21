import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:visitor_tracker/screens/administrator/admin_login.dart';
import 'package:visitor_tracker/screens/administrator/admin_option.dart';


class AdminHome extends StatefulWidget {
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
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
              return AdminOption();
            } else {
              return AdminLogin();
            }
          }
          return AdminLogin();
        },
      ),
    );
  }
}
