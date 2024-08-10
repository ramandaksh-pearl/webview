import 'dart:async';
import 'package:webview/webview.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(
        const Duration(seconds: 5),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => const HomeScreen())));

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(child: Image.asset('images/img.png')),
      ),
    );
  }
}
