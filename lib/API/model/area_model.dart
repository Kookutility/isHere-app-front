class Area {
  final String areaName; // areaName 속성

  Area({required this.areaName}); // 생성자

  // JSON을 Area 객체로 변환하는 팩토리 메서드, area_name은 리스트 형태(검색시 도출)
  factory Area.fromJson(Map<String, dynamic> json) {
    return Area(
      areaName: json['areaName'],
    );
  }
}