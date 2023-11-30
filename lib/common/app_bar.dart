import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class IsHereAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onNotificationPressed;
  final VoidCallback? onSearchPressed;

  const IsHereAppBar({
    this.onNotificationPressed,
    this.onSearchPressed,
    Key? key,
  }) : super(key: key);

  Widget buildIconButton(Widget child, VoidCallback? onPressed) {
    return InkWell(
      onTap: onPressed,
      splashColor: Colors.transparent, // 터치했을 때 퍼지는 색을 투명하게 설정
      highlightColor: Colors.transparent, // 터치했을 때 하이라이트 색을 투명하게 설정
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white, // 배경색을 흰색으로 설정
      automaticallyImplyLeading: false, // 뒤로 가기 버튼 제거
      elevation: 0.5, // 그림자 제거
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 20.0), // 오른쪽 간격을 20.0으로 설정
          child: buildIconButton(
            Icon(Icons.search, color: Colors.black, size: 30.0), // 돋보기 아이콘을 기본 아이콘으로 변경
            onSearchPressed,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10.0), // 오른쪽 간격을 10.0으로 설정
          child: buildIconButton(
            Image.asset(
              'assets/icons/notification_black.png',
              width: 30, // width를 조절하여 아이콘의 크기를 변경
              height: 30, // height를 조절하여 아이콘의 크기를 변경
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