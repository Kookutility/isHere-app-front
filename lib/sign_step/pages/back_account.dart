import 'package:flutter/material.dart';
import 'package:petdemo/sign_step/widgets/blue_green_button.dart';

class BankAccountField extends StatelessWidget {
  final VoidCallback? onAccountStartPressed;
  const BankAccountField({
    super.key,
    this.onAccountStartPressed,
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
                  Text(
                    "계좌번호 입력",
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
              onTap: onAccountStartPressed,
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
