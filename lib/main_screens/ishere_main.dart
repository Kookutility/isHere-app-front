import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:petdemo/auth_screens/login_screen.dart';
import 'package:petdemo/auth_screens/sigup_screen.dart';
import 'package:petdemo/auth_screens/splash_screen.dart';
import 'package:petdemo/main_screens/init_screen.dart';
import 'package:petdemo/main_screens/search_found_screen.dart';
import 'package:petdemo/main_screens/search_looking_screen.dart';
import 'package:petdemo/main_screens/notification_screen.dart';
import 'package:petdemo/main_screens/map_screen.dart';
import 'package:petdemo/main_screens/write_screen.dart';
import 'package:petdemo/const/address.dart';

import '../chats/chats_widget.dart';
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
      initialRoute: '/',
      routes: {
        '/': (context) => const InitScreen(), //테스트를 위해 임시로 설정
        splashScreen: (context) => const SplashScreen(),
        loginScreen: (context) => const LogInScreen(),
        signUpScreen: (context) => const SignUpScreen(),
        notificationScreen: (context) => const NotificationScreen(),
        searchLookingScreen: (context) => const SearchLookingScreen(),
        searchFoundScreen: (context) => const SearchFoundScreen(),
        mapScreen: (context) => const MapScreen(),
        writeScreen: (context) => const WriteScreen(),
      },
    );
  }
}