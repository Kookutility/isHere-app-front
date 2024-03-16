import 'package:flutter/material.dart';
import 'package:petdemo/common/basic_layout.dart';
import 'package:dio/dio.dart';
import 'dart:convert' show utf8, jsonDecode;
import 'package:petdemo/common/custom_textform.dart';
import 'package:petdemo/sign_step/widgets/blue_green_button.dart';

class AreaSearchScreen extends StatefulWidget {
  const AreaSearchScreen({super.key});

  @override
  State<AreaSearchScreen> createState() => _AreaSearchScreenState();
}

class _AreaSearchScreenState extends State<AreaSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _searchResults = [];
  bool searchExecuted = false; //검색이 실행되지 않았을 때 출력되는 text를 위한 bool
  Future<void> _searchArea(String query) async {
    try {
      String encodedQuery = Uri.encodeComponent(query); //한글데이터를 우선 인코딩
      Dio dio = Dio();
      final response = await dio.get(
          'http://192.168.45.237:8080/area/$encodedQuery'); // 임시로 박병주 로컬 서버 주소가 들어가있음

      if (response.statusCode == 200) {
        final data = response.data;
        List<String> results = [];
        if (data is List) {
          for (var item in data) {
            if (item is Map) {
              results.add(item['areaName']); //리스트에 저장
            }
          }
        }
        print('Received data: $results'); //데이터 테스트
        setState(() {
          _searchResults = results;
          searchExecuted = true; // 검색이 진행되면 true
        });
      } else {
        setState(() {
          searchExecuted = false;
        });
        print('Failed to load data. Status code: ${response.statusCode}');
        //제대로된 검색값을 요구하는 text출력
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          '지역 검색',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: MainLayout(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Row(
              children: [
                Expanded(
                  child: CustomTextFormField(
                    textEditingController: _searchController,
                    hintText: '동, 읍, 면으로 검색 (예시: 구의동)',
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                SizedBox(
                    width: 75,
                    child: ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          searchExecuted = true; // 검색 버튼이 클릭되었음을 표시
                        });
                        await _searchArea(_searchController.text);
                      },
                      child: Text('검색', style: TextStyle(color: Colors.white)),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed)) {
                              return Color.fromRGBO(43, 170, 255, 1);
                            } else {
                              return Color.fromRGBO(61, 43, 255, 1);
                            }
                          },
                        ),
                      ),
                    )),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: searchExecuted
                ? (_searchResults.isEmpty
                    ? [
                        Column(
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                                "검색결과가 없습니다. \n ex) 서울 OO구, 전남 OO군 형식으로 입력해주세요")
                          ],
                        )
                      ]
                    : [
                        Column(
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Icon(Icons.location_on,
                                    color: Colors.deepPurple),
                                SizedBox(width: 5),
                                Text('검색 결과',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                          ],
                        )
                      ]
                  ..addAll(
                      _searchResults // TO DO: 스크롤이 가능하도록 ListView 이용하여 수정필요
                          .map((result) => [
                                GestureDetector(
                                  onTap: () {
                                    print('Tapped on $result');
                                    // TO DO: 클릭시 발생 이벤트 코드
                                  },
                                  child: Row(
                                    children: [
                                      SizedBox(width: 15),
                                      Text(result,
                                          style: TextStyle(
                                            fontSize: 16,
                                          )),
                                    ],
                                  ),
                                ),
                                Divider(),
                                SizedBox(
                                  height: 5,
                                ),
                              ])
                          .expand((item) => item)
                          .toList()))
                : [Text(" ")], // 검색을 위한 삼항연산자
          ),
        ],
      ),
    );
  }
}
