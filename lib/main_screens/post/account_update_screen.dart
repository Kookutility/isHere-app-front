import 'package:flutter/material.dart';

class AccountUpdateScreen extends StatefulWidget {
  AccountUpdateScreen({Key? key}) : super(key: key);

  @override
  _AccountUpdateScreenState createState() => _AccountUpdateScreenState();
}

class _AccountUpdateScreenState extends State<AccountUpdateScreen> {
  final TextEditingController bankController = TextEditingController();
  final TextEditingController accountController = TextEditingController();
  final TextEditingController depositorController = TextEditingController();

  bool isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    bankController.addListener(checkTextField);
    accountController.addListener(checkTextField);
    depositorController.addListener(checkTextField);
  }

  void checkTextField() {
    if (bankController.text.isNotEmpty &&
        accountController.text.isNotEmpty &&
        depositorController.text.isNotEmpty) {
      setState(() {
        isButtonEnabled = true;
      });
    } else {
      setState(() {
        isButtonEnabled = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            TextField(
              controller: bankController,
              decoration: InputDecoration(
                labelText: '은행이름',
              ),
            ),
            TextField(
              controller: accountController,
              decoration: InputDecoration(
                labelText: '계좌번호',
              ),
            ),
            TextField(
              controller: depositorController,
              decoration: InputDecoration(
                labelText: '예금자명',
              ),
            ),
            ElevatedButton(
              onPressed: isButtonEnabled
                  ? () {
                      // 서버와 통신하는 코드를 여기에 작성하세요.
                    }
                  : null,
              child: Text('제출'),
            ),
          ],
        ),
      ),
    );
  }
}
