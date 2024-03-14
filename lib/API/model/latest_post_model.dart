class Post {
  //최근 게시물
  final String postTitle;
  final int reward;
  final int immediateCase;
  final String areaName;
  final String createdAt;
  final List<String> imageUrls;
  final String userName;
  //+글 전체보기
  final String description;
  final String categoryType;

  Post({
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
      : postTitle = json['postTitle'] ?? '디폴트 : 제목이용',
        reward = json['reward'] ?? 999999,
        immediateCase = json['immediateCase'] ?? 1,
        areaName = json['areaName'] ?? '디폴트 : 강남',
        createdAt = json['createdAt'] ?? '디폴트 : 2012-111-111',
        description = json['description'] ?? '디폴트 : 키킼',
        categoryType = json['categoryType'] ?? '디폴트 : 찾고 있나요??????',
        userName = json['username'] ?? "서희준이지렁",
        imageUrls = [...json['imageUrls']];
}
