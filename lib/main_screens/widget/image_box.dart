import 'package:flutter/material.dart';

class ImageBox extends StatelessWidget {
  final String imageURL;
  final double imageHeight;

  const ImageBox({
    super.key,
    required this.imageURL,
    required this.imageHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      height: imageHeight,
      decoration: BoxDecoration(
        color: Color.fromRGBO(237, 237, 237, 1),
        border: Border.all(
          color: Color.fromRGBO(237, 237, 237, 1),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Image.network(
        imageURL,
        fit: BoxFit.cover,
      ),
    );
  }
}