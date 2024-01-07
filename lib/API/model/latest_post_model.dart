class Post {
  final String postTitle;
  final int reward;
  final String areaName;
  final String createdAt;

  Post({
    required this.postTitle,
    required this.reward,
    required this.areaName,
    required this.createdAt,
  });

  // JSON으로부터 Post 객체 생성
  Post.fromJson(Map<String, dynamic> json)
      : postTitle = json['postTitle'],
        reward = json['reward'],
        areaName = json['areaName'],
        createdAt = json['createdAt'];
}
