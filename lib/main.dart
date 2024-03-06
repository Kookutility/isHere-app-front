import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:provider/provider.dart';

import 'authentication/auth/firebase_auth/auth_util.dart';
import 'authentication/auth/firebase_auth/firebase_user_provider.dart';
import 'backend/firebase/firebase_config.dart';
import 'flutter_flow/flutter_flow_theme.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'flutter_flow/internationalization.dart';

//**안내**
//-dart 파일은 플러터 플로우(main)의 메인 코드-입니다. -ishere_main.dart 파일은 우리의 ishere 메인 코드-입니다.
//로그인 후 인증되면 메인 화면으로 이동하는 부분은 플러터 플로우에서 로그인하고,
//-nav.dart- 파일에서 인증되면 ishere_main으로 이동하도록 구현되어 있습니다. 이는 go_router를 사용하여 처리됩니다.

//플러터 플로우
//프로필 위젯(ProfileWidget)은 마이페이지
//홈페이지 위젯(chatpageWidget)은 채팅창 목록을 보는 화면이며, 채팅 위젯(ChatWidget)은 하나의 채팅창을 나타내는 화면입니다.
//플러터 플로우 채팅때문에 이런식으로 작동하며 추후 코드 정리 및 수정 예정입니다.  - 작성자  홍택수-

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Flutter 애플리케이션을 실행하기 전에 Flutter 바인딩을 초기화합니다.
  usePathUrlStrategy();

  await NaverMapSdk.instance
      .initialize(clientId: 'raopvm5gte'); // NaverMapSdk 초기화
  // 플랫폼이 안드로이드인 경우 Firebase를 초기화합니다.
  // Firebase.initializeApp() 함수를 통해 Firebase 서비스를 사용할 수 있습니다.
  // FirebaseOptions 객체를 통해 Firebase 프로젝트의 구성 정보를 전달합니다.
  // Firebase 프로젝트의 API 키, 인증 도메인, 프로젝트 ID 등을 설정합니다.
  // FirebaseOptions의 옵션을 설정한 후 Firebase.initializeApp() 함수를 호출하여 Firebase를 초기화합니다.
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: FirebaseOptions(
            apiKey: "AIzaSyD9D9so0lurfFnM-uWRtgRPgSFW4tCu2Mo",
            authDomain: "ishere-7726d.firebaseapp.com",
            projectId: "ishere-7726d",
            storageBucket: "ishere-7726d.appspot.com",
            messagingSenderId: "463768315666",
            appId: "1:463768315666:web:2deed5ef18f8f8567a75cb",
          ),
        )
      : await initFirebase(); // Android가 아닌 경우 initFirebase() 함수를 호출하여 Firebase를 초기화합니다.

  await FlutterFlowTheme.initialize();

  final appState = FFAppState(); // Initialize FFAppState
  await appState.initializePersistedState();

  runApp(ChangeNotifierProvider(
    create: (context) => appState,
    child: IsHere(),
  ));
}

class IsHere extends StatefulWidget {
  const IsHere({super.key});

  // This widget is the root of your application.
  @override
  State<IsHere> createState() => _IsHereState();

  static _IsHereState of(BuildContext context) =>
      context.findAncestorStateOfType<_IsHereState>()!;
}

class _IsHereState extends State<IsHere> {
  Locale? _locale;
  ThemeMode _themeMode = FlutterFlowTheme.themeMode;

  late Stream<BaseAuthUser> userStream; // 테마 모드를 저장하는 변수

  late AppStateNotifier _appStateNotifier; // 사용자 정보를 전달하는 스트림
  late GoRouter _router; // 앱의 라우터를 구성하는 GoRouter 객체

  final authUserSub = authenticatedUserStream.listen((_) {}); // 인증된 사용자 스트림을 구독

  @override
  void initState() {
    super.initState();

    _appStateNotifier = AppStateNotifier.instance; // AppStateNotifier 객체를 초기화
    _router = createRouter(_appStateNotifier); // GoRouter 객체를 생성
    userStream = truChatMainFirebaseUserStream() // 사용자 정보를 전달하는 스트림을 설정
      ..listen((user) => _appStateNotifier.update(user));
    jwtTokenStream.listen((_) {});
    Future.delayed(
      Duration(milliseconds: 1000),
      () => _appStateNotifier.stopShowingSplashImage(),
    );
  }

  @override
  void dispose() {
    authUserSub.cancel(); // 인증된 사용자 스트림을 취소

    super.dispose();
  }

  void setLocale(String language) {
    setState(() => _locale = createLocale(language));
  }

  void setThemeMode(ThemeMode mode) => setState(() {
        _themeMode = mode;
        FlutterFlowTheme.saveThemeMode(mode); // 테마 모드를 변경하고 저장
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'TruChat Main', // 앱의 타이틀 플러터 플로우
      localizationsDelegates: [
        FFLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: _locale,
      supportedLocales: const [Locale('en', '')],
      theme: ThemeData(
        brightness: Brightness.light,
        scrollbarTheme: ScrollbarThemeData(),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scrollbarTheme: ScrollbarThemeData(),
      ),
      themeMode: _themeMode, // 현재 테마 모드
      routerConfig: _router, // 라우터 구성
    );
  }
}
