class User {

  User({
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


  Map<String, dynamic> toJson() => {
    'userId': userId,
    'userName': userName,
    'userLogin': userLogin,
    'userPassword': userPassword,
    'userAuthorized': userAuthorized,
  };
  
  factory User.fromJson(Map<String, dynamic> json) => User(
      userId: json['userId'],
      userName: json['userName'],
      userLogin: json['userLogin'],
      userPassword: json['userPassword'],
      userAuthorized: json['userAuthorized'],
    );
}