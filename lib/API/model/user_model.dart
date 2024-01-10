class User {
  final int userId;
  final String phoneNumber;
  final String username;
  final String bankName;
  final String accountNumber;
  final String realName;
  final String areaName;
  final int interestPost;
  final String userName;
  final String area;

  User({
    required this.userId,
    required this.phoneNumber,
    required this.username,
    required this.bankName,
    required this.accountNumber,
    required this.realName,
    required this.areaName,
    required this.interestPost,
    required this.userName,
    required this.area,
  });

  // JSON으로부터 User 객체 생성
  User.fromJson(Map<String, dynamic> json)
      : userId = json['user_id'],
        phoneNumber = json['phone_number'],
        username = json['username'],
        bankName = json['bank_name'],
        accountNumber = json['account_number'],
        realName = json['real_name'],
        areaName = json['area_name'],
        interestPost = json['interest_post'],
        userName = json['user_name'],
        area = json['area'];
}