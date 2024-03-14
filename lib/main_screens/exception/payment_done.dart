import 'package:flutter/material.dart';
import 'package:petdemo/sign_step/widgets/blue_green_button.dart';

class PaymentDone extends StatelessWidget {
  final VoidCallback? onDonePressed;
  const PaymentDone({
    super.key,
    required this.onDonePressed,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
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
                      child: Image.asset("assets/icons/handshake.png"),
                    ),
                    Text(
                      "사례금 전달신청이 완료됐습니다!",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: MediaQuery.of(context).size.width / 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "영업일 기준 2~3일 안에 전달됩니다.",
                      style: TextStyle(
                        color: Color(0xffA7A7A7),
                        fontSize: MediaQuery.of(context).size.width / 40,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.loose,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: onDonePressed,
                    child: BlueGreenButton(
                      child: Center(
                        child: Text(
                          "완료",
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
      ),
    );
  }
}
