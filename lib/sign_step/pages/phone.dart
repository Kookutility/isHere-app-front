import 'package:flutter/material.dart';
import 'package:petdemo/common/custom_textform.dart';
import 'package:petdemo/sign_step/widgets/blue_green_button.dart';

class PhoneSignScreen extends StatelessWidget {
  final VoidCallback? onPhoneContinuePressed;
  const PhoneSignScreen({
    super.key,
    this.onPhoneContinuePressed,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController phoneNumTController = TextEditingController();
    String inputPhoneNum = "";

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
                  "전화번호 입력",
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
                  height: 17.5,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 4 / 5,
                        child: CustomTextFormField(
                          maxLength: 11,
                          textEditingController: phoneNumTController,
                          hintText: '01012345678',
                          keyboardType: TextInputType.number,
                        ),
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
              onTap: onPhoneContinuePressed,
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
