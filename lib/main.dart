// ignore_for_file: unused_import, camel_case_types, unnecessary_import

import 'package:webview/splash_screen.dart';
import 'package:webview/webview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


void main() => runApp(const webapp());

class webapp extends StatelessWidget {
  const webapp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: HomeScreen(),
      ),
    );
  }
}
