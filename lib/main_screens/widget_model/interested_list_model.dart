import 'package:flutter/material.dart';
import 'package:petdemo/main_screens/widget/image_box.dart';

class InterestedListModel extends StatelessWidget {
  final String title, price, userName, postedTime, imageURL, userImaegURL;
  final int instant;

  const InterestedListModel({
    super.key,
    required this.title,
    required this.price,
    required this.userName,
    required this.postedTime,
    required this.imageURL,
    required this.userImaegURL,
    required this.instant,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
      ),
      clipBehavior: Clip.hardEdge,
      width: MediaQuery.of(context).size.width * 3 / 7,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ImageBox(
                imageHeight: MediaQuery.of(context).size.height / 4,
                imageURL: imageURL,
              ),
              Positioned(
                right: 10,
                top: 10,
                child: Image.asset(
                  'assets/icons/star_purple.png',
                  width: MediaQuery.of(context).size.width / 20,
                  fit: BoxFit.contain,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "사례금 : $price",
                style: TextStyle(
                  fontFamily: 'Pretendard-ExtraBold',
                  fontWeight: FontWeight.w800,
                  fontSize: MediaQuery.of(context).size.width / 30,
                  color: Color.fromRGBO(78, 64, 234, 0.81),
                ),
              ),
              if (instant == 1)
                Image.asset("assets/icons/give_immediately.png"),
            ],
          ),
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        clipBehavior: Clip.hardEdge,
                        width: MediaQuery.of(context).size.width / 20,
                        height: MediaQuery.of(context).size.width / 20,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 203, 201, 201),
                          shape: BoxShape.circle,
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              top: -10,
                              left: -13,
                              child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: MediaQuery.of(context).size.width / 25,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 50,
                      ),
                      Text(
                        userName,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 30,
                  ),
                  Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 50,
                        height: MediaQuery.of(context).size.width / 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xff939393),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        postedTime,
                        style: TextStyle(
                          fontFamily: 'Pretendard-ExtraBold',
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width / 40,
                          color: Color.fromRGBO(130, 130, 130, 1),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}