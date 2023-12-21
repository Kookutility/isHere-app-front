import 'package:flutter/material.dart';
import 'package:petdemo/const/address.dart';
import 'package:petdemo/sign_step/widgets/blue_green_button.dart';

class TutorialScreen extends StatelessWidget {
  const TutorialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Shader linearGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: <Color>[
        Color.fromRGBO(255, 99, 99, 1),
        Color.fromRGBO(255, 213, 107, 1),
      ],
    ).createShader(
      Rect.fromLTWH(0.0, 450, 0, 500.0),
    );

    onOkTap() {
      Navigator.of(context).pushReplacementNamed(initScreen);
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 30,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 4 / 7,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                '즉시 사례',
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width / 13,
                                    fontWeight: FontWeight.w900,
                                    foreground: Paint()
                                      ..shader = linearGradient),
                              ),
                              Text(
                                '는',
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width / 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "무엇인가요?",
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width / 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        child: Image.asset(
                          "assets/icons/verified_gradation.png",
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 4 / 5,
                    height: MediaQuery.of(context).size.height * 1 / 12,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(0, 0, 0, 0.06),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(18.0),
                        bottomRight: Radius.circular(18.0),
                        topRight: Radius.circular(18.0),
                        bottomLeft: Radius.circular(4.0),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "즉시 사례",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "는 찾아준 분에게",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "간편하고 안전한 사례를 보장해줍니다.",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 4 / 5,
                    height: MediaQuery.of(context).size.height * 1 / 7,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(0, 0, 0, 0.06),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(18.0),
                        bottomRight: Radius.circular(18.0),
                        topRight: Radius.circular(18.0),
                        bottomLeft: Radius.circular(4.0),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "또한, ",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                "즉시 사례",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "로 게시글을 등록하면",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "게시물이 ",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                "상위",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromRGBO(78, 64, 234, 1),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "로 노출되어 찾을 확률이",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "증가할 수 있어요!",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 30,
                        height: 30,
                        child: Image.asset('assets/icons/profile_image.png'),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 2 / 5,
                        height: MediaQuery.of(context).size.height * 1 / 20,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(0, 0, 0, 0.06),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(18.0),
                            bottomRight: Radius.circular(18.0),
                            topRight: Radius.circular(18.0),
                            bottomLeft: Radius.circular(4.0),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '찾았습니다. 😄',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        height: MediaQuery.of(context).size.height * 1 / 20,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(78, 64, 234, 1),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(18.0),
                            bottomRight: Radius.circular(4.0),
                            topRight: Radius.circular(18.0),
                            bottomLeft: Radius.circular(18.0),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '즉시 사례해드릴게요!',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: onOkTap,
              child: Center(
                child: BlueGreenButton(
                  child: Center(
                    child: Text(
                      "알겠습니다",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width / 25,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
