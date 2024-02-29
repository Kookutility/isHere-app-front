import 'package:flutter/material.dart';
import 'package:petdemo/sign_step/widgets/blue_green_button.dart';
import 'package:tosspayments_widget_sdk_flutter/model/payment_info.dart';
import 'package:tosspayments_widget_sdk_flutter/model/payment_widget_options.dart';
import 'package:tosspayments_widget_sdk_flutter/payment_widget.dart';
import 'package:tosspayments_widget_sdk_flutter/widgets/agreement.dart';
import 'package:tosspayments_widget_sdk_flutter/widgets/payment_method.dart';

class PaymentScreenForPost extends StatefulWidget {
  const PaymentScreenForPost({super.key});

  @override
  State<PaymentScreenForPost> createState() {
    return _TossPaymentWidgetState();
  }
}

class _TossPaymentWidgetState extends State<PaymentScreenForPost> {
  late PaymentWidget _paymentWidget;
  PaymentMethodWidgetControl? _paymentMethodWidgetControl;
  AgreementWidgetControl? _agreementWidgetControl;
  String imageURL =
      'https://img.freepik.com/free-photo/cute-puppy-sitting-in-grass-enjoying-nature-playful-beauty-generated-by-artificial-intelligence_188544-84973.jpg?w=1060&t=st=1704195937~exp=1704196537~hmac=ad3a9d0c1f275c58c7df69163f8da53383d3f97fc52d5765265abfbb970f31b7';
  String titleLarge = '일산 서구 건지 공원에서 잃어버린 여루미 찾습니다.';
  String userName = '';
  int price = 300000;
  String postedTime = '';
  int commissionPercent = 1;

  bool isConfirm = true;
  @override
  void initState() {
    super.initState();

    _paymentWidget = PaymentWidget(
        clientKey: "test_gck_docs_Ovk5rk1EwkEbP0W43n07xlzm",
        customerKey: "a1b2c3d4e5f67890");

    _paymentWidget
        .renderPaymentMethods(
            selector: 'methods',
            amount: Amount(value: 300, currency: Currency.KRW, country: "KR"))
        .then((control) {
      _paymentMethodWidgetControl = control;
    });

    _paymentWidget.renderAgreement(selector: 'agreement').then((control) {
      _agreementWidgetControl = control;
    });
  }

  String numberWithCommas(int value) {
    return value.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match match) => '${match[1]},',
        );
  }

  @override
  Widget build(BuildContext context) {
    BoxDecoration contentBoxDeco = BoxDecoration(
      border: Border.all(
        color: Color(0xffE6E6E6),
        width: 2,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(5),
      ),
    );
    Size mediaQuerySize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '분실물 등록',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: mediaQuerySize.width / 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: mediaQuerySize.width,
          height: mediaQuerySize.height,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: mediaQuerySize.width / 20,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: mediaQuerySize.height / 40,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: mediaQuerySize.width,
                        decoration: contentBoxDeco,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "사례금 등록 정보",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: mediaQuerySize.width / 25,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: contentBoxDeco,
                        child: Content(
                          imageURL: imageURL,
                          titleLarge: titleLarge,
                          price: numberWithCommas(price),
                          userName: userName,
                          postedTime: postedTime,
                        ),
                      ),
                      Container(
                        decoration: contentBoxDeco.copyWith(
                          color: Color.fromRGBO(
                            78,
                            64,
                            234,
                            0.1,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 8,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "결제 금액",
                                    style: TextStyle(
                                      fontSize: mediaQuerySize.width / 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "(기타 소득세 및 수수료 포함)",
                                    style: TextStyle(
                                      fontSize: mediaQuerySize.width / 35,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xf0484848),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                '${numberWithCommas(price + price * commissionPercent ~/ 100)}원',
                                style: TextStyle(
                                  color: Color(0xff4E40EA),
                                  fontSize: mediaQuerySize.width / 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        PaymentMethodWidget(
                          paymentWidget: _paymentWidget,
                          selector: 'methods',
                        ),
                        AgreementWidget(
                            paymentWidget: _paymentWidget,
                            selector: 'agreement'),
                        GestureDetector(
                          onTap: () async {
                            final paymentResult =
                                await _paymentWidget.requestPayment(
                                    paymentInfo: const PaymentInfo(
                                        orderId: 'OrderId_123',
                                        orderName: '파란티셔츠 외 2건'));
                            if (paymentResult.success != null) {
                              // 결제 성공 처리
                            } else if (paymentResult.fail != null) {
                              // 결제 실패 처리

                              final selectedPaymentMethod =
                                  await _paymentMethodWidgetControl
                                      ?.getSelectedPaymentMethod();
                              print(
                                  '${selectedPaymentMethod?.method} ${selectedPaymentMethod?.easyPay?.provider ?? ''}');

                              final agreementStatus =
                                  await _agreementWidgetControl
                                      ?.getAgreementStatus();
                              print('${agreementStatus?.agreedRequiredTerms}');
                            }
                          },
                          child: BlueGreenButton(
                            child: Center(
                              child: Text(
                                "결제하기",
                                style: TextStyle(
                                  color: isConfirm ? Colors.white : Colors.grey,
                                  fontSize: mediaQuerySize.width / 25,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Content extends StatelessWidget {
  const Content({
    super.key,
    required this.imageURL,
    required this.titleLarge,
    required this.price,
    required this.userName,
    required this.postedTime,
  });

  final String imageURL;
  final String titleLarge;
  final String price;
  final String userName;
  final String postedTime;

  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;
    TextStyle blueText = TextStyle(
      color: Color(0xff4E40EA),
      fontSize: mediaQuerySize.width / 25,
      fontWeight: FontWeight.bold,
    );
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            clipBehavior: Clip.hardEdge,
            width: mediaQuerySize.width / 5,
            height: mediaQuerySize.width / 5,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Color.fromRGBO(237, 237, 237, 1),
              border: Border.all(
                color: Color(0xffE6E6E6),
                width: 1,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Image.network(
              imageURL,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  titleLarge,
                  style: TextStyle(
                    fontFamily: 'Pretendard-ExtraBold',
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width / 30,
                    color: Colors.black,
                    overflow: TextOverflow.visible,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "사례금 :",
                  style: TextStyle(
                    fontFamily: 'Pretendard-ExtraBold',
                    fontWeight: FontWeight.bold,
                    fontSize: mediaQuerySize.width / 30,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "$price 원",
                  style: blueText,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
