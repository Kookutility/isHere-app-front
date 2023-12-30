import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class IsHereAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onPressed;
  final VoidCallback? onNotificationPressed;
  final VoidCallback? onSearchPressed;
  final String currentLocation; // 텍스트 (현재 위치 데이터를 불러옴)
  final bool showButton;
  const IsHereAppBar({
    this.onPressed,
    this.onNotificationPressed,
    this.onSearchPressed,
    this.currentLocation = "",// 현재 위치가 보이게 될 텍스트를 생성자 파라미터로 추가
    this.showButton = false, // init_screen에서만 실행되도록 하는 버튼(현재 지역) 기본값은 false
    Key? key,
  }) : super(key: key);

  Widget buildIconButton(Widget child, VoidCallback? onPressed) {
    return InkWell(
      onTap: onPressed,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      elevation: 0.5,
      title: Padding(
        padding: const EdgeInsets.only(left: 5.0),
        child: showButton ? Container( // init_screen에서만 실행되도록 하는 버튼(현재 지역) 기본값은 false
          width: 110, //버튼크기
          height: 40, //버튼크기
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.white, // 버튼의 배경색을 흰색으로 설정
              elevation: 2, // 버튼의 그림자 높이 설정
              padding: EdgeInsets.zero,// 패딩을 0으로 설정
              shape: RoundedRectangleBorder(  // 모서리를 둥글게 만들기
                 borderRadius: BorderRadius.circular(30),  // 높은 값일수록 더 둥글게 됨
               ),
            ),
            onPressed: () {Navigator.of(context).pushNamed('/areaSearch');
            },
            child: Row(// Row 위젯을 이용하여 아이콘과 텍스트를 한 줄에 배치
               children: [
                 Padding(
                   padding: EdgeInsets.only(left: 7.5),  // 왼쪽에 5.0만큼의 패딩 추가
                    child: Image.asset('assets/icons/location_purple.png',
                     width: 30,
                     height: 30,
                ),
               ),
              ],
            ),
          ),
        ): Container(), // init_screen이 아니면 빈 컨테이너
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: buildIconButton(
            Icon(Icons.search, color: Colors.black, size: 30.0),
            onSearchPressed,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: buildIconButton(
            Image.asset(
              'assets/icons/notification_black.png',
              width: 30,
              height: 30,
            ),
            onNotificationPressed,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}