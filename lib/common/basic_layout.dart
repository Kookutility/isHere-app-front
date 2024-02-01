import 'package:flutter/material.dart';

class MainLayout extends StatelessWidget {
  final List<Widget> children;
  final FloatingActionButton? floatingActionButton;
  final PreferredSizeWidget? appBar;
  const MainLayout({
    Key? key,
    required this.children,
    this.floatingActionButton,
    this.appBar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        floatingActionButton: floatingActionButton,
        backgroundColor: Colors.white,
        appBar: appBar,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: ClampingScrollPhysics(), // 파란색 바운스 효과 제거
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
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