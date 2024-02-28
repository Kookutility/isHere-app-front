import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:petdemo/common/basic_layout.dart';
import 'package:petdemo/const/address.dart';
import 'package:petdemo/sign_step/pages/back_account.dart';
import 'package:petdemo/sign_step/pages/condi_term.dart';
import 'package:petdemo/sign_step/pages/nick_name.dart';
import 'package:petdemo/sign_step/pages/password.dart';
import 'package:petdemo/sign_step/pages/phone.dart';
import 'package:petdemo/sign_step/pages/sign_up_done.dart';
import 'package:petdemo/sign_step/pages/tutorial.dart';
import 'package:petdemo/sign_step/pages/verifyPhone.dart';

/*
* 이즈히어 자체 회원가입 단계에 대한 기본적인 틀
* 


*/
class SignUpStepsScreen extends StatefulWidget {
  const SignUpStepsScreen({super.key});

  @override
  State<SignUpStepsScreen> createState() => _SignUpStepsScreenState();
}

class _SignUpStepsScreenState extends State<SignUpStepsScreen> {
  int pageIndex = 0; // 첫 페이지 인덱스
  double percentBar = 0.0; // 첫 페이지 페센트
  late double amountOfProgress = 0.0; // 퍼센트바에 대한 회원가입 단계별 증가량
  List<Widget> signUpPages = []; // 페이지 리스트

  @override
  void initState() {
    super.initState();
    signUpPages = [
      PhoneSignScreen(
        onPhoneContinuePressed: pushPage,
      ),
      VerifyPhoneScreen(
        onVerifyContinuePressed: pushPage,
      ),
      NickNameScreen(
        onCondAgreePressed: pushPage,
      ),
      CondTermScreen(
        onCondAgreePressed: pushPage,
      ),
      PasswordScreen(
        description: "앱 사용시 본인 확인을 위한 비밀번호를 설정합니다.",
        onContinuePressed: pushPage,
      ),
      PasswordScreen(
        description: "방금 입력하신 비밀번호를 한번 더 적어주세요.",
        onContinuePressed: pushPage,
      ),
      BankAccountScreen(
        onAccountStartPressed: pushPage,
      ),
      SignUpDoneScreen(
        onDonePressed: onDonePressed,
      ),
      TutorialScreen(),
    ]; // 회원가입 페이지에 필요한 페이지들 할당.
    amountOfProgress =
        1 / signUpPages.length; // 페이지 개수 등분 중에서 한 페이지 크기 만큼 증가량을 설정.
    percentBar += amountOfProgress; // 현재 페이지에 대한 퍼센트 증가.
  }

  /* 뒤로가기 버튼
  * 1. 뒤로가기 버튼을 눌렀을 때 [popPage()메소드]
      - 페이지 리스트의 인덱스를 감소시켜, 바디를 변경.
      - 퍼센트 바를 이전 페이지(단계)에 맞게 동기화.
  * 2. 페이지 리스트의 인덱스가 0인 경우(첫 페이지)
      - SignUpStepsScreen을 pop해 페이지 전환.
  */
  void backButtonPressed() {
    if (pageIndex == 0) {
      Navigator.of(context).pop();
    } else {
      popPage();
    }
  }

  void popPage() {
    setState(() {
      pageIndex--;
      percentBar -= amountOfProgress;
    });
  }

  /* 다음 단계 버튼
  * 1. 다음으로 가는 버튼을 눌렀을 때 [pushPage()메소드]
      - 페이지 리스트의 인덱스를 증가시켜, 다음 페이지가 보이도록 바디를 변경.
      - 퍼센트 바를 다음 페이지(단계)에 맞게 동기화.
  * 2. 페이지 리스트의 인덱스가 마지막인 경우(마지막 페이지) [onDonePressed()메소드]
      - SignUpStepsScreen에서 라우터를 이용해 다른 페이지로 전환. 
  */
  void pushPage() {
    pageIndex++;
    percentBar += amountOfProgress;
    setState(() {});
  }

  void onDonePressed() {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(tutorialScreen, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          LinearPercentIndicator(
            animation: true,
            animationDuration: 500,
            animateFromLastPercent: true,
            padding: EdgeInsets.zero,
            percent: percentBar,
            lineHeight: 10,
            backgroundColor: Color.fromRGBO(217, 217, 217, 1),
            progressColor: Color.fromRGBO(24, 152, 245, 1),
            width: MediaQuery.of(context).size.width,
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
      children: [
        Row(
          children: [
            IconButton(
              onPressed: backButtonPressed,
              icon: Icon(
                Icons.chevron_left_rounded,
                size: 50,
                weight: 100,
                color: Color.fromRGBO(130, 134, 147, 1),
              ),
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 30,
          ),
          child: signUpPages[pageIndex],
        ),
      ],
    );
  }
}
