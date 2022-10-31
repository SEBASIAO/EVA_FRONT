import 'dart:convert';

import 'package:eva/models/user.dart';

class LoginResponse {
  LoginResponse({
    required this.status,
    this.user,
  });

  int status;
  User? user;

  factory LoginResponse.fromJson(String str) =>
      LoginResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LoginResponse.fromMap(Map<String, dynamic> json) => LoginResponse(
        status: json["status"],
        user: json["user"] == null ? null : User.fromMap(json["user"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "user": user,
      };
}
