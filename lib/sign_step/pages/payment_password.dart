import 'dart:async';

import 'package:flutter/material.dart';
import 'package:petdemo/common/custom_textform.dart';
import 'package:petdemo/sign_step/widgets/blue_green_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PaymentPassword extends StatefulWidget {
  final VoidCallback? onPinContinuePressed;

  const PaymentPassword({
    super.key,
    required this.onPinContinuePressed,
  });

  @override
  State<PaymentPassword> createState() => _PaymentPasswordState();
}

class _PaymentPasswordState extends State<PaymentPassword> {
  String currentText = '';
  StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();
  String text = '';

  final TextEditingController phoneNumTController = TextEditingController();
  _onKeyboardTap(String value) {
    setState(() {
      phoneNumTController.text += value;
    });
  }

  final Shader linearGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: <Color>[
      Color(0xff4E40EA),
      Color(0xff828282),
    ],
  ).createShader(
    Rect.fromLTWH(0.0, 450, 0, 500.0),
  );
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 3 / 4,
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 30,
          ),
          Flexible(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "비밀번호 입력",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 20,
                    fontWeight: FontWeight.w700,
                    foreground: Paint()..shader = linearGradient,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Column(
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
                  ],
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
                GestureDetector(
                  onTap: widget.onPinContinuePressed,
                  child: BlueGreenButton(
                    child: Center(
                      child: Text(
                        "계속하기",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.width / 25,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 30,
                ),
              ],
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
