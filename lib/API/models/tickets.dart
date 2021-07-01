// To parse this JSON data, do
//
//     final tickets = ticketsFromJson(jsonString);

import 'dart:convert';

Tickets ticketsFromJson(String str) => Tickets.fromJson(json.decode(str));

String ticketsToJson(Tickets data) => json.encode(data.toJson());

class Tickets {
  Tickets({
    this.status,
    this.message,
    this.payload,
  });

  bool status;
  List<String> message;
  List<Payload> payload;

  factory Tickets.fromJson(Map<String, dynamic> json) => Tickets(
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
    this.logReportId,
    this.logNumber,
    this.logDesc,
    this.reportDate,
    this.recordDate,
    this.status,
    this.rptTypeId,
    this.rptCategoryId,
    this.pasalUmumId,
    this.pasalKhususId,
    this.reportByUserId,
    this.recordByUserId,
    this.picUserId,
    this.logLocationId,
    this.dueDatetime,
    this.realFinishDatetime,
    this.customerId,
    this.priority,
    this.statusRpt,
    this.companyId,
  });

  int logReportId;
  int logNumber;
  String logDesc;
  DateTime reportDate;
  DateTime recordDate;
  int status;
  int rptTypeId;
  int rptCategoryId;
  int pasalUmumId;
  int pasalKhususId;
  int reportByUserId;
  int recordByUserId;
  int picUserId;
  int logLocationId;
  DateTime dueDatetime;
  dynamic realFinishDatetime;
  int customerId;
  int priority;
  String statusRpt;
  int companyId;

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
    logReportId: json["logReportId"],
    logNumber: json["logNumber"],
    logDesc: json["logDesc"],
    reportDate: DateTime.parse(json["reportDate"]),
    recordDate: DateTime.parse(json["recordDate"]),
    status: json["status"],
    rptTypeId: json["rptTypeId"],
    rptCategoryId: json["rptCategoryId"] == null ? null : json["rptCategoryId"],
    pasalUmumId: json["pasalUmumId"] == null ? null : json["pasalUmumId"],
    pasalKhususId: json["pasalKhususId"],
    reportByUserId: json["reportByUserId"],
    recordByUserId: json["recordByUserId"],
    picUserId: json["picUserId"],
    logLocationId: json["logLocationId"] == null ? null : json["logLocationId"],
    dueDatetime: DateTime.parse(json["dueDatetime"]),
    realFinishDatetime: json["realFinishDatetime"],
    customerId: json["customerId"] == null ? null : json["customerId"],
    priority: json["priority"],
    statusRpt: json["statusRpt"] == null ? null : json["statusRpt"],
    companyId: json["companyId"] == null ? null : json["companyId"],
  );

  Map<String, dynamic> toJson() => {
    "logReportId": logReportId,
    "logNumber": logNumber,
    "logDesc": logDesc,
    "reportDate": reportDate.toIso8601String(),
    "recordDate": recordDate.toIso8601String(),
    "status": status,
    "rptTypeId": rptTypeId,
    "rptCategoryId": rptCategoryId == null ? null : rptCategoryId,
    "pasalUmumId": pasalUmumId == null ? null : pasalUmumId,
    "pasalKhususId": pasalKhususId,
    "reportByUserId": reportByUserId,
    "recordByUserId": recordByUserId,
    "picUserId": picUserId,
    "logLocationId": logLocationId == null ? null : logLocationId,
    "dueDatetime": dueDatetime.toIso8601String(),
    "realFinishDatetime": realFinishDatetime,
    "customerId": customerId == null ? null : customerId,
    "priority": priority,
    "statusRpt": statusRpt == null ? null : statusRpt,
    "companyId": companyId == null ? null : companyId,
  };
}
