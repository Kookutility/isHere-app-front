import 'package:flutter/material.dart';

class BlueGreenButton extends StatelessWidget {
  final Widget child;
  final bool? isConfirm;
  final double? width;
  final double? height;
  const BlueGreenButton(
      {super.key,
      required this.child,
      this.isConfirm,
      this.width,
      this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? MediaQuery.of(context).size.width * 3 / 4,
      height: height ?? MediaQuery.of(context).size.height / 15,
      decoration: BoxDecoration(
        boxShadow: isConfirm == null
            ? null
            : [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0, 3),
                  blurRadius: 3,
                )
              ],
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: isConfirm == null
              ? [
                  Color.fromRGBO(78, 64, 234, 1),
                  Color.fromRGBO(107, 224, 210, 1),
                ]
              : [
                  Colors.white,
                  Colors.white,
                ],
        ),
        borderRadius: BorderRadius.circular(70),
      ),
      child: child,
    );
  }
}
