import 'dart:async';

import 'package:flutter/material.dart';

import 'package:petdemo/common/custom_textform.dart';
import 'package:petdemo/sign_step/widgets/blue_green_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PasswordScreen extends StatefulWidget {
  final VoidCallback? onContinuePressed;
  final String description;
  const PasswordScreen({
    super.key,
    this.onContinuePressed,
    required this.description,
  });

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  String currentText = '';
  StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();
  String text = '';

  final TextEditingController passwordController = TextEditingController();
  _onKeyboardTap(String value) {
    setState(() {
      passwordController.text += value;
    });
  }

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
                  "계정 비밀번호 설정",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: MediaQuery.of(context).size.width / 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  widget.description,
                  style: TextStyle(
                    color: Color.fromRGBO(68, 65, 66, 1),
                    fontSize: MediaQuery.of(context).size.width / 29,
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
                      CustomTextFormField(
                        obscureText: true,
                        autofocus: true,
                        textEditingController: passwordController,
                        hintText: '비밀번호를 입력해주세요.',
                        keyboardType: TextInputType.visiblePassword,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: GestureDetector(
              onTap: widget.onContinuePressed,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  BlueGreenButton(
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
                ],
              ),
            ),
          ),
          // Expanded(
          //   child: NumericKeyboard(
          //       onKeyboardTap: _onKeyboardTap,
          //       textColor: Colors.black,
          //       rightButtonFn: () {
          //         setState(() {
          //           text = text.substring(0, text.length - 1);
          //         });
          //       },
          //       rightIcon: Icon(
          //         Icons.check,
          //         color: Colors.blue,
          //       ),
          //       leftButtonFn: () {
          //         print('left button clicked');
          //       },
          //       leftIcon: Icon(
          //         Icons.backspace,
          //         color: Colors.blue,
          //       ),
          //       mainAxisAlignment: MainAxisAlignment.spaceEvenly),
          // ),
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
