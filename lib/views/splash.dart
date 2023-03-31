import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_practice/views/login.dart';
import 'package:flutter_practice/views/onboarding/onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? userEmail;
  bool? isUserOnBoarded;

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    // TODO: implement initState
    getEmail().whenComplete(() async {
      Timer(const Duration(seconds: 3), () {
        userEmail == null ? _gotoLogin() : isUserOnBoarded == null || isUserOnBoarded == false ?  _gotoOnBoarding():_gotoHome();
      });
    });
    super.initState();
  }

  void _gotoHome() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => const MyHome()));
  }

  void _gotoOnBoarding() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => const OnBoardingScreen()));
  }

  void _gotoLogin() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => const MyLogin()));
  }

  Future getEmail() async {
    final SharedPreferences preferences = await _prefs;
    var email = preferences.getString("email");
    var isOnBoarded = preferences.getBool("isOnBoarded");

    setState(() {
      userEmail = email;
    });
    setState(() {
      isUserOnBoarded = isOnBoarded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: Colors.grey.shade700,
        ),
      ),
    );
  }
}
