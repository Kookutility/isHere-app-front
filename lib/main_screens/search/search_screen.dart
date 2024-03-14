import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:petdemo/API/model/latest_post_model.dart';
import 'package:petdemo/API/service/rest_api.dart';
import 'package:petdemo/common/const/address.dart';
import 'package:petdemo/main_screens/post/component/post_model.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  Future<List<Post>?> getRequest(
      {required String url, dynamic data, BuildContext? context}) async {
    List<Post> postList = [];
    try {

      
      final getLatestPost = ApiService(context: context);
      final Response<dynamic>? response =
          await getLatestPost.getRequest(url, data);
      print("data : $response");
      print(getLatestPost.reponseMessageCheck(response));




      final List<dynamic> posts = jsonDecode(response!.data!);

      for (var post in posts) {
        print(post);
        postList.add(Post.fromJson(post));
      }

      return postList;
    } on DioException catch (e) {
      debugPrint(e.message);
    }
    return null;
  }

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
                          child: FutureBuilder<List<Post>?>(
                              future: null,
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return CircularProgressIndicator();
                                }

                                if (snapshot.data == null) {
                                  print("receivced data is null");
                                  return CircularProgressIndicator();
                                }

                                return ListView.separated(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (buildContext, item) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pushNamed(
                                          postDetailWidget,
                                          arguments: snapshot.data![item],
                                        );
                                      },
                                      child: PostModel(
                                        title: snapshot.data![item].postTitle,
                                        price: snapshot.data![item].reward
                                            .toString(),
                                        deal: snapshot.data![item].immediateCase
                                            .toString(),
                                        place: snapshot.data![item].areaName,
                                        postedTime:
                                            snapshot.data![item].createdAt,
                                        imageURL:
                                            'https://img.freepik.com/free-photo/cute-puppy-sitting-in-grass-enjoying-nature-playful-beauty-generated-by-artificial-intelligence_188544-84973.jpg?w=1060&t=st=1704195937~exp=1704196537~hmac=ad3a9d0c1f275c58c7df69163f8da53383d3f97fc52d5765265abfbb970f31b7',
                                      ),
                                    );
                                  },
                                  separatorBuilder: (buildContext, item) {
                                    return Divider(
                                      color: Color.fromRGBO(189, 189, 189, 1),
                                      thickness: 0.5,
                                    );
                                  },
                                );
                              }),
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
