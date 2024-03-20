import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:petdemo/API/service/rest_api.dart';
import 'package:petdemo/main_screens/post/write_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NaverMapSdk.instance.initialize(clientId: 'raopvm5gte');
  ApiService().saveToken(
      accessToken:
          "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VybmFtZSI6IjAxMDIyMjIzMzMzIiwic3ViIjoiMDEwMjIyMjMzMzMiLCJyb2xlIjoiUk9MRV9BRE1JTiIsImlhdCI6MTcxMDkzODY2NiwiZXhwIjoxNzEwOTQyMjY2fQ.tPMxKfzlZWFihjbpE2dfUL7E8kpCZnoVrlmLgyfmTUM",
      refreshToken:
          "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VybmFtZSI6IjAxMDIyMjIzMzMzIiwic3ViIjoiMDEwMjIyMjMzMzMiLCJyb2xlIjoiUk9MRV9BRE1JTiIsImlhdCI6MTcxMDQyNDkyMSwiZXhwIjoxNzEwNDI2NzIxfQ.zNSoi43B4-AQ51NHYyhAwtHr8dXxZtDnWd5kHV1bSv4");
  runApp(
    MaterialApp(
      home: WriteScreen(
        categoryTypeIsFind: true,
      ),
    ),
  );
}
