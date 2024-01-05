import 'package:flutter/material.dart';

class PostModel extends StatelessWidget {
  const PostModel({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 5,
            decoration: BoxDecoration(
              color: Color.fromRGBO(237, 237, 237, 1),
              border: Border.all(
                color: Color.fromRGBO(237, 237, 237, 1),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "구의역쪽에서 구찌 반지갑 분실했습니다.",
                style: TextStyle(
                  fontFamily: 'Pretendard-ExtraBold',
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width / 25,
                  color: Colors.black,
                  overflow: TextOverflow.visible,
                ),
              ),
              Row(
                children: [
                  Text(
                    "사례금 : 7,500원",
                    style: TextStyle(
                      fontFamily: 'Pretendard-ExtraBold',
                      fontWeight: FontWeight.w800,
                      fontSize: MediaQuery.of(context).size.width / 27,
                      color: Color.fromRGBO(78, 64, 234, 0.81),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Image.asset("assets/icons/give_immediately.png"),
                ],
              ),
              Text(
                "광진구 구의동: 2시간 전",
                style: TextStyle(
                  fontFamily: 'Pretendard-ExtraBold',
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width / 30,
                  color: Color.fromRGBO(130, 130, 130, 1),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
