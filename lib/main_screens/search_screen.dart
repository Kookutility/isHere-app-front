import 'package:flutter/material.dart';
import 'package:petdemo/const/address.dart';
import 'package:petdemo/main_screens/widget_model/post_model.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

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
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 40),
                    Text(
                      '무엇을 도와드릴까요?',
                      style: TextStyle(
                        fontFamily: 'Pretendard-ExtraBold',
                        fontWeight: FontWeight.w800,
                        fontSize: 24,
                        color: Color.fromRGBO(78, 64, 234, 0.81),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 5,
                          width: MediaQuery.of(context).size.width * 4 / 9,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(searchLookingScreen);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromRGBO(242, 242, 242, 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/icons/lost_gradation.png',
                                ),
                                Text(
                                  '찾고 있어요',
                                  style: TextStyle(
                                    fontFamily: 'Pretendard-ExtraBold',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Color.fromRGBO(78, 64, 234, 0.81),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 5,
                          width: MediaQuery.of(context).size.width * 4 / 9,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(searchFoundScreen);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromRGBO(242, 242, 242, 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/icons/found_gradation.png',
                                ),
                                Text(
                                  '찾았어요',
                                  style: TextStyle(
                                    fontFamily: 'Pretendard-ExtraBold',
                                    fontWeight: FontWeight.w800,
                                    fontSize: 16,
                                    color: Color.fromRGBO(78, 64, 234, 0.81),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 10,
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(mapScreen);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(242, 242, 242, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              flex: 1,
                              child: Image.asset(
                                'assets/icons/location_dot_gradation.png',
                                width: MediaQuery.of(context).size.width / 10,
                              ),
                            ),
                            Text(
                              '지도로 한눈에 보기',
                              style: TextStyle(
                                fontFamily: 'Pretendard-ExtraBold',
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                                color: Color.fromRGBO(78, 64, 234, 0.81),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      '최근 게시글',
                      style: TextStyle(
                        fontFamily: 'Pretendard-ExtraBold',
                        fontWeight: FontWeight.w800,
                        fontSize: MediaQuery.of(context).size.width / 25,
                        color: Color.fromRGBO(78, 64, 234, 0.81),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
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
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
