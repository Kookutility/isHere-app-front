import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:petdemo/common/custom_textform.dart';
import 'package:petdemo/sign_step/const/lists_phone.dart';

class PhoneNumberEditField extends StatefulWidget {
  final TextEditingController textEditingController;
  int selectedCountryCode;
  final void Function(bool)? onValueChanged;
  PhoneNumberEditField(
      {super.key,
      required this.textEditingController,
      required this.selectedCountryCode,
      this.onValueChanged});

  @override
  State<PhoneNumberEditField> createState() => _PhoneNumberEditFieldState();
}

class _PhoneNumberEditFieldState extends State<PhoneNumberEditField> {
  bool isFieldEmpty = true;
  bool isValid = false;
  String selectedCountryCode = "🇺🇸 (+1)";

  void changingFieldState(String fieldText) {
    if (fieldText.isNotEmpty) {
      setState(() {
        isFieldEmpty = false;
      });

      setState(() {
        if (fieldText.length == 10) {
          isValid = true;
        } else {
          isValid = false;
        }
      });
    } else {
      setState(() {
        isFieldEmpty = true;
        isValid = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    changingFieldState(widget.textEditingController.text);

    // the selected integer code into String of the country code with flag
    for (String item in countryListWithFlags) {
      if (item.contains("+${widget.selectedCountryCode}")) {
        setState(() {
          selectedCountryCode = item;
        });
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          fit: FlexFit.loose,
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide.none,
                left: BorderSide.none,
                right: BorderSide.none,
                bottom: BorderSide(
                  color: Color.fromRGBO(130, 134, 147, 1),
                  width: 2,
                ),
              ),
            ),
            child: DropdownButton<String>(
              value: selectedCountryCode,
              onChanged: (String? newValue) {
                setState(() {
                  selectedCountryCode = newValue!;
                  widget.selectedCountryCode = int.parse(
                      newValue.split('(')[1].split(')')[0].split('+')[1]);
                });
              },
              items: countryListWithFlags
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Row(
                    children: [
                      Text(
                        value.substring(0, value.indexOf(' ')),
                        style: const TextStyle(fontSize: 10),
                      ), // Extracting flag emoji
                      const SizedBox(width: 5),
                      Text(
                        value.split('(')[1].split(')')[0],
                        style: const TextStyle(fontSize: 15),
                      ), // Extracting country code
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Flexible(
          fit: FlexFit.loose,
          flex: 2,
          child: TextField(
            maxLength: 11,
            buildCounter: (BuildContext context,
                    {int? currentLength, int? maxLength, bool? isFocused}) =>
                null,
            controller: widget.textEditingController,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly
            ], // For allowing numeric values only
            onChanged: (String text) {
              changingFieldState(text);
              widget.onValueChanged!(isValid);
            },
            decoration: InputDecoration(
                border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(130, 134, 147, 1),
                    width: 2,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(130, 134, 147, 1),
                    width: 2,
                  ),
                ),
                errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(130, 134, 147, 1),
                    width: 2,
                  ),
                ),
                hintText: "0000000",
                hintStyle: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
                suffixIcon: GestureDetector(
                  child: IconButton(
                    onPressed: () {
                      widget.textEditingController.clear();
                      setState(() {
                        isFieldEmpty = true;
                      });
                    },
                    icon: Icon(
                      Icons.clear,
                      color: Colors.grey[700],
                    ),
                  ),
                )),
          ),
        ),
      ],
    );
  }
}
