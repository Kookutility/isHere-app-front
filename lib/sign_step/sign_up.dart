import 'package:flutter/material.dart';
import 'package:petdemo/const/address.dart';

/* 회원가입 시작 페이지
  1. 이즈히어 자체 회원가입
  2. 네이버 회원가입
  3. 카카오톡 회원가입
*/

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /* 1. 이즈히어 자체 회원가입 버튼을 눌렀을 때
    */
    signUpPressed() {
      Navigator.of(context).pushNamed(signUpStepsScreen);
    }

    /* 2. 네이버 버튼을 눌렀을 때
    */
    naverPressed() {}

    /* 3. 카카오 버튼을 눌렀을 때
    */
    kakaoPressed() {}

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(78, 64, 234, 1),
              Color.fromRGBO(107, 224, 210, 1),
            ],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      children: [
                        Image.asset(
                          'assets/icons/search_gradation.png',
                          width: MediaQuery.of(context).size.width / 6,
                        )
                      ],
                    ),
                    Text(
                      "안녕하세요!",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width / 8,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Text(
                          "이즈히어는 ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.width / 22,
                          ),
                        ),
                        Text(
                          "잃어버린 ",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.width / 22,
                          ),
                        ),
                        Text(
                          "귀중품, 반려동물을 ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.width / 22,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "찾는 새로운 방법",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.width / 22,
                          ),
                        ),
                        Text(
                          "입니다.",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.width / 22,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "지금 가입하시고 이용해보세요.",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width / 22,
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.loose,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(30),
                        maximumSize: Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      onPressed: signUpPressed,
                      child: Center(
                        child: Text(
                          "이즈히어 회원가입",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                            fontSize: MediaQuery.of(context).size.width / 22,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(30),
                        maximumSize: Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        backgroundColor: Color.fromRGBO(3, 199, 90, 1),
                      ),
                      onPressed: naverPressed,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            flex: 1,
                            fit: FlexFit.loose,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width / 20,
                              child:
                                  Image.asset('assets/icons/naver_white.png'),
                            ),
                          ),
                          Flexible(
                            flex: 3,
                            fit: FlexFit.loose,
                            child: Text(
                              "네이버 계정으로 로그인",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize:
                                    MediaQuery.of(context).size.width / 22,
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            fit: FlexFit.loose,
                            child: Container(
                              width: MediaQuery.of(context).size.width / 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(30),
                        maximumSize: Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        backgroundColor: Color.fromRGBO(254, 229, 0, 1),
                      ),
                      onPressed: kakaoPressed,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            flex: 1,
                            fit: FlexFit.loose,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width / 20,
                              child: Image.asset(
                                'assets/icons/kakao_black.png',
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 3,
                            fit: FlexFit.loose,
                            child: Text(
                              "카카오 계정으로 로그인",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize:
                                    MediaQuery.of(context).size.width / 22,
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            fit: FlexFit.loose,
                            child: Container(
                              width: MediaQuery.of(context).size.width / 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "계정이 이미 있으신가요? ",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "로그인",
                          style: TextStyle(
                            color: Color.fromRGBO(78, 64, 234, 1),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
