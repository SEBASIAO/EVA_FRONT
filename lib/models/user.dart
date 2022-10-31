import 'dart:convert';

class User {
  User({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    this.admin,
  });

  String? id;
  String name;
  String email;
  String password;
  bool? admin;

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        admin: json["admin"] ?? false,
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "name": name,
        "email": email,
        "password": password,
        "admin": admin,
      };
}
