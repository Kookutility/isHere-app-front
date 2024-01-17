import 'package:flutter/material.dart';

class NotificationModel extends StatelessWidget {
  final String title, content, postedTime;

  const NotificationModel({
    Key? key,
    required this.title,
    required this.postedTime,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 10,
      padding: const EdgeInsets.only(left: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            clipBehavior: Clip.hardEdge,
            width: MediaQuery.of(context).size.width / 7,
            height: MediaQuery.of(context).size.width / 7,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Image.asset(
              'assets/icons/logo.png',
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  title,
                  softWrap: true,
                  style: TextStyle(
                    fontFamily: 'Pretendard-ExtraBold',
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width / 25,
                    color: Colors.black,
                    overflow: TextOverflow.visible,
                  ),
                ),
                Text(
                  content,
                  softWrap: true,
                  style: TextStyle(
                    fontFamily: 'Pretendard-ExtraBold',
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width / 35,
                    color: Color.fromRGBO(130, 130, 130, 1),
                    overflow: TextOverflow.visible,
                  ),
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
                        fontSize: MediaQuery.of(context).size.width / 30,
                        color: Color.fromRGBO(130, 130, 130, 1),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
