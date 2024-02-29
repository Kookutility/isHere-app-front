import 'dart:async';

import 'package:flutter/material.dart';

import 'package:petdemo/common/custom_textform.dart';
import 'package:petdemo/sign_step/widgets/blue_green_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyPhoneScreen extends StatefulWidget {
  final VoidCallback? onVerifyContinuePressed;
  const VerifyPhoneScreen({
    super.key,
    this.onVerifyContinuePressed,
  });

  @override
  State<VerifyPhoneScreen> createState() => _VerifyPhoneScreenState();
}

class _VerifyPhoneScreenState extends State<VerifyPhoneScreen> {
  String currentText = '';
  StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();
  bool isConfirm = false;
  String leftTime = "4:58";

  final TextEditingController phoneNumTController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 5 / 6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "인증문자 입력",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: MediaQuery.of(context).size.width / 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  "사용하고 계신 전화번호를 입력해주세요.",
                  style: TextStyle(
                    color: Color.fromRGBO(68, 65, 66, 1),
                    fontSize: MediaQuery.of(context).size.width / 23,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      PinCodeTextField(
                        appContext: context,
                        length: 6,
                        keyboardType: TextInputType.number,
                        obscureText: false,
                        animationType: AnimationType.fade,
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.underline,
                          fieldHeight: 50,
                          fieldWidth: 40,
                          activeFillColor: Colors.white,
                          inactiveColor: Colors.grey,
                          inactiveFillColor: Colors.white,
                          selectedFillColor: Colors.white,
                        ),
                        animationDuration: Duration(milliseconds: 300),
                        backgroundColor: Colors.white,
                        enableActiveFill: true,
                        errorAnimationController: errorController,
                        controller: phoneNumTController,
                        onCompleted: (v) {
                          print("Completed");
                        },
                        onChanged: (value) {
                          print(value);
                          setState(() {
                            currentText = value;
                          });
                        },
                        beforeTextPaste: (text) {
                          print("Allowing to paste $text");

                          return true;
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("남은 입력시간 : $leftTime"),
                          TextButton(
                            onPressed: () {},
                            child: Text("재전송하기"),
                          ),
                        ],
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: []),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: GestureDetector(
              onTap: widget.onVerifyContinuePressed,
              // isConfirm ? widget.onVerifyContinuePressed : null,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  BlueGreenButton(
                    isConfirm: isConfirm,
                    child: Center(
                      child: Text(
                        "계속하기",
                        style: TextStyle(
                          color: isConfirm ? Colors.white : Colors.grey,
                          fontSize: MediaQuery.of(context).size.width / 25,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SingleNum extends StatelessWidget {
  final FocusNode focusNode;
  const SingleNum({
    super.key,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 9,
      child: CustomTextFormField(
        maxLength: 1,
        keyboardType: TextInputType.number,
        focusNode: focusNode,
      ),
    );
  }
}
