// To parse this JSON data, do
//
//     final infoBiografiModel = infoBiografiModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

InfoBiografiModel infoBiografiModelFromJson(String str) => InfoBiografiModel.fromJson(json.decode(str));

String infoBiografiModelToJson(InfoBiografiModel data) => json.encode(data.toJson());

class InfoBiografiModel {
  int idBiodata;
  int idUser;
  int idKelas;
  String nama;
  int nis;
  String alamat;
  dynamic bio;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  String roleName;
  User user;
  Kelas kelas;
  Role role;

  InfoBiografiModel({
    required this.idBiodata,
    required this.idUser,
    required this.idKelas,
    required this.nama,
    required this.nis,
    required this.alamat,
    required this.bio,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.roleName,
    required this.user,
    required this.kelas,
    required this.role,
  });

  factory InfoBiografiModel.fromJson(Map<String, dynamic> json) => InfoBiografiModel(
    idBiodata: json["id_biodata"],
    idUser: json["id_user"],
    idKelas: json["id_kelas"],
    nama: json["nama"],
    nis: json["nis"],
    alamat: json["alamat"],
    bio: json["bio"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    roleName: json["role_name"],
    user: User.fromJson(json["user"]),
    kelas: Kelas.fromJson(json["kelas"]),
    role: Role.fromJson(json["role"]),
  );

  Map<String, dynamic> toJson() => {
    "id_biodata": idBiodata,
    "id_user": idUser,
    "id_kelas": idKelas,
    "nama": nama,
    "nis": nis,
    "alamat": alamat,
    "bio": bio,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "role_name": roleName,
    "user": user.toJson(),
    "kelas": kelas.toJson(),
    "role": role.toJson(),
  };
}

class Kelas {
  int idKelas;
  String nama;
  dynamic createdAt;
  dynamic updatedAt;

  Kelas({
    required this.idKelas,
    required this.nama,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Kelas.fromJson(Map<String, dynamic> json) => Kelas(
    idKelas: json["id_kelas"],
    nama: json["nama"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id_kelas": idKelas,
    "nama": nama,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

class Role {
  int idRole;
  String nama;
  String code;
  dynamic createdAt;
  dynamic updatedAt;

  Role({
    required this.idRole,
    required this.nama,
    required this.code,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
    idRole: json["id_role"],
    nama: json["nama"],
    code: json["code"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id_role": idRole,
    "nama": nama,
    "code": code,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

class User {
  int idUser;
  String username;
  String email;
  int nomor;
  DateTime createdAt;
  DateTime updatedAt;

  User({
    required this.idUser,
    required this.username,
    required this.email,
    required this.nomor,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    idUser: json["id_user"],
    username: json["username"],
    email: json["email"],
    nomor: json["nomor"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id_user": idUser,
    "username": username,
    "email": email,
    "nomor": nomor,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
