import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wanas/UserStatus/LoginStatus.dart';
import 'package:flutter/services.dart';
//import 'package:wanas/my/myprofile.dart';
import 'package:wanas/front/profile.dart';
import 'package:wanas/front/welcome.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<bool> checkIsLogin() async {
    Firebase.initializeApp();
    var status = await LoginStatus().readStaus();
    print('get status from prefs: $status');

    return status;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //  theme: ThemeData.dark(),
      // ignore: unrelated_type_equality_checks
      title: 'Wanas',
      home: FutureBuilder(
          future: checkIsLogin(),
          builder: (context, snapshot) {
            if (snapshot.data == true) {
              return Profile();
            } else {
              return Welcome();
            }
          }),
    );
  }
}

//AIzaSyB_gl0t0ykwWyBoCUDG9HTep-xEQSCeC-o
//google maps api key ::: my key
