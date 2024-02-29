import 'package:flutter/material.dart';
import 'package:petdemo/sign_step/widgets/blue_green_button.dart';

class CondTermScreen extends StatelessWidget {
  final VoidCallback? onCondAgreePressed;
  const CondTermScreen({
    super.key,
    this.onCondAgreePressed,
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "법적 동의",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: MediaQuery.of(context).size.width / 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "서비스 이용을 위해서는 동의가 필요해요.",
                style: TextStyle(
                  color: Color.fromRGBO(68, 65, 66, 1),
                  fontSize: MediaQuery.of(context).size.width / 23,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2,
                color: Color.fromRGBO(224, 224, 224, 1),
              ),
            ],
          ),
          GestureDetector(
            onTap: onCondAgreePressed,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                BlueGreenButton(
                  child: Center(
                    child: Text(
                      "내용을 숙지했으며 동의합니다.",
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
        ],
      ),
    );
  }
}
