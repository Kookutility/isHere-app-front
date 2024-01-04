import 'package:flutter/material.dart';
import 'package:petdemo/const/address.dart';
import 'package:petdemo/main_screens/widget_model/post_model.dart';
import 'package:petdemo/common/basic_layout.dart';

//찾았어요 버튼을 클릭했을때, 찾았어요 게시판의 상단바와 하단바 유지

class LookingScreen extends StatelessWidget {
  const LookingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final onePost = [
      {"title": "구의역쪽에서 구찌 반지갑 분실했습니다."},
      {"price": "7,500원"},
      {"place": "광진구 구의동"},
      {"postedTime": "2시간 전"},
      {
        "imageURL":
            'https://img.freepik.com/free-photo/cute-puppy-sitting-in-grass-enjoying-nature-playful-beauty-generated-by-artificial-intelligence_188544-84973.jpg?w=1060&t=st=1704195937~exp=1704196537~hmac=ad3a9d0c1f275c58c7df69163f8da53383d3f97fc52d5765265abfbb970f31b7'
      },
    ];
    List<List<Map<String, String>>> postDataList = [
      onePost,
      onePost,
      onePost,
      onePost,
      onePost,
      onePost,
      onePost,
      onePost,
    ];
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          elevation: 5,
          shape: CircleBorder(),
          backgroundColor: const Color.fromARGB(0, 255, 255, 255),
          onPressed: () {
            Navigator.of(context).pushNamed('/write');
          },
          child: Image.asset(
            "assets/icons/plus_circle_gradation.png",
            fit: BoxFit.contain,
            width: MediaQuery.of(context).size.width / 7,
            height: MediaQuery.of(context).size.width / 7,
          ),
        ),
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
                        color: Color.fromRGBO(130, 134, 147, 1),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 5,
                        backgroundColor: Colors.white,
                      ),
                      onPressed: () {},
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/icons/location_purple.png",
                            fit: BoxFit.contain,
                            scale: 1.5,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "서울 광진구",
                            style: TextStyle(
                              fontFamily: 'Pretendard-ExtraBold',
                              fontWeight: FontWeight.w800,
                              fontSize: MediaQuery.of(context).size.width / 30,
                              color: Color.fromRGBO(78, 64, 234, 0.81),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      '찾고 있어요!',
                      style: TextStyle(
                        fontFamily: 'Pretendard-ExtraBold',
                        fontWeight: FontWeight.w800,
                        fontSize: MediaQuery.of(context).size.width / 25,
                        color: Color.fromRGBO(78, 64, 234, 0.81),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: postDataList.length,
                    itemBuilder: (buildContext, item) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            postDetailWidget,
                            arguments: item,
                          );
                        },
                        child: PostModel(
                          title: postDataList[0][0]["title"]!,
                          price: postDataList[0][1]["price"]!,
                          place: postDataList[0][2]["place"]!,
                          postedTime: postDataList[0][3]["postedTime"]!,
                          imageURL: postDataList[0][4]["imageURL"]!,
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
