import 'dart:convert';

import 'package:eva/models/assigned_company.dart';

class Cv {
  Cv({
    this.id,
    required this.name,
    required this.email,
    required this.docType,
    required this.docNumber,
    required this.phone,
    required this.bornDate,
    required this.profession,
    required this.educationLevel,
    required this.state,
    required this.city,
    required this.address,
    required this.healthCare,
    required this.pensionFund,
    required this.maritalStatus,
    required this.additionalInfo,
    this.available,
    this.assignedCompany,
    this.assignedCompanyId,
  });

  String? id;
  String name;
  String email;
  String docType;
  int docNumber;
  int phone;
  String bornDate;
  String profession;
  String educationLevel;
  String state;
  String city;
  String address;
  String healthCare;
  String pensionFund;
  String maritalStatus;
  String additionalInfo;
  String? assignedCompanyId;
  bool? available;
  AssignedCompany? assignedCompany;

  factory Cv.fromJson(String str) => Cv.fromMap(json.decode(str));

  factory Cv.fromMap(Map<String, dynamic> json) => Cv(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        docType: json["doc_type"],
        docNumber: json["doc_number"],
        phone: json["phone"],
        bornDate: json["born_date"],
        profession: json["profession"],
        educationLevel: json["education_level"],
        state: json["state"],
        city: json["city"],
        address: json["address"],
        healthCare: json["health_care"],
        pensionFund: json["pension_fund"],
        maritalStatus: json["marital_status"],
        additionalInfo: json["additional_info"],
        available: json["available"] ?? true,
        assignedCompany: json["assigned_company"] == null
            ? null
            : AssignedCompany.fromMap(json["assigned_company"]),
      );
}
