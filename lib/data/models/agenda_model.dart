// To parse this JSON data, do
//
//     final infoAgendaModel = infoAgendaModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<InfoAgendaModel> infoAgendaModelFromJson(String str) => List<InfoAgendaModel>.from(json.decode(str).map((x) => InfoAgendaModel.fromJson(x)));

String infoAgendaModelToJson(List<InfoAgendaModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class InfoAgendaModel {
  int idNote;
  int idUser;
  String judul;
  String isi;
  DateTime createdAt;
  DateTime updatedAt;

  InfoAgendaModel({
    required this.idNote,
    required this.idUser,
    required this.judul,
    required this.isi,
    required this.createdAt,
    required this.updatedAt,
  });

  factory InfoAgendaModel.fromJson(Map<String, dynamic> json) => InfoAgendaModel(
    idNote: json["id_note"],
    idUser: json["id_user"],
    judul: json["judul"],
    isi: json["isi"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id_note": idNote,
    "id_user": idUser,
    "judul": judul,
    "isi": isi,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
