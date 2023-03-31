import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/views/home.dart';
import 'package:flutter_practice/views/login.dart';
import 'package:flutter_practice/views/onboarding/onboarding_screen.dart';
import 'package:flutter_practice/views/register.dart';
import 'package:flutter_practice/views/splash.dart';

/// Requires that a Firebase local emulator is running locally.
/// See https://firebase.flutter.dev/docs/auth/start/#optional-prototype-and-test-with-firebase-local-emulator-suite
bool shouldUseFirebaseEmulator = false;

late final FirebaseApp app;
late final FirebaseAuth auth;

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  // We store the app and auth to make testing with a named instance easier.
  app = await Firebase.initializeApp();
  auth = FirebaseAuth.instanceFor(app: app);

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'splash',
    routes: {
      'splash' : (context) => SplashScreen(),
      'login' : (context) => MyLogin(),
      'register' : (context) => MyRegister(),
      'onboarding' : (context) => OnBoardingScreen(),
      'home' : (context) => MyHome()
    }
  ));
}
