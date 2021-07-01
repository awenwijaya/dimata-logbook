// To parse this JSON data, do
//
//     final notifications = notificationsFromJson(jsonString);

import 'dart:convert';

Notifications notificationsFromJson(String str) => Notifications.fromJson(json.decode(str));

String notificationsToJson(Notifications data) => json.encode(data.toJson());

class Notifications {
  Notifications({
    this.status,
    this.message,
    this.payload,
  });

  bool status;
  List<String> message;
  List<Payload> payload;

  factory Notifications.fromJson(Map<String, dynamic> json) => Notifications(
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
    this.notificationId,
    this.reportId,
    this.userId,
    this.date,
    this.logNotification,
    this.statusNotification,
  });

  int notificationId;
  int reportId;
  int userId;
  DateTime date;
  String logNotification;
  int statusNotification;

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
    notificationId: json["notificationId"],
    reportId: json["reportId"],
    userId: json["userId"],
    date: DateTime.parse(json["date"]),
    logNotification: json["logNotification"],
    statusNotification: json["statusNotification"] == null ? null : json["statusNotification"],
  );

  Map<String, dynamic> toJson() => {
    "notificationId": notificationId,
    "reportId": reportId,
    "userId": userId,
    "date": date.toIso8601String(),
    "logNotification": logNotification,
    "statusNotification": statusNotification == null ? null : statusNotification,
  };
}
