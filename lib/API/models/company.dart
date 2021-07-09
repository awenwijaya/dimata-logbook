// To parse this JSON data, do
//
//     final company = companyFromJson(jsonString);

import 'dart:convert';

List<Company> companyFromJson(String str) => List<Company>.from(json.decode(str).map((x) => Company.fromJson(x)));

String companyToJson(List<Company> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Company {
  Company({
    this.companyId,
    this.company,
    this.description,
    this.companyCode,
  });

  int companyId;
  String company;
  String description;
  int companyCode;

  factory Company.fromJson(Map<String, dynamic> json) => Company(
    companyId: json["companyId"],
    company: json["company"],
    description: json["description"],
    companyCode: json["companyCode"],
  );

  Map<String, dynamic> toJson() => {
    "companyId": companyId,
    "company": company,
    "description": description,
    "companyCode": companyCode,
  };
}
