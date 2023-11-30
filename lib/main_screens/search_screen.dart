import 'package:flutter/widgets.dart';
import 'package:petdemo/common/basic_layout.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      children: [
        Padding(
          padding: EdgeInsets.only(right: 100, bottom: 520), // 왼쪽과 상단 간격 설정
          child: Text(
            '무엇을 도와드릴까요?',
            style: TextStyle(
              fontFamily: 'Pretendard-ExtraBold', // 원하는 폰트 설정
              fontWeight: FontWeight.w800,
              fontSize: 24,// 원하는 무게 설정
              color: Color.fromRGBO(78, 64, 234, 0.81), // 색상 설정
            ),
          ),
        ),
      ],
    );
  }
}