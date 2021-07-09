// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.status,
    this.message,
    this.payload,
  });

  bool status;
  List<String> message;
  List<Payload> payload;

  factory User.fromJson(Map<String, dynamic> json) => User(
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
  dynamic description;
  DateTime regDate;
  dynamic updateDate;
  int userStatus;
  dynamic lastLoginDate;
  dynamic lastLoginIp;
  int employeeId;
  int companyId;
  String email;

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
    userId: json["userId"],
    loginId: json["loginId"],
    password: json["password"],
    fullName: json["fullName"],
    description: json["description"],
    regDate: DateTime.parse(json["regDate"]),
    updateDate: json["updateDate"],
    userStatus: json["userStatus"],
    lastLoginDate: json["lastLoginDate"],
    lastLoginIp: json["lastLoginIp"],
    employeeId: json["employeeId"],
    companyId: json["companyId"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "loginId": loginId,
    "password": password,
    "fullName": fullName,
    "description": description,
    "regDate": regDate.toIso8601String(),
    "updateDate": updateDate,
    "userStatus": userStatus,
    "lastLoginDate": lastLoginDate,
    "lastLoginIp": lastLoginIp,
    "employeeId": employeeId,
    "companyId": companyId,
    "email": email,
  };
}
