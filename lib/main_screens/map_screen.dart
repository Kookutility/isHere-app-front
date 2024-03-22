import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:petdemo/API/model/latest_post_model.dart';
import 'package:petdemo/API/model/location_pin_model.dart';
import 'package:petdemo/API/service/rest_api.dart';
import 'package:petdemo/main_screens/post/component/post_detail_model.dart';
import 'package:petdemo/main_screens/post/component/post_model.dart';

class MapScreen extends StatefulWidget {
  final ValueChanged? getLoc;
  const MapScreen({
    super.key,
    this.getLoc,
  });

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Future<List<LocationPinModel>> getLocations() async {
    final getLoc = ApiService();
    final response = await getLoc.getRequest('/locationFind', null);
    final receivedData = await getLoc.reponseMessageCheck(response);
    print('receivedData : $receivedData');
    if (receivedData == null) return [];
    List<LocationPinModel> data = [];
    int count = 1;
    for (var record in receivedData) {
      print(count++);
      LocationPinModel model = LocationPinModel.fromJson(record);
      data.add(model);
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: FutureBuilder<List<LocationPinModel>>(
        future: getLocations(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            print(snapshot.data);
            return Center(child: CupertinoActivityIndicator());
          }

          return NaverMap(
            options: const NaverMapViewOptions(
              initialCameraPosition: NCameraPosition(
                target: NLatLng(
                  37.506932467450326,
                  127.05578661133796,
                ),
                zoom: 11,
              ),
            ),
            onMapReady: (controller) {
              double y = 0.01;
              double x = 0.01;
              for (var data in snapshot.data!) {
                y += 0.01;
                x -= 0.01;
                var currentMarker = NMarker(
                  id: data.postId.toString(),
                  position: NLatLng(
                    37.506932467450326 + x,
                    127.05578661133796 + y,
                  ),
                );
                controller.addOverlay(currentMarker);
                var onMarkerInfoWindow = NInfoWindow.onMarker(
                    id: currentMarker.info.id, text: "${data.postId}");
                currentMarker.openInfoWindow(onMarkerInfoWindow);

                currentMarker.setOnTapListener((NMarker marker) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return FutureBuilder<Post?>(future: () async {
                          final getPostDetail = ApiService(context: context);
                          final response = await getPostDetail.getRequest(
                              '/board/${data.postId}', null);
                          final receivedData =
                              await getPostDetail.reponseMessageCheck(response);
                          print('receivedData : $receivedData');
                          if (receivedData == null) return null;
                          return Post.fromJson(receivedData);
                        }(), builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return CupertinoActivityIndicator();
                          }

                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return PostDetailModel();
                                  },
                                  settings: RouteSettings(
                                    arguments: snapshot.data,
                                  ),
                                ),
                              );
                            },
                            child: AlertDialog(
                              content: PostModel(
                                title: data.postId.toString(),
                                price: "10000",
                                deal: "h",
                                place: "서울 강남구",
                                postedTime: "2024-03-25",
                                imageURL:
                                    "https://www.zooseyo.com/dog_sale/photo_free/202302/1675589178_93581800.jpg",
                              ),
                            ),
                          );
                        });
                      });
                });
              }
            },
          );
        },
      ),
    );
  }
}
