import 'package:flutter/material.dart';
import 'package:petdemo/common/app_bar.dart';
import 'package:petdemo/main_screens/chat_screen.dart';
import 'package:petdemo/main_screens/common/bottom_nav_design.dart';
import 'package:petdemo/main_screens/my_screen.dart';
import 'package:petdemo/main_screens/search_screen.dart';


//초기실행화면, 탐색(search)화면의 상단바와 하단바 유지 main은 searchscreen

class InitScreen extends StatelessWidget {
  const InitScreen({Key? key}) : super(key: key);

  @override
   Widget build(BuildContext context) {
     return BottomBar();
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
            Navigator.of(context).pushNamed('/notification');
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