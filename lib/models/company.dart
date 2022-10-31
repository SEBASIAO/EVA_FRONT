import 'dart:convert';

class Company {
  Company({
    this.id,
    required this.name,
    required this.nit,
    required this.address,
    required this.phone,
    required this.manager,
    required this.managerDocNumber,
    required this.managerPhoneNumber,
  });

  String? id;
  String name;
  String nit;
  String address;
  String phone;
  String manager;
  String managerDocNumber;
  String managerPhoneNumber;

  factory Company.fromJson(String str) => Company.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Company.fromMap(Map<String, dynamic> json) => Company(
        id: json["_id"],
        name: json["name"],
        nit: json["nit"],
        address: json["address"],
        phone: json["phone"],
        manager: json["manager"],
        managerDocNumber: json["manager_doc_number"],
        managerPhoneNumber: json["manager_phone_number"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "nit": nit,
        "address": address,
        "phone": phone,
        "manager": manager,
        "manager_doc_number": managerDocNumber,
        "manager_phone_number": managerPhoneNumber,
      };
}
