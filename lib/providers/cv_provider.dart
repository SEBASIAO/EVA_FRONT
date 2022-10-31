import 'dart:convert';

import 'package:eva/models/models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CvProvider extends ChangeNotifier {
  final String _baseUrl = "evabackend.azurewebsites.net";
  List<Cv> cvList = [];
  CvProvider() {
    print("Cv Provider");
    getCvs();
  }

  getCvs() async {
    var url = Uri.https(_baseUrl, '/api/cv');
    final response = await http.get(url);
    final decodedData = CvResponse.fromJson(response.body);
    cvList = decodedData.data;
    notifyListeners();
  }

  Future<bool> addCv(Cv body) async {
    var url = Uri.https(_baseUrl, '/api/cv');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "name": body.name,
        "email": body.email,
        "doc_type": body.docType,
        "doc_number": body.docNumber,
        "phone": body.phone,
        "born_date": body.bornDate,
        "profession": body.profession,
        "education_level": body.educationLevel,
        "state": body.state,
        "city": body.city,
        "address": body.address,
        "health_care": body.healthCare,
        "pension_fund": body.pensionFund,
        "marital_status": body.maritalStatus,
        "additional_info": body.additionalInfo,
        "company_nit": body.assignedCompanyId,
      }),
    );
    print('${response.body}, code: ${response.statusCode}');
    var status = false;
    if (response.statusCode == 201) status = true;
    notifyListeners();
    return status;
  }

  Future<bool> updateCv(Cv body) async {
    var url = Uri.https(_baseUrl, '/api/cv/${body.id}');
    final response = await http.put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "name": body.name,
        "email": body.email,
        "doc_type": body.docType,
        "doc_number": body.docNumber,
        "phone": body.phone,
        "born_date": body.bornDate,
        "profession": body.profession,
        "education_level": body.educationLevel,
        "state": body.state,
        "city": body.city,
        "address": body.address,
        "health_care": body.healthCare,
        "pension_fund": body.pensionFund,
        "marital_status": body.maritalStatus,
        "additional_info": body.additionalInfo,
        "company_nit": body.assignedCompanyId,
      }),
    );
    print('${response.body}, code: ${response.statusCode}');
    var status = false;
    if (response.statusCode == 200) status = true;
    notifyListeners();
    return status;
  }

  Future<bool> deleteCv(String id) async {
    var url = Uri.https(_baseUrl, '/api/cv/$id');
    final response = await http.delete(url);
    var status = false;
    if (response.statusCode == 200) status = true;
    notifyListeners();
    return status;
  }
}
