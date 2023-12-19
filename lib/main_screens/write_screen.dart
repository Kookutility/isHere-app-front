import 'package:flutter/widgets.dart';
import 'package:petdemo/common/basic_layout.dart';

class WriteScreen extends StatelessWidget {
  const WriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      children: [Text('WriteScreen')],
    );
  }
}