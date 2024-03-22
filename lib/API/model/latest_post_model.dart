class Post {
  //최근 게시물
  final String userName,
      postTitle,
      areaName,
      createdAt,
      description,
      categoryType;
  final int postId, reward, immediateCase, transactionStatus;
  final double xLoc, yLoc;
  final List<String> imageUrls;

  //+글 전체보기

  Post({
    required this.transactionStatus,
    required this.xLoc,
    required this.yLoc,
    required this.postId,
    required this.postTitle,
    required this.reward,
    required this.immediateCase,
    required this.areaName,
    required this.createdAt,
    required this.description,
    required this.categoryType,
    required this.imageUrls,
    required this.userName,
  });

  // JSON으로부터 Post 객체 생성
  Post.fromJson(Map<String, dynamic> json)
      : postId = json['postId'] ?? 123,
        transactionStatus = json['transactionStatus'] ?? 0,
        xLoc = json['xloc'],
        yLoc = json['yloc'],
        postTitle = json['postTitle'] ?? '디폴트 : 제목이용',
        reward = json['reward'] ?? 999999,
        immediateCase = json['immediateCase'] ?? 1,
        areaName = json['areaName'] ?? '디폴트 : 강남',
        createdAt = json['createdAt'] ?? '디폴트 : 2012-111-111',
        description = json['description'] ?? '디폴트 : 키킼',
        categoryType = json['categoryType'] ?? '디폴트 : 찾고 있나요??????',
        userName = json['username'] ?? "서희준이지렁",
        imageUrls = [
          "https://www.zooseyo.com/dog_sale/photo_free/202302/1675589178_93581800.jpg"
        ];
}
