import 'package:flutter/material.dart';
import 'package:petdemo/main_screens/chat_screen.dart';
import 'package:petdemo/main_screens/common/bottom_nav_design.dart';
import 'package:petdemo/main_screens/my_screen.dart';
import 'package:petdemo/main_screens/search_screen.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

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
      bottomNavigationBar: BottomNavDesign(
        onTabChange: (index) => navigateBottomBar(index),
      ),
      body: pages[selectedIndex],
    );
  }
}
