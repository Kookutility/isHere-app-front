import 'package:flutter/material.dart';

class BlueGreenButton extends StatelessWidget {
  final Widget child;
  const BlueGreenButton({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 3 / 4,
      height: MediaQuery.of(context).size.height / 15,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color.fromRGBO(78, 64, 234, 1),
            Color.fromRGBO(107, 224, 210, 1),
          ],
        ),
        borderRadius: BorderRadius.circular(70),
      ),
      child: child,
    );
  }
}
