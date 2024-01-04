import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  int markerNum = 0;
  // dummy data
  final marker = NMarker(
      id: 'test',
      position: const NLatLng(37.506932467450326, 127.05578661133796));
  final marker1 = NMarker(
      id: 'test1',
      position: const NLatLng(37.606932467450326, 127.05578661133796));

  Set<NMarker> markerList = {};

  /*  화면을 클릭할 때마다 마커 추가
      1. 마커리스트에 새로운 마커 추가
      2. 마커가 찍힌 좌표 출력(테스트를 위해 콘솔 출력)
      3. 빌드를 새로하면서 오버레이에 추가
  */
  addMarker(NMarker newMarker) {
    markerList.add(newMarker);
    print(newMarker.position);
    setState(() {
      mapController.addOverlayAll(markerList);
    });
  }

  late final NaverMapController mapController;

  @override
  void initState() {
    markerList.add(marker);
    markerList.add(marker1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: NaverMap(
        options: const NaverMapViewOptions(
          initialCameraPosition: NCameraPosition(
            target: NLatLng(37.506932467450326, 127.05578661133796),
            zoom: 15,
          ),
        ),
        onMapTapped: (NPoint point, NLatLng latLng) {
          final pointedMarker = NMarker(
            id: 'marker ${markerNum++}',
            position: latLng,
          );
          addMarker(pointedMarker);
        },
        onMapReady: (controller) {
          mapController = controller;
          mapController.addOverlayAll(markerList);
          final onMarkerInfoWindow =
              NInfoWindow.onMarker(id: marker.info.id, text: "구름이 발견 위치");
          marker.openInfoWindow(onMarkerInfoWindow);
          print(';hihih');
        },
      ),
    );
  }
}
