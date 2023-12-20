import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nepal_wanderer/pages/homepage_screen.dart';
import 'package:nepal_wanderer/pages/registration_screen.dart';

import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static const String routeName = "/splash";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    navigate();
    super.initState();
  }

  void navigate() async {
    await Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Expanded(
            child: Center(
              child: Container(
                width: double.infinity,
                child: Lottie.asset(
                  "assets/animations/loader-splash.json",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
