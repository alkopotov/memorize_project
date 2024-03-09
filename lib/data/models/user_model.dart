class UserModel {

  UserModel({
    required this.userId,
    required this.userName,
    required this.userLogin,
    required this.userPassword,
    required this.userAuthorized,
  });

  final String userId;
  late String userName;
  final String userLogin;
  late String userPassword;
  late bool userAuthorized;


  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      userId: json['userId'],
      userName: json['userName'],
      userLogin: json['userLogin'],
      userPassword: json['userPassword'],
      userAuthorized: json['userAuthorized'],
    );
}