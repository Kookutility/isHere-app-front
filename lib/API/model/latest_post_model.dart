class Post {
  //최근 게시물
  final String postTitle;
  final int reward;
  final int immediateCase;
  final String areaName;
  final String createdAt;

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
  });

  // JSON으로부터 Post 객체 생성
  Post.fromJson(Map<String, dynamic> json)
      : postTitle = json['postTitle'],
        reward = json['reward'],
        immediateCase = json['immediateCase'],
        areaName = json['areaName'],
        createdAt = json['createdAt'],
        description = json['description'],
        categoryType = json['categoryType'];
}