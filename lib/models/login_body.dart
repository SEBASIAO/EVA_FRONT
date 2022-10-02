import 'dart:convert';

class LoginBody {
  LoginBody({
    required this.email,
    required this.password,
  });

  String email;
  String password;

  factory LoginBody.fromJson(String str) => LoginBody.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LoginBody.fromMap(Map<String, dynamic> json) => LoginBody(
        email: json["email"],
        password: json["password"],
      );

  Map<String, String> toMap() => {
        "email": email,
        "password": password,
      };
}
