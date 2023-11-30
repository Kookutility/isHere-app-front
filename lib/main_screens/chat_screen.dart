import 'package:flutter/widgets.dart';
import 'package:petdemo/common/basic_layout.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      children: [Text('Chat')],
    );
  }
}
