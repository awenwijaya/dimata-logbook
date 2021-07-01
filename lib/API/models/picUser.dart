// To parse this JSON data, do
//
//     final picUser = picUserFromJson(jsonString);

import 'dart:convert';

PicUser picUserFromJson(String str) => PicUser.fromJson(json.decode(str));

String picUserToJson(PicUser data) => json.encode(data.toJson());

class PicUser {
  PicUser({
    this.status,
    this.message,
    this.payload,
  });

  bool status;
  List<String> message;
  List<Payload> payload;

  factory PicUser.fromJson(Map<String, dynamic> json) => PicUser(
    status: json["status"],
    message: List<String>.from(json["message"].map((x) => x)),
    payload: List<Payload>.from(json["payload"].map((x) => Payload.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": List<dynamic>.from(message.map((x) => x)),
    "payload": List<dynamic>.from(payload.map((x) => x.toJson())),
  };
}

class Payload {
  Payload({
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
    this.employeeId,
    this.companyId,
    this.email,
  });

  int userId;
  String loginId;
  String password;
  String fullName;
  String description;
  DateTime regDate;
  DateTime updateDate;
  int userStatus;
  DateTime lastLoginDate;
  String lastLoginIp;
  int employeeId;
  int companyId;
  String email;

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
    userId: json["userId"],
    loginId: json["loginId"],
    password: json["password"],
    fullName: json["fullName"],
    description: json["description"] == null ? null : json["description"],
    regDate: DateTime.parse(json["regDate"]),
    updateDate: json["updateDate"] == null ? null : DateTime.parse(json["updateDate"]),
    userStatus: json["userStatus"],
    lastLoginDate: json["lastLoginDate"] == null ? null : DateTime.parse(json["lastLoginDate"]),
    lastLoginIp: json["lastLoginIp"] == null ? null : json["lastLoginIp"],
    employeeId: json["employeeId"],
    companyId: json["companyId"] == null ? null : json["companyId"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "loginId": loginId,
    "password": password,
    "fullName": fullName,
    "description": description == null ? null : description,
    "regDate": regDate.toIso8601String(),
    "updateDate": updateDate == null ? null : updateDate.toIso8601String(),
    "userStatus": userStatus,
    "lastLoginDate": lastLoginDate == null ? null : lastLoginDate.toIso8601String(),
    "lastLoginIp": lastLoginIp == null ? null : lastLoginIp,
    "employeeId": employeeId,
    "companyId": companyId == null ? null : companyId,
    "email": email,
  };
}
