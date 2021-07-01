// To parse this JSON data, do
//
//     final kategoriTiket = kategoriTiketFromJson(jsonString);

import 'dart:convert';

List<KategoriTiket> kategoriTiketFromJson(String str) => List<KategoriTiket>.from(json.decode(str).map((x) => KategoriTiket.fromJson(x)));

String kategoriTiketToJson(List<KategoriTiket> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class KategoriTiket {
  KategoriTiket({
    this.rptTypeId,
    this.typeName,
    this.statusRpt,
  });

  double rptTypeId;
  String typeName;
  String statusRpt;

  factory KategoriTiket.fromJson(Map<String, dynamic> json) => KategoriTiket(
    rptTypeId: json["rptTypeId"].toDouble(),
    typeName: json["typeName"],
    statusRpt: json["statusRpt"] == null ? null : json["statusRpt"],
  );

  Map<String, dynamic> toJson() => {
    "rptTypeId": rptTypeId,
    "typeName": typeName,
    "statusRpt": statusRpt == null ? null : statusRpt,
  };
}
