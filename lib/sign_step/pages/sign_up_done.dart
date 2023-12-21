import 'package:flutter/material.dart';
import 'package:petdemo/sign_step/widgets/blue_green_button.dart';

class SignUpDoneScreen extends StatelessWidget {
  final VoidCallback? onDonePressed;

  const SignUpDoneScreen({
    super.key,
    this.onDonePressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 3 / 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 2,
            fit: FlexFit.loose,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 5,
                    height: MediaQuery.of(context).size.width / 5,
                    child: Image.asset("assets/icons/check_gradation.png"),
                  ),
                  Text(
                    "회원가입 완료",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: MediaQuery.of(context).size.width / 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 150,
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            fit: FlexFit.loose,
            child: GestureDetector(
              onTap: onDonePressed,
              child: BlueGreenButton(
                child: Center(
                  child: Text(
                    "시작하기",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.width / 25,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
