// ignore_for_file: unused_import, prefer_final_fields, unused_field

import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late StreamSubscription subscription;
  late WebViewController _webViewController;
  bool isDeviceConnected = false;
  bool isAlertSet = false;
  bool hasLoadedWebView = false;
  int _currentIndex = 0;
  final String _webUrl = 'https://jakubs-plants.com/';
  @override
  void initState() {
    super.initState();
    _webViewController = WebViewController();
    _webViewController
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(_webUrl));
    getConnectivity();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  getConnectivity() {
    subscription = Connectivity().onConnectivityChanged.listen(
          (ConnectivityResult result) async {
        isDeviceConnected = await InternetConnectionChecker().hasConnection;
        if (isDeviceConnected && !hasLoadedWebView) {
          loadWebView();
        } else if (!isDeviceConnected && !isAlertSet) {
          showDialogBox();
          setState(() => isAlertSet = true);
        }
      },
    );
  }

  loadWebView() {
    hasLoadedWebView = true;
    setState(() {});
  }

  showDialogBox() {
    showCupertinoDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: Colors.white,
        title: const Text('No Connection'),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              Navigator.pop(context, 'Cancel');
              setState(() => isAlertSet = false);
              isDeviceConnected =
              await InternetConnectionChecker().hasConnection;
              if (!isDeviceConnected && !isAlertSet) {
                showDialogBox();
                setState(() => isAlertSet = true);
              }
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await _webViewController.canGoBack()) {
          _webViewController.goBack();
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: isDeviceConnected
              ? WebViewWidget(
            controller: _webViewController,
          )
              : const Center(
            child:
            CupertinoActivityIndicator(radius: 25,),
            //Text('Please Wait'),
          ),
        ),
      ),
    );
  }
}
