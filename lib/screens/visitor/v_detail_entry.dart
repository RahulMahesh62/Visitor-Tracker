import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:visitor_tracker/screens/visitor/models/visitor_model.dart';
import 'package:visitor_tracker/screens/visitor/v_detail_update.dart';

class VisitorDetailEntry extends StatefulWidget {
  @override
  _VisitorDetailEntryState createState() => _VisitorDetailEntryState();
}

class _VisitorDetailEntryState extends State<VisitorDetailEntry> {
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
                "ENTER DETAILS",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff6C63FF),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 120,
                child: _buildListView(),
              ),
              VisitorDetailUpdate(),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildListView() {
  // ignore: deprecated_member_use
  return WatchBoxBuilder(
    box: Hive.box('visitor'),
    builder: (context, visitorBox) {
      return ListView.builder(
        itemCount: visitorBox.length,
        itemBuilder: (context, index) {
          final visitor = visitorBox.getAt(index) as Visitor;
          
          print(visitor.address);
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ListTile(
              title: Text(
                visitor.name,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              subtitle: Text(
                visitor.number.toString(),
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  visitorBox.deleteAt(index);
                },
              ),
            ),
          );
        },
      );
    },
  );
}
