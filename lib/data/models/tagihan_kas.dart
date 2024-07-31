// To parse this JSON data, do
//
//     final infoTagihanKasModel = infoTagihanKasModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<InfoTagihanKasModel> infoTagihanKasModelFromJson(String str) => List<InfoTagihanKasModel>.from(json.decode(str).map((x) => InfoTagihanKasModel.fromJson(x)));

String infoTagihanKasModelToJson(List<InfoTagihanKasModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class InfoTagihanKasModel {
  int id;
  int idBiodata;
  int jumlah;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  Biodata biodata;

  InfoTagihanKasModel({
    required this.id,
    required this.idBiodata,
    required this.jumlah,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.biodata,
  });

  factory InfoTagihanKasModel.fromJson(Map<String, dynamic> json) => InfoTagihanKasModel(
    id: json["id"],
    idBiodata: json["id_biodata"],
    jumlah: json["jumlah"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    biodata: Biodata.fromJson(json["biodata"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "id_biodata": idBiodata,
    "jumlah": jumlah,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "biodata": biodata.toJson(),
  };
}

class Biodata {
  int idBiodata;
  int idUser;
  int idKelas;
  int idRole;
  String nama;
  int nis;
  String alamat;
  String image;
  dynamic bio;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  Biodata({
    required this.idBiodata,
    required this.idUser,
    required this.idKelas,
    required this.idRole,
    required this.nama,
    required this.nis,
    required this.alamat,
    required this.image,
    required this.bio,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Biodata.fromJson(Map<String, dynamic> json) => Biodata(
    idBiodata: json["id_biodata"],
    idUser: json["id_user"],
    idKelas: json["id_kelas"],
    idRole: json["id_role"],
    nama: json["nama"],
    nis: json["nis"],
    alamat: json["alamat"],
    image: json["image"],
    bio: json["bio"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id_biodata": idBiodata,
    "id_user": idUser,
    "id_kelas": idKelas,
    "id_role": idRole,
    "nama": nama,
    "nis": nis,
    "alamat": alamat,
    "image": image,
    "bio": bio,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
