import 'package:flutter/material.dart';
import 'package:petdemo/auth_screens/login_screen.dart';
import 'package:petdemo/auth_screens/sigup_screen.dart';
import 'package:petdemo/auth_screens/splash_screen.dart';
import 'package:petdemo/const/address.dart';

void main() {
  runApp(const IsHere());
}

class IsHere extends StatelessWidget {
  const IsHere({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'isHere',
      debugShowCheckedModeBanner: false,
      initialRoute: splashScreen,
      routes: {
        splashScreen: (context) => const SplashScreen(),
        loginScreen: (context) => const LogInScreen(),
        signUpScreen: (context) => const SignUpScreen(),
      },
    );
  }
}
