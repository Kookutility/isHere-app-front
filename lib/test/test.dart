import 'package:flutter/material.dart';
import 'package:petdemo/API/service/rest_api.dart';
import 'package:petdemo/main_screens/post/write_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ApiService().saveToken(
      accessToken:
          "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VybmFtZSI6IjAxMDIyMjIzMzMzIiwic3ViIjoiMDEwMjIyMjMzMzMiLCJyb2xlIjoiUk9MRV9BRE1JTiIsImlhdCI6MTcxMDQyMTA4OSwiZXhwIjoxNzEwNDI0Njg5fQ.Y8xIzkTIWg9kJTMJf43o4rNZj7ePFVGUg9e8R4_x1Vo",
      refreshToken:
          "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VybmFtZSI6IjAxMDIyMjIzMzMzIiwic3ViIjoiMDEwMjIyMjMzMzMiLCJyb2xlIjoiUk9MRV9BRE1JTiIsImlhdCI6MTcxMDQyMTA4OSwiZXhwIjoxNzEwNDIyODg5fQ.99D8TZuhQjUuAgGDIlZmsk_nS5bM-tXAov2W-w4nMlg");
  runApp(
    MaterialApp(
      home: WriteScreen(
        categoryTypeIsFind: true,
      ),
    ),
  );
}
