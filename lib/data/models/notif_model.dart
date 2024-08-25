// To parse this JSON data, do
//
//     final infoNotifModel = infoNotifModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<InfoNotifModel> infoNotifModelFromJson(String str) => List<InfoNotifModel>.from(json.decode(str).map((x) => InfoNotifModel.fromJson(x)));

String infoNotifModelToJson(List<InfoNotifModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class InfoNotifModel {
  int id;
  int idBiodata;
  String title;
  String message;
  String type;
  DateTime createdAt;
  DateTime updatedAt;

  InfoNotifModel({
    required this.id,
    required this.idBiodata,
    required this.title,
    required this.message,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
  });

  factory InfoNotifModel.fromJson(Map<String, dynamic> json) => InfoNotifModel(
    id: json["id"],
    idBiodata: json["id_biodata"],
    title: json["title"],
    message: json["message"],
    type: json["type"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "id_biodata": idBiodata,
    "title": title,
    "message": message,
    "type": type,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
