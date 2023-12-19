import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:petdemo/common/app_bar.dart';
import 'package:petdemo/main_screens/chat_screen.dart';
import 'package:petdemo/main_screens/common/bottom_nav_design.dart';
import 'package:petdemo/main_screens/found_screen.dart';
import 'package:petdemo/main_screens/my_screen.dart';
import 'package:petdemo/main_screens/search_screen.dart';
import 'package:petdemo/main_screens/notification_screen.dart';

class SearchFoundScreen extends StatelessWidget {
  const SearchFoundScreen({Key? key}) : super(key: key);

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
      FoundScreen(),
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

      );
    }
  }