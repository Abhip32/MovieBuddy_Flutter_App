import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_app/Screens/signin_screen.dart';
import 'dart:async';


void main() {
  runApp(
    MaterialApp(
      home: Landing(),
    ),
  );
}
class Landing extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
   /* new Future.delayed(const Duration(seconds: 3), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const SignInScreen()),);
    });*/

    final height = MediaQuery.of(context).size.height;
    /*Future.delayed(const Duration(seconds: 5), (){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SignInScreen()),
      );
    });*/
    return Scaffold(
      body: Center(
        child: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: Image.network(
                'http://store-images.s-microsoft.com/image/apps.1070.14281583492175081.0ddac3b2-54e4-4262-baec-b2867a2d465d.fb1e2dbd-aa34-427b-9a0a-469b27b00e15',
                height: height,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}