// To parse this JSON data, do
//
//     final chapter = chapterFromJson(jsonString);

import 'dart:convert';

List<Chapter> chapterFromJson(String str) => List<Chapter>.from(json.decode(str).map((x) => Chapter.fromJson(x)));

String chapterToJson(List<Chapter> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Chapter {
  Chapter({
    this.pasalUmumId,
    this.pasalUmum,
  });

  double pasalUmumId;
  String pasalUmum;

  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
    pasalUmumId: json["pasalUmumId"].toDouble(),
    pasalUmum: json["pasalUmum"],
  );

  Map<String, dynamic> toJson() => {
    "pasalUmumId": pasalUmumId,
    "pasalUmum": pasalUmum,
  };
}
