import 'package:flutter/material.dart';
import 'package:petdemo/main_screens/widget_model/notification_mode.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<List<Map<String, String>>> notificationList = [];

  @override
  Widget build(BuildContext context) {
    notificationList = [
      [
        {"title": "분식물 어플 이용 시 주의사항"},
        {"content": "분실물 어플 이용 시 개인 정보를 남발하지 않도록 주의해주시기 바랍니다."},
        {"postedTime": "3일전"},
      ],
      [
        {"title": "분식물 어플 이용 시 주의사항"},
        {"content": "분실물 어플 이용 시 개인 정보를 남발하지 않도록 주의해주시기 바랍니다."},
        {"postedTime": "3일전"},
      ],
      [
        {"title": "분식물 어플 이용 시 주의사항"},
        {"content": "분실물 어플 이용 시 개인 정보를 남발하지 않도록 주의해주시기 바랍니다."},
        {"postedTime": "3일전"},
      ],
    ];
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        Icons.chevron_left_rounded,
                        size: 50,
                        weight: 100,
                        color: Color.fromRGBO(78, 64, 234, 0.81),
                      ),
                    ),
                    Text(
                      "공지",
                      style: TextStyle(
                        fontFamily: 'Pretendard-ExtraBold',
                        fontWeight: FontWeight.w800,
                        fontSize: MediaQuery.of(context).size.width / 20,
                        color: Color.fromRGBO(78, 64, 234, 0.81),
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: Color.fromRGBO(189, 189, 189, 1),
                  thickness: 1,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: notificationList.length,
                    itemBuilder: (buildContext, item) {
                      return GestureDetector(
                        onTap: () {},
                        child: NotificationModel(
                          title: notificationList[item][0]["title"]!,
                          content: notificationList[item][1]["content"]!,
                          postedTime: notificationList[item][2]["postedTime"]!,
                        ),
                      );
                    },
                    separatorBuilder: (buildContext, item) {
                      return Divider(
                        color: Color.fromRGBO(189, 189, 189, 1),
                        thickness: 1,
                      );
                    },
                  ),
                ),
                Divider(
                  color: Color.fromRGBO(189, 189, 189, 1),
                  thickness: 1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}