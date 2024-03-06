import 'package:flutter/material.dart';
import 'package:petdemo/API/service/rest_api.dart';
import 'package:petdemo/authentication/login_step/login_verify_screen.dart';
import 'package:petdemo/sign_step/pages/phone.dart';

class LoginPhoneScreen extends StatefulWidget {
  const LoginPhoneScreen({super.key});

  @override
  State<LoginPhoneScreen> createState() => _LoginPhoneScreenState();
}

class _LoginPhoneScreenState extends State<LoginPhoneScreen> {
  String? phoneNum;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 10,
              ),
              child: PhoneField(
                getPhoneNum: (val) {
                  setState(() {
                    phoneNum = val;
                  });
                },
                onPhoneContinuePressed: phoneNum == null
                    ? () {}
                    : () {
                        final phoneNumSend = ApiService();
                        phoneNumSend
                            .postRequest("SendForLogin", {"user": phoneNum});
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return LoginVerifyScreen();
                            },
                          ),
                        );
                      },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
