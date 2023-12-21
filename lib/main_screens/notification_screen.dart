import 'package:flutter/widgets.dart';
import 'package:petdemo/common/basic_layout.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      children: [Text('NotificationScreen')],
    );
  }
}