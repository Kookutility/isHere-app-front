import 'package:flutter/material.dart';

import 'package:petdemo/common/const/address.dart';

class MyScreen extends StatelessWidget {
  const MyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void onNotificationPressed() {
      Navigator.of(context).pushNamed(notificationScreen);
    }

    void onWrotePressed() {
      Navigator.of(context).pushNamed(wroteListScreen);
    }

    void modifyPersonalInfo() {}

    void onInterestedPressed() {
      Navigator.of(context).pushNamed(interestedListScreen);
    }

    void onTransactionPressed() {
      Navigator.of(context).pushNamed(transactionRecordScreen);
    }

    void onKeywordNotificationPressed() {}

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                '나의 정보',
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  color: Color(0xff4e40ea),
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width / 20,
                ),
              ),
            ),
            Divider(),
            GestureDetector(
              onTap: modifyPersonalInfo,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Container(
                      clipBehavior: Clip.hardEdge,
                      width: MediaQuery.of(context).size.width / 10,
                      height: MediaQuery.of(context).size.width / 10,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 203, 201, 201),
                        shape: BoxShape.circle,
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: -1,
                            left: -8,
                            child: IconButton(
                              onPressed: modifyPersonalInfo,
                              icon: Icon(
                                Icons.person,
                                color: Colors.white,
                                size: MediaQuery.of(context).size.width / 10,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "딥앤모이스처",
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width / 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "가입일: 2022.12.25",
                          style: TextStyle(
                            color: Color(0xff888686),
                            fontSize: MediaQuery.of(context).size.width / 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '활동',
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      color: Color(0xff4e40ea),
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width / 20,
                    ),
                  ),
                  GestureDetector(
                    onTap: onWrotePressed,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/icons/list_purple.png',
                                height: MediaQuery.of(context).size.width / 15,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                '작성한 글',
                                style: TextStyle(
                                  fontSize:
                                  MediaQuery.of(context).size.width / 25,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: onInterestedPressed,
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/icons/star_purple.png',
                                  height:
                                  MediaQuery.of(context).size.width / 15,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '관심목록',
                                  style: TextStyle(
                                    fontSize:
                                    MediaQuery.of(context).size.width / 25,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: onTransactionPressed,
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/icons/trade_purple.png',
                                  height:
                                  MediaQuery.of(context).size.width / 15,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '거래내역',
                                  style: TextStyle(
                                    fontSize:
                                    MediaQuery.of(context).size.width / 25,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(),
                  GestureDetector(
                    onTap: onNotificationPressed,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/icons/announcement_purple.png',
                            height: MediaQuery.of(context).size.width / 15,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '공지',
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width / 25,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: GestureDetector(
                      onTap: onKeywordNotificationPressed,
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/icons/notification_purple.png',
                            height: MediaQuery.of(context).size.width / 15,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '키워드 알림',
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width / 25,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
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