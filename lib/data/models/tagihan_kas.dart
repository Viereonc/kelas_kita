// To parse this JSON data, do
//
//     final infoTagihanKasModel = infoTagihanKasModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<InfoTagihanKasModel> infoTagihanKasModelFromJson(String str) => List<InfoTagihanKasModel>.from(json.decode(str).map((x) => InfoTagihanKasModel.fromJson(x)));

String infoTagihanKasModelToJson(List<InfoTagihanKasModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class InfoTagihanKasModel {
  Biodata biodata;
  int totalKas;
  List<Jumlah> jumlah;

  InfoTagihanKasModel({
    required this.biodata,
    required this.totalKas,
    required this.jumlah,
  });

  factory InfoTagihanKasModel.fromJson(Map<String, dynamic> json) => InfoTagihanKasModel(
    biodata: Biodata.fromJson(json["biodata"]),
    totalKas: json["totalKas"],
    jumlah: List<Jumlah>.from(json["jumlah"].map((x) => Jumlah.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "biodata": biodata.toJson(),
    "totalKas": totalKas,
    "jumlah": List<dynamic>.from(jumlah.map((x) => x.toJson())),
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
  String bio;
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
    idBiodata: json["id_biodata"] is int ? json["id_biodata"] : int.parse(json["id_biodata"]),
    idUser: json["id_user"] is int ? json["id_user"] : int.parse(json["id_user"]),
    idKelas: json["id_kelas"] is int ? json["id_kelas"] : int.parse(json["id_kelas"]),
    idRole: json["id_role"] is int ? json["id_role"] : int.parse(json["id_role"]),
    nama: json["nama"],
    nis: json["nis"] is int ? json["nis"] : int.parse(json["nis"]),
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

class Jumlah {
  String nominal;
  DateTime tanggal;

  Jumlah({
    required this.nominal,
    required this.tanggal,
  });

  factory Jumlah.fromJson(Map<String, dynamic> json) => Jumlah(
    nominal: json["nominal"],
    tanggal: DateTime.parse(json["tanggal"]),
  );

  Map<String, dynamic> toJson() => {
    "nominal": nominal,
    "tanggal": "${tanggal.year.toString().padLeft(4, '0')}-${tanggal.month.toString().padLeft(2, '0')}-${tanggal.day.toString().padLeft(2, '0')}",
  };
}
