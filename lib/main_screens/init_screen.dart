import 'package:flutter/material.dart';
import 'package:petdemo/common/app_bar.dart';
import 'package:petdemo/const/address.dart';
import 'package:petdemo/main_screens/chat_screen.dart';
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

  /*
  * 하단바에 아이콘을 누르면, 누른 
  * 아이콘 순서를 인덱스를 인자로 전달 받고,
  * seletedIndex에 저장한 뒤, rebuild
  */
  void navigateBottomBar(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  // 페이지 리스트, 하단바 아이콘에 따라 body에 display
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
          Navigator.of(context).pushNamed(notificationScreen);
        },
        onSearchPressed: () {
          // 검색 아이콘이 눌렸을 때의 동작
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              selectedIndex == 0
                  ? 'assets/icons/explore_menu_gradation.png'
                  : 'assets/icons/explore_menu_gray.png',
              width: MediaQuery.of(context).size.width / 20,
              height: MediaQuery.of(context).size.width / 20,
            ),
            label: '탐색',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              selectedIndex == 1
                  ? 'assets/icons/chat_menu_gradation.png'
                  : 'assets/icons/chat_menu_gray.png',
              width: MediaQuery.of(context).size.width / 20,
              height: MediaQuery.of(context).size.width / 20,
            ),
            label: '채팅',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              selectedIndex == 2
                  ? 'assets/icons/chat_menu_gradation.png'
                  : 'assets/icons/mypage_menu_gray.png',
              width: MediaQuery.of(context).size.width / 20,
              height: MediaQuery.of(context).size.width / 20,
            ),
            label: '나의 정보',
          ),
        ],
      ),
      body: pages[selectedIndex], // 하단 바에 누른 아이콘에 따라 페이지 display
    );
  }
}
