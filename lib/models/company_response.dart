import 'dart:convert';

import 'package:eva/models/company.dart';

class CompanyResponse {
  CompanyResponse({
    required this.data,
  });

  List<Company> data;

  factory CompanyResponse.fromJson(String str) =>
      CompanyResponse.fromMap(json.decode(str));

  factory CompanyResponse.fromMap(Map<String, dynamic> json) => CompanyResponse(
        data: List<Company>.from(json["data"].map((x) => Company.fromMap(x))),
      );
}
