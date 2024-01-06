import 'dart:convert';
import 'package:flutter/material.dart';
import '../../model/postmain_model.dart';
import 'package:http/http.dart' as http;

class PostModel extends StatelessWidget {
  const PostModel({Key? key}) : super(key: key);

  Future<List<Post>> fetchPosts() async {
    final response = await http.get(Uri.parse('https://port-0-petish-app-back-1fk9002blr25yq9u.sel5.cloudtype.app/board/list'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      List<Post> posts = jsonResponse.map((item) => Post.fromJson(item)).toList();

      posts.forEach((post) {
        print("Post Title: ${post.postTitle}");
        print("Reward: ${post.reward}");
        print("Area Name: ${post.areaName}");
        print("Created At: ${post.createdAt}");
        print("-----------------------------");
      });

      return posts;
    } else {
      throw Exception('Failed to load posts');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 5,
            decoration: BoxDecoration(
              color: Color.fromRGBO(237, 237, 237, 1),
              border: Border.all(
                color: Color.fromRGBO(237, 237, 237, 1),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "구의역쪽에서 구찌 반지갑 분실했습니다.",//post_title
                style: TextStyle(
                  fontFamily: 'Pretendard-ExtraBold',
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width / 25,
                  color: Colors.black,
                  overflow: TextOverflow.visible,
                ),
              ),
              Row(
                children: [
                  Text(
                    "사례금 : 7,500원",//7,500=reward
                    style: TextStyle(
                      fontFamily: 'Pretendard-ExtraBold',
                      fontWeight: FontWeight.w800,
                      fontSize: MediaQuery.of(context).size.width / 27,
                      color: Color.fromRGBO(78, 64, 234, 0.81),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Image.asset("assets/icons/give_immediately.png"),
                ],
              ),
              Text(
                "광진구 구의동: 2시간 전", //광진구 구의동=area_name, 2시간 전=created_at
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
    );
  }
}
