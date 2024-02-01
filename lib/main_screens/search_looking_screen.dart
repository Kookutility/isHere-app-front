import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:petdemo/const/address.dart';
import 'package:petdemo/main_screens/widget_model/post_model.dart';
import 'package:petdemo/common/basic_layout.dart';

import '../API/model/latest_post_model.dart';

//찾았어요 버튼을 클릭했을때, 찾았어요 게시판의 상단바와 하단바 유지

class LookingScreen extends StatelessWidget {
  const LookingScreen({Key? key}) : super(key: key);

  Future<List<Post>?> getRequest(
      /* String sessionID, String toUrl, dynamic data*/) async {
    final dio = Dio();
    List<Post> postList = [];
    try {
      final Response<String> response = await dio.get(
        "https://port-0-petish-app-back-1fk9002blr25yq9u.sel5.cloudtype.app/board/list",
        // options: Options(
        //   headers: {
        //     "authorization": 'Basic $sessionID',
        //   },
        // ),
        // data: data,
      );
      print("data : $response");

      final List<dynamic> posts = jsonDecode(response.data!);

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
        body: FutureBuilder<List<Post>?>(
          future: getRequest(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data == null) {
              return Text('No data available');
            }

            // Now you can use snapshot.data in your widget
            return SizedBox(
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
                                  fontSize:
                                  MediaQuery.of(context).size.width / 30,
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
                          '찾고있어요!',
                          style: TextStyle(
                            fontFamily: 'Pretendard-ExtraBold',
                            fontWeight: FontWeight.w800,
                            fontSize:
                            MediaQuery.of(context).size.width / 25,
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
                        itemCount: snapshot.data!.length,
                        itemBuilder: (buildContext, item) {
                          // Check if the category is "찾고있어요"
                          if (snapshot.data![item].categoryType == "찾고있어요") {
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  postDetailWidget,
                                  arguments: snapshot.data![item],
                                );
                              },
                              child: PostModel(
                                title: snapshot.data![item].postTitle,
                                price: snapshot.data![item].reward.toString(),
                                deal: snapshot.data![item].immediateCase.toString(),
                                place: snapshot.data![item].areaName,
                                postedTime: snapshot.data![item].createdAt,
                                imageURL: 'https://img.freepik.com/free-photo/cute-puppy-sitting-in-grass-enjoying-nature-playful-beauty-generated-by-artificial-intelligence_188544-84973.jpg?w=1060&t=st=1704195937~exp=1704196537~hmac=ad3a9d0c1f275c58c7df69163f8da53383d3f97fc52d5765265abfbb970f31b7',
                              ),
                            );
                          } else {
                            // If the category is not "찾고있어요", return an empty container.
                            return Container();
                          }
                        },
                        separatorBuilder: (buildContext, item) {
                          // Check if the next item's category is also "찾고있어요" to decide whether to add a divider.
                          if (item < snapshot.data!.length - 1 &&
                              snapshot.data![item + 1].categoryType == "찾고있어요") {
                            return Divider(
                              color: Color.fromRGBO(189, 189, 189, 1),
                              thickness: 0.5,
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}