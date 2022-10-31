import 'dart:convert';

import 'package:eva/models/company.dart';
import 'package:eva/models/company_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CompanyProvider extends ChangeNotifier {
  final String _baseUrl = "evabackend.azurewebsites.net";
  List<Company> companies = [];
  CompanyProvider() {
    print("Company Provider");
    getCompanies();
  }

  getCompanies() async {
    var url = Uri.https(_baseUrl, '/api/company');
    final response = await http.get(url);
    final decodedData = CompanyResponse.fromJson(response.body);
    companies = decodedData.data;
    notifyListeners();
  }

  Future<bool> addCompany(Company body) async {
    var url = Uri.https(_baseUrl, '/api/company');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': body.name,
        'nit': body.nit,
        'address': body.address,
        'phone': body.phone,
        'manager': body.manager,
        'manager_doc_number': body.managerDocNumber,
        'manager_phone_number': body.managerPhoneNumber,
      }),
    );
    var status = false;
    if (response.statusCode == 201) status = true;
    notifyListeners();
    return status;
  }

  Future<bool> updateCompany(Company body) async {
    var url = Uri.https(_baseUrl, '/api/company/${body.id}');
    final response = await http.put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': body.name,
        'nit': body.nit,
        'address': body.address,
        'phone': body.phone,
        'manager': body.manager,
        'manager_doc_number': body.managerDocNumber,
        'manager_phone_number': body.managerPhoneNumber,
      }),
    );
    var status = false;
    if (response.statusCode == 200) status = true;
    notifyListeners();
    return status;
  }

  Future<bool> deleteCompany(String id) async {
    var url = Uri.https(_baseUrl, '/api/company/$id');
    final response = await http.delete(url);
    print(response.statusCode);
    var status = false;
    if (response.statusCode == 200) status = true;
    notifyListeners();
    return status;
  }
}
