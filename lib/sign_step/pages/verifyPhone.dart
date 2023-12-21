import 'package:flutter/material.dart';

import 'package:petdemo/common/custom_textform.dart';
import 'package:petdemo/sign_step/widgets/blue_green_button.dart';

class VerifyPhoneScreen extends StatelessWidget {
  final VoidCallback? onVerifyContinuePressed;
  const VerifyPhoneScreen({
    super.key,
    this.onVerifyContinuePressed,
  });

  @override
  Widget build(BuildContext context) {
    const String leftTime = "4:58";
    final List<FocusNode> focusNode = [
      FocusNode(),
      FocusNode(),
      FocusNode(),
      FocusNode(),
      FocusNode(),
      FocusNode(),
    ];
    final TextEditingController phoneNumTController = TextEditingController();
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                          focusNode.length,
                          (index) => SingleNum(
                            focusNode: focusNode[index],
                          ),
                        ),
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
                    ],
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: GestureDetector(
              onTap: onVerifyContinuePressed,
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
