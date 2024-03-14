import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:petdemo/authentication/login_step/login_phone_screen.dart';
import 'package:petdemo/common/const/address.dart';
import 'package:petdemo/init_screen.dart';
import 'package:petdemo/main_screens/exception/notification_screen.dart';
import 'package:petdemo/main_screens/map_screen.dart';
import 'package:petdemo/main_screens/personal/interested_content_screen.dart';
import 'package:petdemo/main_screens/personal/past_post_screen.dart';
import 'package:petdemo/main_screens/personal/transaction_record_screen.dart';
import 'package:petdemo/main_screens/post/component/post_detail_model.dart';
import 'package:petdemo/main_screens/post/search_found_screen.dart';
import 'package:petdemo/main_screens/post/search_looking_screen.dart';
import 'package:petdemo/main_screens/post/write_screen.dart';
import 'package:petdemo/sign_step/pages/back_account.dart';
import 'package:petdemo/sign_step/pages/condi_term.dart';
import 'package:petdemo/sign_step/sign_up_done.dart';
import 'package:petdemo/sign_step/steps.dart';
import 'package:petdemo/sign_step/tutorial.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NaverMapSdk.instance
      .initialize(clientId: 'raopvm5gte'); // NaverMapSdk 초기화
  runApp(const IsHereMain());
}

class IsHereMain extends StatelessWidget {
  const IsHereMain({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'isHere',
      debugShowCheckedModeBanner: false,
      initialRoute: home,
      theme: ThemeData(fontFamily: 'Pretendard'),
      routes: {
        home: (context) => LoginPhoneScreen(),
        initScreen: (context) => const InitScreen(),

        //post
        searchLookingScreen: (context) => const LookingScreen(),
        searchFoundScreen: (context) => const FoundScreen(),
        mapScreen: (context) => const MapScreen(),
        writeScreen: (context) => const WriteScreen(
              categoryTypeIsFind: false,
            ),

        //signUp
        signUpStepsScreen: (context) => SignUpStepsScreen(),
        // phoneSignScreen: (context) => PhoneField(),
        // verifyphoneScreen: (context) => VerifyPhoneField(),
        // nickNameScreen: (context) => NickNameField(),
        condTermScreen: (context) => CondTermScreenField(),
        bankAccScreen: (context) => BankAccountField(),
        signUpDoneScreen: (context) => SignUpDoneScreen(),
        tutorialScreen: (context) => TutorialScreen(),

        //notice board
        postDetailWidget: (context) => PostDetailModel(),

        //myPage
        notificationScreen: (context) => const NotificationScreen(),
        interestedListScreen: (context) => const InterestedListScreen(),
        wroteListScreen: (context) => PastPostScreen(),
        transactionRecordScreen: (context) => TransactionRecordScreen(),
      },
    );
  }
}
