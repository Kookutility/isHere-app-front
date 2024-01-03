import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: NaverMap(
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
          final marker = NMarker(
              id: 'marker1',
              position: const NLatLng(37.506932467450326, 127.05578661133796));
          final marker1 = NMarker(
              id: 'marker2',
              position: const NLatLng(37.606932467450326, 127.05578661133796));
          controller.addOverlayAll({marker, marker1});

          final onMarkerInfoWindow =
              NInfoWindow.onMarker(id: marker.info.id, text: "구름이");
          marker.openInfoWindow(onMarkerInfoWindow);
        },
      ),
    );
  }
}
