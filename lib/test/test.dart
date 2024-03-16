import 'package:flutter/material.dart';
import 'package:petdemo/API/service/rest_api.dart';
import 'package:petdemo/main_screens/ishere_main.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ApiService().saveToken(
      accessToken:
          "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VybmFtZSI6IjAxMDIyMjIzMzMzIiwic3ViIjoiMDEwMjIyMjMzMzMiLCJyb2xlIjoiUk9MRV9BRE1JTiIsImlhdCI6MTcxMDQyNDkyMSwiZXhwIjoxNzEwNDI4NTIxfQ.bXjuGGRPYGf9i87-2eNqXNex8OKsSyvpLBh1JQLI_KE",
      refreshToken:
          "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VybmFtZSI6IjAxMDIyMjIzMzMzIiwic3ViIjoiMDEwMjIyMjMzMzMiLCJyb2xlIjoiUk9MRV9BRE1JTiIsImlhdCI6MTcxMDQyNDkyMSwiZXhwIjoxNzEwNDI2NzIxfQ.zNSoi43B4-AQ51NHYyhAwtHr8dXxZtDnWd5kHV1bSv4");
  runApp(
    MaterialApp(
      home: IsHereMain(), // 박병주 테스트 사용중
    ),
  );
}
