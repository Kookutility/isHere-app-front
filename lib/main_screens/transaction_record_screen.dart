import 'package:flutter/material.dart';
import 'package:petdemo/const/address.dart';
import 'package:petdemo/main_screens/widget_model/post_model.dart';
import 'package:petdemo/main_screens/widget_model/transaction_list_model.dart';

//찾았어요 버튼을 클릭했을때, 찾았어요 게시판의 상단바와 하단바 유지

class TransactionRecordScreen extends StatelessWidget {
  const TransactionRecordScreen({Key? key}) : super(key: key);
  Widget buildIconButton(Widget child, VoidCallback? onPressed) {
    return InkWell(
      onTap: onPressed,
      splashColor: Colors.transparent, // 터치했을 때 퍼지는 색을 투명하게 설정
      highlightColor: Colors.transparent, // 터치했을 때 하이라이트 색을 투명하게 설정
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final onePost = [
      {
        "title": "구의역쪽에서 구찌 반지갑 분실했습니다.",
        "price": "7,500원",
        "instant": 2,
        "done": 1,
        "doneTime": "23년 08월 02일",
        "userName": "아리스",
        "userImageURL":
            'https://img.freepik.com/free-photo/cute-puppy-sitting-in-grass-enjoying-nature-playful-beauty-generated-by-artificial-intelligence_188544-84973.jpg?w=1060&t=st=1704195937~exp=1704196537~hmac=ad3a9d0c1f275c58c7df69163f8da53383d3f97fc52d5765265abfbb970f31b7',
        "postedTime": "2시간 전",
        "imageURL":
            'https://img.freepik.com/free-photo/cute-puppy-sitting-in-grass-enjoying-nature-playful-beauty-generated-by-artificial-intelligence_188544-84973.jpg?w=1060&t=st=1704195937~exp=1704196537~hmac=ad3a9d0c1f275c58c7df69163f8da53383d3f97fc52d5765265abfbb970f31b7'
      },
      {
        "title": "구의역쪽에서 구찌 반지갑 분실했습니다.",
        "price": "7,500원",
        "instant": 2,
        "done": 1,
        "doneTime": "23년 08월 02일",
        "userName": "아리스",
        "userImageURL":
            'https://img.freepik.com/free-photo/cute-puppy-sitting-in-grass-enjoying-nature-playful-beauty-generated-by-artificial-intelligence_188544-84973.jpg?w=1060&t=st=1704195937~exp=1704196537~hmac=ad3a9d0c1f275c58c7df69163f8da53383d3f97fc52d5765265abfbb970f31b7',
        "postedTime": "2시간 전",
        "imageURL":
            'https://img.freepik.com/free-photo/cute-puppy-sitting-in-grass-enjoying-nature-playful-beauty-generated-by-artificial-intelligence_188544-84973.jpg?w=1060&t=st=1704195937~exp=1704196537~hmac=ad3a9d0c1f275c58c7df69163f8da53383d3f97fc52d5765265abfbb970f31b7'
      },
      {
        "title": "구의역쪽에서 구찌 반지갑 분실했습니다.",
        "price": "7,500원",
        "instant": 2,
        "done": 1,
        "doneTime": "23년 08월 02일",
        "userName": "아리스",
        "userImageURL":
            'https://img.freepik.com/free-photo/cute-puppy-sitting-in-grass-enjoying-nature-playful-beauty-generated-by-artificial-intelligence_188544-84973.jpg?w=1060&t=st=1704195937~exp=1704196537~hmac=ad3a9d0c1f275c58c7df69163f8da53383d3f97fc52d5765265abfbb970f31b7',
        "postedTime": "2시간 전",
        "imageURL":
            'https://img.freepik.com/free-photo/cute-puppy-sitting-in-grass-enjoying-nature-playful-beauty-generated-by-artificial-intelligence_188544-84973.jpg?w=1060&t=st=1704195937~exp=1704196537~hmac=ad3a9d0c1f275c58c7df69163f8da53383d3f97fc52d5765265abfbb970f31b7'
      },
    ];
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white, // 배경색을 흰색으로 설정
          automaticallyImplyLeading: false, // 뒤로 가기 버튼 제거
          elevation: 0.5, // 그림자 제거
          flexibleSpace: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        Icons.chevron_left_rounded,
                        size: 50,
                        color: Color.fromRGBO(78, 64, 234, 0.81),
                      ),
                    ),
                    Text(
                      "거래내역",
                      style: TextStyle(
                        fontFamily: 'Pretendard-ExtraBold',
                        fontWeight: FontWeight.w800,
                        fontSize: MediaQuery.of(context).size.width / 20,
                        color: Color.fromRGBO(78, 64, 234, 0.81),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: buildIconButton(
                        Image.asset(
                          'assets/icons/notification_black.png',
                          width: 30,
                          height: 30,
                        ),
                        () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Divider(),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: onePost.length,
                    itemBuilder: (buildContext, item) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            postDetailWidget,
                            arguments: item,
                          );
                        },
                        child: TransactionListModel(
                          done: 1,
                          doneTime: onePost[item]['doneTime'].toString(),
                          imageURL: onePost[item]['imageURL'].toString(),
                          title: onePost[item]['title'].toString(),
                          price: onePost[item]['price'].toString(),
                          userName: onePost[item]['userName'].toString(),
                          postedTime: onePost[item]['postedTime'].toString(),
                          userImaegURL:
                              onePost[item]['userImaegURL'].toString(),
                        ),
                      );
                    },
                    separatorBuilder: (buildContext, item) {
                      return Divider(
                        color: Color.fromRGBO(189, 189, 189, 1),
                        thickness: 0.5,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
