import 'package:flutter/material.dart';
import 'package:petdemo/main_screens/search_screen.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:petdemo/auth_screens/login_screen.dart';
import 'package:petdemo/auth_screens/sigup_screen.dart';
import 'package:petdemo/auth_screens/splash_screen.dart';
import 'package:petdemo/const/address.dart';
import 'package:petdemo/main_screens/init_screen.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NaverMapSdk.instance.initialize(clientId: 'raopvm5gte'); // NaverMapSdk 초기화
  runApp(const IsHereMain());
}

class IsHereMain extends StatelessWidget {
  const IsHereMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'isHere',
      debugShowCheckedModeBanner: false,
      initialRoute: '/', //
      routes: {
        '/': (context) => const InitScreen(),
        //splashScreen: (context) => const SplashScreen(),
        //loginScreen: (context) => const LogInScreen(),
        //signUpScreen: (context) => const SignUpScreen(),


      },
    );
  }
}