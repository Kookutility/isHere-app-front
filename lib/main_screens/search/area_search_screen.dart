import 'package:flutter/material.dart';
import 'package:petdemo/common/basic_layout.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show utf8, jsonDecode;

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
      final response = await http.get(Uri.parse(
          'https://port-0-petish-app-back-1fk9002blr25yq9u.sel5.cloudtype.app/area/$encodedQuery'));

      if (response.statusCode == 200) {
        final body = response.bodyBytes; // 한글 데이터가 깨지지 않게 utf8로 디코딩
        final decodedBody = utf8.decode(body); // 한글 데이터가 깨지지 않게 utf8로 디코딩
        final data = jsonDecode(decodedBody); // 한글 데이터가 깨지지 않게 utf8로 디코딩
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
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0.5,
        title: Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Row(
            children: [
              IconButton(
                onPressed: () async {
                  setState(() {
                    searchExecuted = true; // 검색 버튼이 클릭되었음을 표시
                  });
                  await _searchArea(_searchController.text);
                },
                icon: Icon(Icons.search, color: Colors.black, size: 30.0),
              ),
              Expanded(
                child: TextFormField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: '지역을 입력하세요(서울 종로구)',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: MainLayout(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: searchExecuted
                ? (_searchResults.isEmpty
                    ? [Text("검색결과가 없습니다. \n서울 OO구, 전남 OO군 형식으로 입력해주세요")]
                    : _searchResults.map((result) => Text(result)).toList())
                : [Text("검색을 위해 지역을 입력해주세요")], // 검색을 위한 삼항연산자
          ),
        ],
      ),
    );
  }
}
