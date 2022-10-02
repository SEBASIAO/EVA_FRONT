import 'dart:convert';

class LoginResponse {
  LoginResponse({
    required this.status,
    this.user,
  });

  int status;
  dynamic user;

  factory LoginResponse.fromJson(String str) =>
      LoginResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LoginResponse.fromMap(Map<String, dynamic> json) => LoginResponse(
        status: json["status"],
        user: json["user"],
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "user": user,
      };
}
