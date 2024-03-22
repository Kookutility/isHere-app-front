class LocationPinModel {
  final int postId, immediateCase;
  final double xLoc, yLoc;

  LocationPinModel.fromJson(Map<String, dynamic> json)
      : postId = json['postId'],
        immediateCase = json['immediateCase'],
        xLoc = json['xloc'],
        yLoc = json['yloc'];
}
