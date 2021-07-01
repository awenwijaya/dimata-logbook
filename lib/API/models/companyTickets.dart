// To parse this JSON data, do
//
//     final companyTickets = companyTicketsFromJson(jsonString);

import 'dart:convert';

CompanyTickets companyTicketsFromJson(String str) => CompanyTickets.fromJson(json.decode(str));

String companyTicketsToJson(CompanyTickets data) => json.encode(data.toJson());

class CompanyTickets {
  CompanyTickets({
    this.status,
    this.message,
    this.payload,
  });

  bool status;
  List<String> message;
  List<Payload> payload;

  factory CompanyTickets.fromJson(Map<String, dynamic> json) => CompanyTickets(
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
  dynamic dueDatetime;
  DateTime realFinishDatetime;
  int customerId;
  int priority;
  dynamic statusRpt;
  int companyId;

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
    logReportId: json["logReportId"],
    logNumber: json["logNumber"],
    logDesc: json["logDesc"],
    reportDate: DateTime.parse(json["reportDate"]),
    recordDate: DateTime.parse(json["recordDate"]),
    status: json["status"],
    rptTypeId: json["rptTypeId"],
    rptCategoryId: json["rptCategoryId"],
    pasalUmumId: json["pasalUmumId"],
    pasalKhususId: json["pasalKhususId"],
    reportByUserId: json["reportByUserId"],
    recordByUserId: json["recordByUserId"],
    picUserId: json["picUserId"],
    logLocationId: json["logLocationId"],
    dueDatetime: json["dueDatetime"],
    realFinishDatetime: json["realFinishDatetime"] == null ? null : DateTime.parse(json["realFinishDatetime"]),
    customerId: json["customerId"],
    priority: json["priority"],
    statusRpt: json["statusRpt"],
    companyId: json["companyId"],
  );

  Map<String, dynamic> toJson() => {
    "logReportId": logReportId,
    "logNumber": logNumber,
    "logDesc": logDesc,
    "reportDate": reportDate.toIso8601String(),
    "recordDate": recordDate.toIso8601String(),
    "status": status,
    "rptTypeId": rptTypeId,
    "rptCategoryId": rptCategoryId,
    "pasalUmumId": pasalUmumId,
    "pasalKhususId": pasalKhususId,
    "reportByUserId": reportByUserId,
    "recordByUserId": recordByUserId,
    "picUserId": picUserId,
    "logLocationId": logLocationId,
    "dueDatetime": dueDatetime,
    "realFinishDatetime": realFinishDatetime == null ? null : realFinishDatetime.toIso8601String(),
    "customerId": customerId,
    "priority": priority,
    "statusRpt": statusRpt,
    "companyId": companyId,
  };
}
