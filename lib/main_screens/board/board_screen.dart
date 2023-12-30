import 'package:flutter/widgets.dart';
import 'package:petdemo/common/basic_layout.dart';
import 'package:flutter/material.dart';


class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
    Widget build(BuildContext context) {
      return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
                    Navigator.of(context).pushNamed('/write');
                  },
          child: Text(
            '+',
            style: TextStyle(
              fontSize: 44,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: MainLayout(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40),
                  Text(
                    '    무엇을 도와드릴까요?',
                    style: TextStyle(
                      fontFamily: 'Pretendard-ExtraBold',
                      fontWeight: FontWeight.w800,
                      fontSize: 24,
                      color: Color.fromRGBO(78, 64, 234, 0.81),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: 140,
                              width: 140,
                              child: ElevatedButton(
                                onPressed: () {
                                    Navigator.of(context).pushNamed('/searchLooking');
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                ),
                                child: Text(
                                  '찾고 있어요',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 140,
                              width: 140,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamed('/searchFound');
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                ),
                                child: Text(
                                  '찾았어요',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          width: 200,
                          height: 60,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed('/map');
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),
                            child: Text(
                              '지도로 한눈에 보기',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }