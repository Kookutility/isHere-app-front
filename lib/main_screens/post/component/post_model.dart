import 'package:flutter/material.dart';

class PostModel extends StatelessWidget {
  final String title, price, deal, place, postedTime, imageURL;
  const PostModel({
    super.key,
    required this.title,
    required this.price,
    required this.deal,
    required this.place,
    required this.postedTime,
    required this.imageURL,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            clipBehavior: Clip.hardEdge,
            width: MediaQuery.of(context).size.width / 5,
            height: MediaQuery.of(context).size.width / 5,
            decoration: BoxDecoration(
              color: Color.fromRGBO(237, 237, 237, 1),
              border: Border.all(
                color: Color.fromRGBO(237, 237, 237, 1),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Image.network(
              imageURL,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                title.length > 16 ? title.substring(0, 16) + '...' : title,
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
                    "사례금 : $price",
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
                  if (deal == '1') Image.asset("assets/icons/give_immediately.png"),
                ],
              ),
              Text(
                "$place: $postedTime",
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
