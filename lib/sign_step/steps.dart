import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:petdemo/common/basic_layout.dart';
import 'package:petdemo/const/address.dart';
import 'package:petdemo/sign_step/pages/back_account.dart';
import 'package:petdemo/sign_step/pages/nick_name.dart';
import 'package:petdemo/sign_step/pages/phone.dart';
import 'package:petdemo/sign_step/pages/sign_up_done.dart';
import 'package:petdemo/sign_step/pages/tutorial.dart';
import 'package:petdemo/sign_step/pages/verifyPhone.dart';

class SignUpStepsScreen extends StatefulWidget {
  const SignUpStepsScreen({super.key});

  @override
  State<SignUpStepsScreen> createState() => _SignUpStepsScreenState();
}

class _SignUpStepsScreenState extends State<SignUpStepsScreen> {
  int pageIndex = 0;
  double percentBar = 0.0;
  late double amountOfProgress = 0.0;
  List<Widget> signUpPages = [];

  @override
  void initState() {
    super.initState();
    signUpPages = [
      PhoneSignScreen(
        onPhoneContinuePressed: onPhoneContinuePressed,
      ),
      VerifyPhoneScreen(
        onVerifyContinuePressed: onVerifyContinuePressed,
      ),
      NickNameScreen(
        onCondAgreePressed: onCondAgreePressed,
      ),
      BankAccountScreen(
        onAccountStartPressed: onAccountStartPressed,
      ),
      SignUpDoneScreen(
        onDonePressed: onDonePressed,
      ),
      TutorialScreen(),
    ];
    amountOfProgress = 1 / signUpPages.length;
    percentBar += amountOfProgress;
  }

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

  void pushPage() {
    pageIndex++;
    percentBar += amountOfProgress;
    setState(() {});
  }

  void onPhoneContinuePressed() {
    pushPage();
  }

  void onVerifyContinuePressed() {
    pushPage();
  }

  void onCondAgreePressed() {
    pushPage();
  }

  void onDonePressed() {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(tutorialScreen, (route) => false);
  }

  void onAccountStartPressed() {
    pushPage();
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
