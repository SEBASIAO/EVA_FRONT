import 'dart:convert';

import 'package:eva/models/models.dart';

class CvResponse {
  CvResponse({
    required this.data,
  });

  List<Cv> data;

  factory CvResponse.fromJson(String str) =>
      CvResponse.fromMap(json.decode(str));

  factory CvResponse.fromMap(Map<String, dynamic> json) => CvResponse(
        data: List<Cv>.from(json["data"].map((x) => Cv.fromMap(x))),
      );
}
