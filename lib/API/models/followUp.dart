// To parse this JSON data, do
//
//     final followUp = followUpFromJson(jsonString);

import 'dart:convert';

FollowUp followUpFromJson(String str) => FollowUp.fromJson(json.decode(str));

String followUpToJson(FollowUp data) => json.encode(data.toJson());

class FollowUp {
  FollowUp({
    this.status,
    this.message,
    this.payload,
  });

  bool status;
  List<String> message;
  List<Payload> payload;

  factory FollowUp.fromJson(Map<String, dynamic> json) => FollowUp(
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
    this.followUpId,
    this.startDateTime,
    this.flwNote,
    this.logReportId,
    this.flwUpByUserId,
    this.flwUpStatus,
    this.endDateTime,
    this.chkByUserId,
    this.submitByUserId,
  });

  int followUpId;
  DateTime startDateTime;
  String flwNote;
  int logReportId;
  int flwUpByUserId;
  int flwUpStatus;
  DateTime endDateTime;
  int chkByUserId;
  int submitByUserId;

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
    followUpId: json["followUpId"],
    startDateTime: DateTime.parse(json["startDateTime"]),
    flwNote: json["flwNote"],
    logReportId: json["logReportId"],
    flwUpByUserId: json["flwUpByUserId"],
    flwUpStatus: json["flwUpStatus"],
    endDateTime: DateTime.parse(json["endDateTime"]),
    chkByUserId: json["chkByUserId"],
    submitByUserId: json["submitByUserId"],
  );

  Map<String, dynamic> toJson() => {
    "followUpId": followUpId,
    "startDateTime": "${startDateTime.year.toString().padLeft(4, '0')}-${startDateTime.month.toString().padLeft(2, '0')}-${startDateTime.day.toString().padLeft(2, '0')}",
    "flwNote": flwNote,
    "logReportId": logReportId,
    "flwUpByUserId": flwUpByUserId,
    "flwUpStatus": flwUpStatus,
    "endDateTime": "${endDateTime.year.toString().padLeft(4, '0')}-${endDateTime.month.toString().padLeft(2, '0')}-${endDateTime.day.toString().padLeft(2, '0')}",
    "chkByUserId": chkByUserId,
    "submitByUserId": submitByUserId,
  };
}
