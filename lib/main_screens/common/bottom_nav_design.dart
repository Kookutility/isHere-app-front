import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavDesign extends StatelessWidget {
  final void Function(int)? onTabChange;
  const BottomNavDesign({super.key, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 25),
      child: GNav(
        onTabChange: (value) => onTabChange!(value),
        tabBackgroundColor: Colors.white,
        color: Colors.grey,
        activeColor: Colors.blue,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        tabs: const [
          GButton(
            padding: EdgeInsets.symmetric(vertical: 18, horizontal: 18),
            icon: Icons.search,
            text: "탐색",
            gap: 8,
          ),
          GButton(
            padding: EdgeInsets.symmetric(vertical: 18, horizontal: 18),
            icon: Icons.chat_outlined,
            text: "채팅",
            gap: 8,
          ),
          GButton(
            padding: EdgeInsets.symmetric(vertical: 18, horizontal: 18),
            icon: Icons.person_2,
            text: "나의 정보",
            gap: 8,
          ),
        ],
      ),
    );
  }
}
