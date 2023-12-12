import 'package:flutter/material.dart';
import 'package:petdemo/common/app_bar.dart';
import 'package:petdemo/main_screens/chat_screen.dart';
import 'package:petdemo/main_screens/common/bottom_nav_design.dart';
import 'package:petdemo/main_screens/my_screen.dart';
import 'package:petdemo/main_screens/search_screen.dart';
import 'package:petdemo/main_screens/notification_screen.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:petdemo/main_screens/map_screen.dart'; // 여기서 map.dart를 import해야 합니다.

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NaverMapSdk.instance.initialize(clientId: 'raopvm5gte'); // NaverMapSdk 초기화
  runApp(const IsHere());
}

class IsHere extends StatelessWidget {
  const IsHere({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'isHere',
      debugShowCheckedModeBanner: false,
      home: const BottomBar(), // Scaffold의 home을 BottomBar로 변경
    );
  }
}

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int selectedIndex = 0;

  void navigateBottomBar(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  List<Widget> pages = const [
    SearchScreen(),
    ChatScreen(),
    MyScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: IsHereAppBar(
        onNotificationPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NotificationScreen(), // main_screens/notification_screen.dart로 이동
            ),
          );
        },
        onSearchPressed: () {
          // 검색 아이콘이 눌렸을 때의 동작
        },
      ),
      bottomNavigationBar: BottomNavDesign(
        onTabChange: (index) => navigateBottomBar(index),
      ),
      body: pages[selectedIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MapScreen(), // map_screen.dart으로 이동
            ),
          );
        },
        child: Icon(Icons.map),
      ),
    );
  }
}