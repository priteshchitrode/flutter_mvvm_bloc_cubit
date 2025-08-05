class LoginModel {
  LoginModel({
    required this.token,
  });

  final String token;

  LoginModel copyWith({
    String? token,
  }) {
    return LoginModel(
      token: token ?? this.token,
    );
  }

  factory LoginModel.fromJson(Map<String, dynamic> json){
    return LoginModel(
      token: json["token"] ?? "",
    );
  }

}
