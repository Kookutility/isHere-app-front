import 'package:flutter/material.dart';
import 'package:petdemo/API/service/rest_api.dart';
import 'package:petdemo/init_screen.dart';
import 'package:petdemo/sign_step/pages/verifyPhone.dart';

class LoginVerifyScreen extends StatelessWidget {
  const LoginVerifyScreen({super.key});

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
              child: VerifyPhoneField(
                getPinNum: (value) {
                  final phoneNumSend = ApiService();
                  phoneNumSend.postRequest("/inputNum", {"inputNum": value});
                },
                onVerifyContinuePressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return InitScreen();
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
