import 'package:flutter/widgets.dart';
import 'package:petdemo/common/basic_layout.dart';

class AreaSeacrhScreen extends StatelessWidget {
  const AreaSeacrhScreen({super.key});
//상단바에서 게시판 지역 검색
  @override
  Widget build(BuildContext context) {
    return MainLayout(
      children: [Text('AreaSeacrhScreen')],
    );
  }
}