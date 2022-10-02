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
}
