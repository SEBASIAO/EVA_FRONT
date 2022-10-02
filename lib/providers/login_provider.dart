import 'dart:convert';

import 'package:eva/models/login_response.dart';
import 'package:eva/models/models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginProvider extends ChangeNotifier {
  final String _baseUrl = "evabackend.azurewebsites.net";
  int loginStatus = 0;
  LoginProvider() {
    print("login Provider");
  }

  Future<LoginResponse> login(LoginBody body) async {
    var url = Uri.https(_baseUrl, '/api/login');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': body.email,
        'password': body.password,
      }),
    );
    final decodedData = LoginResponse.fromJson(response.body);
    loginStatus = decodedData.status;
    notifyListeners();
    return decodedData;
  }
}
