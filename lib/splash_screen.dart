import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:webview/webview.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _fadeAnimation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn);

    _animationController.forward();

    // Navigate to the HomeScreen after the animation is done
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.of(context).pushReplacement(
          CupertinoPageRoute(builder: (_) => const HomeScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Your app image here with rounded borders
              Container(
                padding: EdgeInsets.symmetric(vertical: screenHeight * .01,  horizontal: screenWidth * .01),
                margin: EdgeInsets.symmetric(vertical: screenHeight * .01,  horizontal: screenWidth * .01),
                width: screenWidth * 0.9,
                height: screenHeight * 0.4,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Image(
                  image: const NetworkImage('https://jakubs-plants.com/assets/images/logo.jpg'),
                  width: screenWidth * 0.5,
                  height: screenHeight * 0.3,
                  fit: BoxFit.contain, // Ensures the image covers the widget bounds
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
