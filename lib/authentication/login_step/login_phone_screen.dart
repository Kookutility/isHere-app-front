import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:petdemo/API/service/rest_api.dart';
import 'package:petdemo/authentication/login_step/login_verify_screen.dart';
import 'package:petdemo/firebase_options.dart';
import 'package:petdemo/sign_step/pages/phone.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();  
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(LoginPhoneScreenApp());
}

class LoginPhoneScreenApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPhoneScreen(),
    );
  }
}

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
                  print(val);
                  setState(() {
                    phoneNum = val;
                  });
                },
                onPhoneContinuePressed: phoneNum == null
                    ? () {}
                    : () async {
                        final phoneNumSend = ApiService();
                        phoneNumSend.postRequest(
                            "/loginuser", {"username": phoneNum});

                        final String email = phoneNum! + "@ishere.com";
                        final String password = "ishere0903@@!@";

                        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: email,
                          password: password,
                        );

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
