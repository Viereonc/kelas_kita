// To parse this JSON data, do
//
//     final kelasModel = kelasModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<KelasModel> kelasModelFromJson(String str) => List<KelasModel>.from(json.decode(str).map((x) => KelasModel.fromJson(x)));

String kelasModelToJson(List<KelasModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class KelasModel {
  int idKelas;
  dynamic idBiodata;
  String nama;
  dynamic jumlahKas;
  dynamic createdAt;
  dynamic updatedAt;

  KelasModel({
    required this.idKelas,
    required this.idBiodata,
    required this.nama,
    required this.jumlahKas,
    required this.createdAt,
    required this.updatedAt,
  });

  factory KelasModel.fromJson(Map<String, dynamic> json) => KelasModel(
    idKelas: json["id_kelas"],
    idBiodata: json["id_biodata"],
    nama: json["nama"],
    jumlahKas: json["jumlah_kas"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id_kelas": idKelas,
    "id_biodata": idBiodata,
    "nama": nama,
    "jumlah_kas": jumlahKas,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
