import 'package:flutter/material.dart';
import 'package:petdemo/API/service/rest_api.dart';
import 'package:petdemo/main_screens/post/write_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final dio = ApiService();
  dio.saveToken(
    accessToken:
        "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VybmFtZSI6IjAxMDIyMjIzMzMzIiwic3ViIjoiMDEwMjIyMjMzMzMiLCJyb2xlIjoiUk9MRV9BRE1JTiIsImlhdCI6MTcxMDMzOTE0NywiZXhwIjoxNzEwMzQyNzQ3fQ.31oC8_eJvCqqrmq6nZyJht3Pij4uiA0p_V0NF1JHqII",
    refreshToken:
        "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VybmFtZSI6IjAxMDIyMjIzMzMzIiwic3ViIjoiMDEwMjIyMjMzMzMiLCJyb2xlIjoiUk9MRV9BRE1JTiIsImlhdCI6MTcxMDMzNjIyNCwiZXhwIjoxNzEwMzM4MDI0fQ.3-nXZsqdb7ewJxcRfcL52QNGXFvh03NWrO5MxMWmtX0",
  );
  runApp(
    MaterialApp(
      home: WriteScreen(),
    ),
  );
}
