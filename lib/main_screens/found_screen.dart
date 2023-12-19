import 'package:flutter/widgets.dart';
import 'package:petdemo/common/basic_layout.dart';

class FoundScreen extends StatelessWidget {
  const FoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      children: [Text('찾있어요 게시판')],
    );
  }
}
