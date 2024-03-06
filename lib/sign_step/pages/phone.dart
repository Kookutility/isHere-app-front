import 'package:flutter/material.dart';
import 'package:petdemo/sign_step/widgets/blue_green_button.dart';
import 'package:petdemo/sign_step/widgets/phone_text_field.dart';

class PhoneField extends StatefulWidget {
  final VoidCallback? onPhoneContinuePressed;
  final ValueChanged? getPhoneNum;
  const PhoneField({
    super.key,
    this.getPhoneNum,
    this.onPhoneContinuePressed,
  });

  @override
  State<PhoneField> createState() => _PhoneFieldState();
}

class _PhoneFieldState extends State<PhoneField> {
  String initialValue = "9867243682"; // Dummy current phone number
  int selectedCountryCode = 977;
  bool isValid = false;
  bool canContinue = false;
  int recievedVerficationCode = 1234; // Dummy verification code

  TextEditingController phoneNumController = TextEditingController();
  final List<TextEditingController> digitControllers =
      List.generate(4, (index) => TextEditingController());

  List<int> alreadyUsedNumbers = [
    1234567890,
    4477123456,
    6141234567,
  ];

  List<int> bannedPhoneNumbers = [
    2222244444,
    3333355555,
  ];

  void onValueChanged(bool value) {
    setState(() {
      isValid = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController phoneNumTController = TextEditingController();

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 5 / 6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
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
                  height: 20,
                ),
                PhoneNumberEditField(
                  textEditingController: phoneNumController,
                  selectedCountryCode: selectedCountryCode,
                  onValueChanged: onValueChanged,
                ),
              ],
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: widget.onPhoneContinuePressed,
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
