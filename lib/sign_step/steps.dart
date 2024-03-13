import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:petdemo/API/service/rest_api.dart';
import 'package:petdemo/backend/backend.dart';
import 'package:petdemo/common/basic_layout.dart';
import 'package:petdemo/firebase_options.dart';
import 'package:petdemo/sign_step/pages/condi_term.dart';
import 'package:petdemo/sign_step/pages/nick_name.dart';
import 'package:petdemo/sign_step/pages/payment_password.dart';
import 'package:petdemo/sign_step/pages/phone.dart';
import 'package:petdemo/sign_step/pages/verifyPhone.dart';
import 'package:petdemo/sign_step/sign_up_done.dart';
import 'package:petdemo/sign_step/tutorial.dart';
import 'package:petdemo/backend/backend.dart';

/*
* 이즈히어 자체 회원가입 단계에 대한 기본적인 틀
* 


*/

void main() async {
  WidgetsFlutterBinding.ensureInitialized();  
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(SignUpStepsScreenApp());
}

class SignUpStepsScreenApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignUpStepsScreen(),
    );
  }
}

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
  String phoneNum = '';
  String pinNum = '';
  String payPinNum = '';
  String nickName = '';
  @override
  void initState() {
    super.initState();
    signUpPages = [
      PhoneField(
        onPhoneContinuePressed: pushPage,
        getPhoneNum: (value) {
          print(value);
          phoneNum = value;
        },
      ),
      VerifyPhoneField(
        onVerifyContinuePressed: pushPage,
        getPinNum: (value) {
          print(value);
          pinNum = value;
        },
      ),
      NickNameField(
        onContinuePressed: pushPage,
        getNickName: (value) {
          print(value);
          nickName = value;
        },
      ),
      CondTermScreenField(
        onCondAgreePressed: pushPage,
      ),
      PaymentPassword(
        onPinContinuePressed: pushPage,
        getPayPinNum: (value) {
          print(value);
          payPinNum = value;
        },
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
    setState(() {
      print(pageIndex);
      print(percentBar);
    });
  }

  void onDonePressed() async {
    final phoneNumSend = ApiService();
    print("$nickName $phoneNum $pinNum");
    final response = await phoneNumSend.postRequest("/user/register", {
      "userName": nickName,
      "phoneNumber": phoneNum,
      "pinNumber": pinNum,
    });

   try {
    // Firebase 초기화
    await Firebase.initializeApp();

    // FirebaseAuth 인스턴스 사용
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: phoneNum + "@ishere.com",
      password: "ishere0903@@!@",
    );
    User? user = FirebaseAuth.instance.currentUser;
    DateTime createdTime = DateTime.now();
    
    if (user != null) { 
      // Firestore에 닉네임 저장하기
       await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
      'email': phoneNum + "@ishere.com",
      'displayName': nickName,
      'photoUrl': null, // 사용자 프로필 사진은 초기에 null로 설정하거나 기본값 사용
      'uid': user.uid,
      'createdTime': createdTime,
      'phoneNumber': phoneNum,
      }); // 기존 데이터와 병합

      // Firebase 유저 프로필 업데이트하기
      //await user.updateDisplayName(nickName);
      
      final result = await phoneNumSend.reponseMessageCheck(response);
      print(result);

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) {
            return TutorialScreen();
          },
        ),
        (route) => false,
      );
    }
  } catch (e) {
    print("Error creating user: $e");
  }
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