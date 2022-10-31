import 'dart:convert';

class AssignedCompany {
  AssignedCompany({
    required this.id,
    required this.name,
    required this.nit,
    required this.address,
    required this.phone,
    required this.manager,
    required this.managerDocNumber,
    required this.managerPhoneNumber,
  });

  String id;
  String name;
  String nit;
  String address;
  String phone;
  String manager;
  String managerDocNumber;
  String managerPhoneNumber;

  factory AssignedCompany.fromJson(String str) =>
      AssignedCompany.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AssignedCompany.fromMap(Map<String, dynamic> json) => AssignedCompany(
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
        "_id": id,
        "name": name,
        "nit": nit,
        "address": address,
        "phone": phone,
        "manager": manager,
        "manager_doc_number": managerDocNumber,
        "manager_phone_number": managerPhoneNumber,
      };
}
