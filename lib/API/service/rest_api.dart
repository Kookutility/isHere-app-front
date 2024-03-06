import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:petdemo/common/const/address.dart';

class ApiService {
  final ip = androidEmulatorIP;
  final dio = Dio();

  /* ===================== basic login& signin request ==================== */
  Future<Response?> postRequest(String toUrl, dynamic data) async {
    try {
      final Response<dynamic> response = await dio.post(
        ip + toUrl,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
        data: data,
      );

      return response;
    } on DioException catch (e) {
      debugPrint(e.message);
      return null;
    }
  }

  Future<Response?> getRequest(String toUrl, dynamic data) async {
    try {
      final Response<dynamic> response = await dio.get(
        ip + toUrl,
        data: data,
      );
      return response;
    } on DioException catch (e) {
      debugPrint(e.message);
      return null;
    }
  }

/* ============================ error Check =========================== */
  // Method to check response message errors
  Future<String> reponseMessageCheck(Response? response) async {
    if (response == null) {
      return 'error';
    }
    if (response.statusCode == 200) {
      dynamic res = jsonDecode(response.data);
      print(res);
      String data = res['message'];
      print("data ::::::: $data");
      switch (data) {
        case 'success':
        case 'login done':
        case 'signUp done':
          return 'success';
        case 'no user':
          return '!NO USER INFORMATION!';
        case 'pw mismatch':
          return '!PASSWORD MISMATCH!';
        case 'duplicated':
          return '!DUPLICATE ACCOUNT!';
        case 'gps saved':
          return 'success';
        case 'no data':
          return 'no data';
        default:
          print('=====>>>>> Response body: ${response.data}');
      }
    } else {
      print('=====>>>>> Request failed with status: ${response.statusCode}');
    }
    return ' ===== !UNEXPECTED ERROR OCCURED! ===== ';
  }
/* ============================ error Check =========================== */
}
