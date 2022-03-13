// @dart=2.9
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:shopsmart/Assets/AppColors.dart';
import 'package:shopsmart/Pages/SplashPage.dart';
import 'package:shopsmart/Pages/SignupPage.dart';
import 'package:shopsmart/Utils/LogUtils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.black));

  // await Firebase.initializeApp().then((value) {
  //   LogUtils.log('Firebase init succeed');
  // });

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,  home: SignupPage());

        // home: SplashPage());
  }
}
