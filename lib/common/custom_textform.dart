import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final bool? hasError;
  final String? hintText;
  final String? errorText;
  final bool obscureText;
  final bool autofocus;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final Icon? prefixIcon;
  final TextEditingController? textEditingController;
  final int? maxLength;

  // Constructor for a login-style form field
  const CustomTextFormField({
    super.key,
    this.maxLength,
    this.onChanged,
    this.hasError,
    this.autofocus = false,
    this.obscureText = false,
    this.hintText,
    this.errorText,
    this.validator,
    this.focusNode,
    this.keyboardType,
    this.prefixIcon,
    this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    final baseBorder = UnderlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromRGBO(130, 134, 147, 1),
        width: 2,
      ),
    );

    return TextFormField(
      controller: textEditingController,
      style: const TextStyle(fontSize: 15.0),
      keyboardType: keyboardType,
      enableSuggestions: true,
      validator: validator,
      focusNode: focusNode,
      textAlign: TextAlign.left,
      cursorColor: Colors.black,
      obscureText: obscureText,
      onChanged: onChanged,
      maxLength: maxLength,
      buildCounter: (BuildContext context,
              {int? currentLength, int? maxLength, bool? isFocused}) =>
          null,
      decoration: InputDecoration(
        prefixIconColor: hasError == null
            ? null
            : hasError!
                ? Colors.red
                : Colors.blue,
        prefixIcon: prefixIcon,
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Color.fromRGBO(68, 65, 66, 1),
          fontSize: 19.0,
        ),
        errorText: errorText,
        errorStyle: const TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.bold,
        ),
        fillColor: Colors.white,
        filled: true,
        border: baseBorder,
        enabledBorder: baseBorder,
        focusedBorder: baseBorder.copyWith(
          borderSide: baseBorder.borderSide.copyWith(
            width: 2,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
