// To parse this JSON data, do
//
//     final pengguna = penggunaFromJson(jsonString);

import 'dart:convert';

List<Pengguna> penggunaFromJson(String str) => List<Pengguna>.from(json.decode(str).map((x) => Pengguna.fromJson(x)));

String penggunaToJson(List<Pengguna> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Pengguna {
  Pengguna({
    this.userId,
    this.loginId,
    this.password,
    this.fullName,
    this.description,
    this.regDate,
    this.updateDate,
    this.userStatus,
    this.lastLoginDate,
    this.lastLoginIp,
    this.userType,
    this.employeeId,
    this.email,
  });

  int userId;
  String loginId;
  String password;
  String fullName;
  dynamic description;
  DateTime regDate;
  dynamic updateDate;
  int userStatus;
  dynamic lastLoginDate;
  dynamic lastLoginIp;
  int userType;
  int employeeId;
  String email;

  factory Pengguna.fromJson(Map<String, dynamic> json) => Pengguna(
    userId: json["userId"].toInt(),
    loginId: json["loginId"] == null ? null : json["loginId"],
    password: json["password"] == null ? null : json["password"],
    fullName: json["fullName"] == null ? null : json["fullName"],
    description: json["description"],
    regDate: DateTime.parse(json["regDate"]),
    updateDate: json["updateDate"],
    userStatus: json["userStatus"] == null ? null : json["userStatus"],
    lastLoginDate: json["lastLoginDate"],
    lastLoginIp: json["lastLoginIp"],
    userType: json["userType"] == null ? null : json["userType"],
    employeeId: json["employeeId"],
    email: json["email"] == null ? null : json["email"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "loginId": loginId == null ? null : loginId,
    "password": password == null ? null : password,
    "fullName": fullName == null ? null : fullName,
    "description": description,
    "regDate": regDate.toIso8601String(),
    "updateDate": updateDate,
    "userStatus": userStatus == null ? null : userStatus,
    "lastLoginDate": lastLoginDate,
    "lastLoginIp": lastLoginIp,
    "userType": userType == null ? null : userType,
    "employeeId": employeeId,
    "email": email == null ? null : email,
  };
}
