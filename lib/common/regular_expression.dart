import 'package:flutter/material.dart';

class RectularExp {
  /* ---------------------- validation for email  ----------------------*/
  static String? validateEmail(FocusNode focusNode, String value) {
    if (value.isEmpty) {
      focusNode.requestFocus();
      return 'Put your Email.';
    } else {
      String pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regExp = RegExp(pattern);

      if (!regExp.hasMatch(value)) {
        focusNode.requestFocus();

        if (value.contains(' ')) {
          return 'Email should not contain spaces';
        } else if (!value.contains('@')) {
          return 'Email should contain @ symbol';
        } else if (value.startsWith('@') || value.endsWith('@')) {
          return 'Invalid position of @ symbol';
        } else if (value.split('@')[1].contains('.') == false) {
          return 'Email should contain at least one dot after @';
        } else {
          return 'Invalid Email format';
        }
      } else {
        return null;
      }
    }
  }

  static String? validateStudentID(FocusNode focusNode, String? value) {
    if (value != null) {
      if (value.isEmpty) {
        focusNode.requestFocus();
        return '학번을 입력하세요';
      } else {
        String patternID = r'^([0-9]{9})$';

        RegExp regExpID = RegExp(patternID);

        if (!regExpID.hasMatch(value)) {
          focusNode.requestFocus();
          return '9자리의 학번을 입력하세요';
        }
      }
    }
    return null;
  }

/* ---------------------- validation for phone Number ---------------------- */
  static String? validatePhoneNumber(FocusNode focusNode, String? value) {
    if (value != null) {
      if (value.isEmpty) {
        focusNode.requestFocus();
        return '전화번호를 입력하세요';
      } else {
        String patternKR = r'^010([0-9]{4})([0-9]{4})$';

        RegExp regExpKR = RegExp(patternKR);

        if (!regExpKR.hasMatch(value)) {
          focusNode.requestFocus(); // focusing on this textformfield
          return '010으로 시작하는 8자리 번호를 입력하세요.';
        }
      }
    }
    return null;
  }

/* ---------------------- validation for password ---------------------- */
  static String? validatePassword(FocusNode focusNode, String? value) {
    if (value != null) {
      if (value.isEmpty) {
        focusNode.requestFocus();
        return '비밀번호를 입력하세요.';
      } else {
        if (value.length < 8 || value.length > 15) {
          focusNode.requestFocus();
          return '8-15자리의 비밀번호를 생성하세요.';
        }
        if (!RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(value)) {
          focusNode.requestFocus();
          return '특수문자 하나 이상이 필요합니다.';
        }
        if (!RegExp(r'[a-z]').hasMatch(value)) {
          focusNode.requestFocus();
          return '소문자 하나 이상이 필요합니다.';
        }
        if (!RegExp(r'[0-9]').hasMatch(value)) {
          focusNode.requestFocus();
          return '숫자 하나 이상이 필요합니다.';
        }
      }
    }
    return null;
  }

/* ---------------------- validation for name or username ----------------------*/
  static String? validateName(FocusNode focusNode, String value) {
    if (value.isEmpty) {
      focusNode.requestFocus();
      return '이름을 입력하세요.';
    }

    if (value.length < 2 || value.length > 5) {
      focusNode.requestFocus();
      return '2자리에서 5자리 사이의 이름을 입력하세요.';
    }

    if (RegExp(r'^[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/').hasMatch(value)) {
      focusNode.requestFocus();
      return '이름은 한글만 포함할 수 있습니다.';
    }

    return null;
  }
}
