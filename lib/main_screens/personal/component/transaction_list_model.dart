import 'package:flutter/material.dart';

class TransactionListModel extends StatelessWidget {
  final String title,
      price,
      postedTime,
      imageURL,
      userName,
      userImaegURL,
      doneTime;
  final int done;

  const TransactionListModel({
    super.key,
    required this.title,
    required this.price,
    required this.postedTime,
    required this.imageURL,
    required this.done,
    required this.userName,
    required this.userImaegURL,
    required this.doneTime,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        border: Border.all(
          color: Color.fromARGB(255, 106, 106, 106),
          width: 1,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 6,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  doneTime,
                  style: TextStyle(
                    fontFamily: 'Pretendard-ExtraBold',
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width / 35,
                    color: Colors.black,
                    overflow: TextOverflow.visible,
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Icon(
                    Icons.arrow_forward_ios_sharp,
                    size: MediaQuery.of(context).size.width / 30,
                    color: Color.fromARGB(255, 106, 106, 106),
                  ),
                ),
              ],
            ),
            Divider(
              height: 1,
              color: Color.fromARGB(255, 106, 106, 106),
            ),
            Text(
              '거래 완료',
              style: TextStyle(
                fontFamily: 'Pretendard-ExtraBold',
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.of(context).size.width / 35,
                color: Colors.black,
                overflow: TextOverflow.visible,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    clipBehavior: Clip.hardEdge,
                    width: MediaQuery.of(context).size.width / 5,
                    height: MediaQuery.of(context).size.width / 5,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Color.fromRGBO(237, 237, 237, 1),
                      border: Border.all(
                        color: Color(0xffE6E6E6),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
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
                              fontWeight: FontWeight.w100,
                              fontSize: MediaQuery.of(context).size.width / 30,
                              color: Colors.black,
                            ),
                          ),
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
                                    width:
                                    MediaQuery.of(context).size.width / 20,
                                    height:
                                    MediaQuery.of(context).size.width / 20,
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 203, 201, 201),
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
                                              size: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                                  25,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                    MediaQuery.of(context).size.width / 50,
                                  ),
                                  Text(
                                    userName,
                                    style: TextStyle(
                                      fontSize:
                                      MediaQuery.of(context).size.width /
                                          30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    width:
                                    MediaQuery.of(context).size.width / 50,
                                    height:
                                    MediaQuery.of(context).size.width / 50,
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
                                      fontSize:
                                      MediaQuery.of(context).size.width /
                                          40,
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}