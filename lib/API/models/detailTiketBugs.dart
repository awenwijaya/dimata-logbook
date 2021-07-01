// To parse this JSON data, do
//
//     final tiketDetail = tiketDetailFromJson(jsonString);

import 'dart:convert';

List<TiketDetail> tiketDetailFromJson(String str) => List<TiketDetail>.from(json.decode(str).map((x) => TiketDetail.fromJson(x)));

String tiketDetailToJson(List<TiketDetail> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TiketDetail {
  TiketDetail({
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
  });

  double logReportId;
  int logNumber;
  String logDesc;
  DateTime reportDate;
  DateTime recordDate;
  int status;
  double rptTypeId;
  double rptCategoryId;
  int pasalUmumId;
  int pasalKhususId;
  double reportByUserId;
  int recordByUserId;
  double picUserId;
  double logLocationId;
  DateTime dueDatetime;
  dynamic realFinishDatetime;
  double customerId;
  int priority;
  String statusRpt;

  factory TiketDetail.fromJson(Map<String, dynamic> json) => TiketDetail(
    logReportId: json["logReportId"].toDouble(),
    logNumber: json["logNumber"],
    logDesc: json["logDesc"],
    reportDate: DateTime.parse(json["reportDate"]),
    recordDate: DateTime.parse(json["recordDate"]),
    status: json["status"],
    rptTypeId: json["rptTypeId"].toDouble(),
    rptCategoryId: json["rptCategoryId"] == null ? null : json["rptCategoryId"].toDouble(),
    pasalUmumId: json["pasalUmumId"],
    pasalKhususId: json["pasalKhususId"],
    reportByUserId: json["reportByUserId"].toDouble(),
    recordByUserId: json["recordByUserId"],
    picUserId: json["picUserId"].toDouble(),
    logLocationId: json["logLocationId"] == null ? null : json["logLocationId"].toDouble(),
    dueDatetime: json["dueDatetime"] == null ? null : DateTime.parse(json["dueDatetime"]),
    realFinishDatetime: json["realFinishDatetime"],
    customerId: json["customerId"] == null ? null : json["customerId"].toDouble(),
    priority: json["priority"],
    statusRpt: json["statusRpt"],
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
    "pasalUmumId": pasalUmumId,
    "pasalKhususId": pasalKhususId,
    "reportByUserId": reportByUserId,
    "recordByUserId": recordByUserId,
    "picUserId": picUserId,
    "logLocationId": logLocationId == null ? null : logLocationId,
    "dueDatetime": dueDatetime == null ? null : dueDatetime.toIso8601String(),
    "realFinishDatetime": realFinishDatetime,
    "customerId": customerId == null ? null : customerId,
    "priority": priority,
    "statusRpt": statusRpt,
  };
}
//
// enum StatusRpt { BUGS }
//
// final statusRptValues = EnumValues({
//   "bugs": StatusRpt.BUGS
// });
//
// class EnumValues<T> {
//   Map<String, T> map;
//   Map<T, String> reverseMap;
//
//   EnumValues(this.map);
//
//   Map<T, String> get reverse {
//     if (reverseMap == null) {
//       reverseMap = map.map((k, v) => new MapEntry(v, k));
//     }
//     return reverseMap;
//   }
// }