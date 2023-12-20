import 'package:flutter/widgets.dart';
import 'package:petdemo/common/basic_layout.dart';

class LookingScreen extends StatelessWidget {
  const LookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      children: [Text('찾고있어요 게시판')],
    );
  }
}

