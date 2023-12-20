import 'package:flutter/material.dart';

class MainLayout extends StatelessWidget {
  final List<Widget> children;
  final FloatingActionButton? floatingActionButton;

  const MainLayout({
    Key? key,
    required this.children,
    this.floatingActionButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        floatingActionButton: floatingActionButton,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              physics: ClampingScrollPhysics(), // 파란색 바운스 효과 제거
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: children,
              ),
            ),
          ),
        ),
      ),
    );
  }
}