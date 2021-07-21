import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:visitor_tracker/screens/administrator/vd.dart';
import 'package:visitor_tracker/screens/administrator/visitor_detail.dart';

class UploadedData extends StatefulWidget {
  @override
  _UploadedDataState createState() => _UploadedDataState();
}

class _UploadedDataState extends State<UploadedData> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user;

  @override
  void initState() {
    getUid();
    super.initState();
  }

  void getUid() {
    User u = _auth.currentUser;
    setState(() {
      user = u;
    });
  }

  String formatTimestamp(Timestamp timestamp) {
    var format =
        new DateFormat.yMMMMd('en_US').add_jm(); // 'hh:mm' for hour & min
    return format.format(timestamp.toDate());
  }

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
          child: Container(
            child: StreamBuilder(
              stream: _db
                  .collection("users")
                  .doc(user.uid)
                  .collection("visitor_details")
                  .orderBy("uploaded_time", descending: true)
                  .snapshots(),
              builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.docs.isNotEmpty) {
                    return ListView(
                      children: snapshot.data.docs.map((snap) {
                        return Padding(
                          padding:
                              const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 0.0),
                          child: Card(
                            child: ListTile(
                              title: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        snap["visitor_details"].substring(0, 17),
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    8.0, 4.0, 4.0, 4.0),
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        formatTimestamp(snap["uploaded_time"])
                                            .toString(),
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              trailing: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.delete_rounded,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  onPressed: () {
                                    _db
                                        .collection("users")
                                        .doc(user.uid)
                                        .collection("visitor_details")
                                        .doc(snap.id)
                                        .delete();
                                    _showDialog();
                                  },
                                ),
                              ),
                              onTap: () {
                                VD vd = new VD(
                                    snap["visitor_details"],
                                    formatTimestamp(snap["uploaded_time"])
                                        .toString());
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => VisitorDetail(
                                              userDetail: vd.userDetail,
                                              uploadedTime: vd.uploadedTime,
                                            )));
                              },
                              contentPadding: EdgeInsets.all(7.0),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            color: Color(0xff6C63FF),
                            elevation: 10,
                          ),
                        );
                      }).toList(),
                    );
                  } else {
                    return Container(
                      child: Center(
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                "UPLOADED DATA",
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff6C63FF),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Image(
                                image: AssetImage("assets/images/no_data.png"),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                "No data uploaded",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red[500],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                }
                return Container(
                  child: Center(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "UPLOADED DATA",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff6C63FF),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Image(
                            image: AssetImage("assets/images/no_data.png"),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "No data uploaded",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.red[500],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Text("Success"),
            content: Text("Visitor record deleted successfully"),
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
  }
}
