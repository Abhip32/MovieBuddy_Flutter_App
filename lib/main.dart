import 'package:flutter/material.dart';
import 'package:flutter_app/Screens/landing.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_app/Screens/signin_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await  Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: SignInScreen(),
    );
  }
}