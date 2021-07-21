import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeGenerator extends StatefulWidget {
  @override
  _QRCodeGeneratorState createState() => _QRCodeGeneratorState();
}

class _QRCodeGeneratorState extends State<QRCodeGenerator> {
  String qrData = "";
  @override
  void initState() {
    final visitorBox = Hive.box('visitor');
    final visitor = visitorBox.getAt(0);
    qrData = "" + visitor.name + " & " + visitor.number + " & " + visitor.address;
    print(qrData);
    super.initState();
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 25,
                ),
                Text(
                  "GENERATED QR CODE",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff6C63FF),
                  ),
                ),
                SizedBox(
                  height: 55,
                ),
                QrImage(
                  data: qrData,
                  version: QrVersions.auto,
                  size: 275.0,
                  errorStateBuilder: (cxt, err) {
                    return Container(
                      child: Center(
                        child: Text(
                          "No data given to generate QR Code",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  },
                ),
              ],
            )),
      ),
    );
  }
}
