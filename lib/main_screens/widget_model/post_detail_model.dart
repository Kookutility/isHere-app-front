import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:petdemo/main_screens/widget_model/post_model.dart';

import '../../API/model/latest_post_model.dart';

class PostDetailModel extends StatefulWidget {

  @override
  State<PostDetailModel> createState() => _PostDetailModelState();
}

class _PostDetailModelState extends State<PostDetailModel> {
  final List<String> imageList = [
    'https://img.freepik.com/free-photo/cute-puppy-sitting-in-grass-enjoying-nature-playful-beauty-generated-by-artificial-intelligence_188544-84973.jpg?w=1060&t=st=1704195937~exp=1704196537~hmac=ad3a9d0c1f275c58c7df69163f8da53383d3f97fc52d5765265abfbb970f31b7',
    'https://img.freepik.com/free-photo/dog-waiting-in-the-veterinarian-office_23-2149198673.jpg?size=626&ext=jpg',
    'https://img.freepik.com/free-photo/front-view-adorable-shiba-inu-dog_23-2149457807.jpg?size=626&ext=jpg&ga=GA1.1.57940366.1704195866&semt=sph'
  ];

  late String title;
  late String category;
  late String description;
  late String place;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments as Post;
    title = args.postTitle;
    category = args.categoryType;
    place = args.areaName;
    description = args.description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Stack(
                  children: [
                    ImageSlider(imageList: imageList),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        Icons.chevron_left_rounded,
                        size: 50,
                        weight: 100,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 15,
                    top: MediaQuery.of(context).size.width / 35,
                    bottom: MediaQuery.of(context).size.width / 35,
                  ),
                  child: Row(
                    children: [
                      Container(
                        clipBehavior: Clip.hardEdge,
                        width: MediaQuery.of(context).size.width / 10,
                        height: MediaQuery.of(context).size.width / 10,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 203, 201, 201),
                          shape: BoxShape.circle,
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              top: -1,
                              left: -8,
                              child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: MediaQuery.of(context).size.width / 10,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "아프지 말고",
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width / 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "인천시 서구 가좌동",
                            style: TextStyle(
                              color: Color(0xff888686),
                              fontSize: MediaQuery.of(context).size.width / 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 2,
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              title,
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width / 23,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.visible,
                              ),
                            ),
                            Expanded(child: SizedBox(width: 8)),
                            VerticalDivider(
                              width: 2,
                              thickness: 3,
                              color: Color(0xff858585),
                              indent: 2,
                              endIndent: 2,
                            ),
                            Expanded(child: SizedBox(width: 8)),
                            Text(
                              "[ 분실물 ]",
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width / 23,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                          description,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 25,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 2,
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "분실장소",
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width / 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height / 3,
                        width: MediaQuery.of(context).size.width * 8 / 9,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: NaverMap(
                          options: const NaverMapViewOptions(),
                          onMapReady: (controller) {
                            final marker = NMarker(
                                id: 'test',
                                position: const NLatLng(
                                    37.506932467450326, 127.05578661133796));
                            final marker1 = NMarker(
                                id: 'test1',
                                position: const NLatLng(
                                    37.606932467450326, 127.05578661133796));
                            controller.addOverlayAll({marker, marker1});

                            final onMarkerInfoWindow = NInfoWindow.onMarker(
                                id: marker.info.id, text: "멋쟁이 사자처럼");
                            marker.openInfoWindow(onMarkerInfoWindow);
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ImageSlider extends StatefulWidget {
  final List<String> imageList;

  const ImageSlider({Key? key, required this.imageList}) : super(key: key);

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 3,
          child: CarouselSlider(
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height / 3,
              viewportFraction: 1,
              enlargeCenterPage: true,
              autoPlay: true,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            items: widget.imageList.map((url) {
              return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 3,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.6),
                ),
                child: Image.network(
                  url,
                  fit: BoxFit.cover,
                ),
              );
            }).toList(),
          ),
        ),
        Positioned(
          width: MediaQuery.of(context).size.width,
          bottom: 10,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.imageList.map((url) {
              int index = widget.imageList.indexOf(url);
              return Container(
                width: _currentIndex != index ? 8 : 10,
                height: _currentIndex != index ? 8 : 10,
                margin: EdgeInsets.symmetric(horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

