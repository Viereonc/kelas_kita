// To parse this JSON data, do
//
//     final infoKasKelasModel = infoKasKelasModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<InfoKasKelasModel> infoKasKelasModelFromJson(String str) => List<InfoKasKelasModel>.from(json.decode(str).map((x) => InfoKasKelasModel.fromJson(x)));

String infoKasKelasModelToJson(List<InfoKasKelasModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class InfoKasKelasModel {
  int idKas;
  int idKelas;
  int idBiodata;
  String nomorRekening;
  int nominal;
  DateTime createdAt;
  DateTime updatedAt;

  InfoKasKelasModel({
    required this.idKas,
    required this.idKelas,
    required this.idBiodata,
    required this.nomorRekening,
    required this.nominal,
    required this.createdAt,
    required this.updatedAt,
  });

  factory InfoKasKelasModel.fromJson(Map<String, dynamic> json) => InfoKasKelasModel(
    idKas: json["id_kas"],
    idKelas: json["id_kelas"],
    idBiodata: json["id_biodata"],
    nomorRekening: json["nomor_rekening"],
    nominal: json["nominal"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id_kas": idKas,
    "id_kelas": idKelas,
    "id_biodata": idBiodata,
    "nomor_rekening": nomorRekening,
    "nominal": nominal,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
