import 'package:flutter/material.dart';
import 'package:petdemo/main_screens/widget/image_box.dart';

class WroteListModel extends StatelessWidget {
  final String title, price, imageURL;
  final int done;

  const WroteListModel({
    super.key,
    required this.title,
    required this.price,
    required this.imageURL,
    required this.done,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
      ),
      clipBehavior: Clip.hardEdge,
      width: MediaQuery.of(context).size.width * 2 / 7,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              ImageBox(
                imageHeight: MediaQuery.of(context).size.height / 7,
                imageURL: imageURL,
              ),
              if (done == 1)
                Text(
                  "사례 완료",
                  style: TextStyle(
                    fontFamily: 'Pretendard-ExtraBold',
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width / 40,
                    color: Colors.white,
                  ),
                ),
            ],
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Pretendard-ExtraBold',
              fontWeight: FontWeight.bold,
              fontSize: MediaQuery.of(context).size.width / 30,
              color: Colors.black,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            "사례금 : $price",
            style: TextStyle(
              fontFamily: 'Pretendard-ExtraBold',
              fontWeight: FontWeight.w100,
              fontSize: MediaQuery.of(context).size.width / 40,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}