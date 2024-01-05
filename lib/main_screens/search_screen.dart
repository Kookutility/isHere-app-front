import 'package:flutter/material.dart';
import 'package:petdemo/const/address.dart';
import 'package:petdemo/main_screens/widget_model/post_model.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                            itemCount: 10,
                            itemBuilder: (buildContext, item) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                    postDetailWidget,
                                    arguments: item,
                                  );
                                },
                                child: PostModel(),
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