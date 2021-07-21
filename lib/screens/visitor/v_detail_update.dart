import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:visitor_tracker/screens/visitor/models/visitor_model.dart';

class VisitorDetailUpdate extends StatefulWidget {
  @override
  _VisitorDetailUpdateState createState() => _VisitorDetailUpdateState();
}

class _VisitorDetailUpdateState extends State<VisitorDetailUpdate> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameControl = TextEditingController();
  final TextEditingController _numberControl = TextEditingController();
  final TextEditingController _addressControl = TextEditingController();

  String _name;
  String _number;
  String _address;

  void addContact(Visitor visitor) {
    final visitorBox = Hive.box('visitor');
    visitorBox.add(visitor);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
                  controller: _nameControl,
                  cursorColor: Color(0xff6C63FF),
                  onSaved: (value) {
                    _name = value;
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter Name",
                    hintStyle: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                      ),
                      child: Icon(
                        Icons.face,
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
                  cursorColor: Color(0xff6C63FF),
                  controller: _numberControl,
                  onSaved: (value) {
                    _number = value;
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter Phone Number",
                    hintStyle: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                      ),
                      child: Icon(
                        Icons.call,
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
                  keyboardType: TextInputType.phone,
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
                  controller: _addressControl,
                  cursorColor: Color(0xff6C63FF),
                  onSaved: (value) {
                    _address = value;
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter Address",
                    hintStyle: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                      ),
                      child: Icon(
                        Icons.home,
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
          SizedBox(
            height: 45,
          ),
          Container(
            height: height * 0.08,
            width: width * 0.8,
            child: ElevatedButton(
              child: Text("ADD DETAILS"),
              onPressed: () {
                _addDetails();
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
    );
  }

  void _addDetails() {
    final String nameTXT = _nameControl.text.trim();
    final String numberTXT = _numberControl.text.trim();
    final String addressTXT = _addressControl.text.trim();

    if (nameTXT.isNotEmpty && numberTXT.isNotEmpty && addressTXT.isNotEmpty && numberTXT.length>=10) {
      _formKey.currentState.save();
      final newVisitor = Visitor(_name, _number, _address);
      addContact(newVisitor);
      _nameControl.text = "";
      _numberControl.text = "";
      _addressControl.text = "";
    } else {
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: Text("Error"),
              content: Text("Please fill all the required fields!"),
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
}
