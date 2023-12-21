import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:petdemo/common/app_bar.dart';
import 'package:petdemo/main_screens/chat_screen.dart';
import 'package:petdemo/main_screens/common/bottom_nav_design.dart';
import 'package:petdemo/main_screens/my_screen.dart';
import 'package:petdemo/common/basic_layout.dart';

//찾았어요 버튼을 클릭했을때, 찾았어요 게시판의 상단바와 하단바 유지

class LookingScreen extends StatelessWidget {
  const LookingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/write');
        },
        child: Text(
          '+',
          style: TextStyle(
            fontSize: 44,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      children: [Text('찾고있어요 게시판')],
    );
  }
}

class SearchLookingScreen extends StatelessWidget {
  const SearchLookingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomBar(selectedIndex: 0);
  }
}

class BottomBar extends StatefulWidget {
  final int selectedIndex;

  const BottomBar({Key? key, required this.selectedIndex}) : super(key: key);

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
    LookingScreen(),
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
      body: pages[widget.selectedIndex],
    );
  }
}