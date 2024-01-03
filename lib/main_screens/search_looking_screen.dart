import 'package:flutter/material.dart';
import 'package:petdemo/const/address.dart';
import 'package:petdemo/main_screens/widget_model/post_model.dart';
import 'package:petdemo/common/basic_layout.dart';

//찾았어요 버튼을 클릭했을때, 찾았어요 게시판의 상단바와 하단바 유지

class LookingScreen extends StatelessWidget {
  const LookingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
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
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: 100,
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
    );
  }
}
