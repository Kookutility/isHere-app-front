import 'package:flutter/material.dart';
import 'package:petdemo/flutter_flow/flutter_flow_theme.dart';

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ErrorScreen(),
      ),
    );

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 20,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset(
                      "assets/icons/error.png",
                    ),
                    Text(
                      "진행중에 오류가 발생했습니다.",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Pretendard-ExtraBold',
                        fontSize: MediaQuery.of(context).size.width / 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "불편을 드려서 죄송합니다.",
                      style: TextStyle(
                        color: Color(0xffA7A7A7),
                        fontFamily: 'Pretendard-ExtraBold',
                        fontSize: MediaQuery.of(context).size.width / 27,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      " 계속해서 문제가 발생한다면 고객센터(1000-0000)로 문의해주세요.",
                      style: TextStyle(
                        color: Color(0xffA7A7A7),
                        fontFamily: 'Pretendard-ExtraBold',
                        fontSize: MediaQuery.of(context).size.width / 27,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.visible,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.loose,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Color(0xff796DFF),
                          fixedSize: Size(
                            MediaQuery.of(context).size.width / 3,
                            MediaQuery.of(context).size.width / 3 / 3,
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          "문의하기",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Pretendard-ExtraBold',
                            fontSize: MediaQuery.of(context).size.width / 30,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Color(0xff2998FF),
                          fixedSize: Size(
                            MediaQuery.of(context).size.width / 3,
                            MediaQuery.of(context).size.width / 3 / 3,
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          "확인",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Pretendard-ExtraBold',
                            fontSize: MediaQuery.of(context).size.width / 30,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 15,
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
