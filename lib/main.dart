import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:visitor_tracker/screens/administrator/a_upload.dart';
import 'package:visitor_tracker/screens/administrator/admin_option.dart';
import 'package:visitor_tracker/screens/administrator/a_qr_scan.dart';
import 'package:visitor_tracker/screens/administrator/a_uploaded_data.dart';
import 'package:visitor_tracker/screens/homescreen.dart';
import 'package:visitor_tracker/screens/login.dart';
import 'package:visitor_tracker/screens/signup.dart';
import 'package:visitor_tracker/screens/visitor/models/visitor_model.dart';
import 'package:visitor_tracker/screens/visitor/visitor_option.dart';
import 'package:visitor_tracker/screens/visitor/v_detail_entry.dart';
import 'package:visitor_tracker/screens/visitor/v_qr_gen.dart';
import 'package:visitor_tracker/services/auth_state.dart';
import 'package:visitor_tracker/utils/spalsh_screen.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(VisitorAdapter());
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ));
        showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: Text(notification.title),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body)],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    }, 
                    child: Text("OK"),
                  ),
                ],
              );
            });
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: Text(notification.title),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body)],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    }, 
                    child: Text("OK"),
                  ),
                ],
              );
            });
      }
    });
  }

  @override
  void dispose() {
    Hive.box('visitor').compact();
    Hive.close();
    super.dispose();
  }

  Widget buildError(BuildContext context, FlutterErrorDetails error) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/images/Error.png",
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // themeMode: ThemeMode.system,
      title: "Visitor-Tracker",
      theme: ThemeData(
        fontFamily: GoogleFonts.rubik().fontFamily,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      builder: (BuildContext context, Widget widget) {
        ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
          return buildError(context, errorDetails);
        };
        return widget;
      },
      home: SplashScreenPage(),
      routes: {
        "/home": (context) => HomeScreen(),
        "/login": (context) => LoginScreen(),
        "/signup": (context) => SignUpScreen(),
        "/auth": (context) => Auth(),
        "/visitoroption": (context) => VisitorOption(),
        "/visitordetails": (context) => FutureBuilder(
              future: Hive.openBox(
                'visitor',
                compactionStrategy: (int total, int deleted) {
                  return deleted > 35;
                },
              ),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError)
                    return Text(snapshot.error.toString());
                  else
                    return VisitorDetailEntry();
                } else
                  return Scaffold();
              },
            ),
        "/qrcodegenerator": (context) => FutureBuilder(
              future: Hive.openBox(
                'visitor',
                compactionStrategy: (int total, int deleted) {
                  return deleted > 35;
                },
              ),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError)
                    return Text(snapshot.error.toString());
                  else
                    return QRCodeGenerator();
                } else
                  return Scaffold();
              },
            ),
        "/adminoption": (context) => AdminOption(),
        "/qrcodescanner": (context) => QRCodeScanner(),
        "/uploaddata": (context) => UploadData(),
        "/uploadeddata": (context) => UploadedData(),
      },
    );
  }
}
