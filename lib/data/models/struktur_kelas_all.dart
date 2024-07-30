// To parse this JSON data, do
//
//     final strukturKelasAllModel = strukturKelasAllModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<StrukturKelasAllModel> strukturKelasAllModelFromJson(String str) => List<StrukturKelasAllModel>.from(json.decode(str).map((x) => StrukturKelasAllModel.fromJson(x)));

String strukturKelasAllModelToJson(List<StrukturKelasAllModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StrukturKelasAllModel {
  int idBiodata;
  int idUser;
  int idKelas;
  String nama;
  int nis;
  String alamat;
  dynamic bio;
  Status status;
  DateTime createdAt;
  DateTime updatedAt;
  RoleName roleName;
  User user;
  Kelas kelas;
  Role role;
  int? absen; // New property

  StrukturKelasAllModel({
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
    this.absen,
  });

  factory StrukturKelasAllModel.fromJson(Map<String, dynamic> json) => StrukturKelasAllModel(
    idBiodata: json["id_biodata"],
    idUser: json["id_user"],
    idKelas: json["id_kelas"],
    nama: json["nama"],
    nis: json["nis"],
    alamat: json["alamat"],
    bio: json["bio"],
    status: statusValues.map[json["status"]]!,
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    roleName: roleNameValues.map[json["role_name"]]!,
    user: User.fromJson(json["user"]),
    kelas: Kelas.fromJson(json["kelas"]),
    role: Role.fromJson(json["role"]),
    absen: json["absen"],
  );

  Map<String, dynamic> toJson() => {
    "id_biodata": idBiodata,
    "id_user": idUser,
    "id_kelas": idKelas,
    "nama": nama,
    "nis": nis,
    "alamat": alamat,
    "bio": bio,
    "status": statusValues.reverse[status],
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "role_name": roleNameValues.reverse[roleName],
    "user": user.toJson(),
    "kelas": kelas.toJson(),
    "role": role.toJson(),
    "absen": absen,
  };
}

class Kelas {
  int idKelas;
  Nama nama;
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
    nama: namaValues.map[json["nama"]]!,
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id_kelas": idKelas,
    "nama": namaValues.reverse[nama],
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

enum Nama {
  THE_11_PPLG_1,
  THE_11_PPLG_2
}

final namaValues = EnumValues({
  "11 PPLG 1": Nama.THE_11_PPLG_1,
  "11 PPLG 2": Nama.THE_11_PPLG_2
});

class Role {
  int idRole;
  RoleName nama;
  Code code;
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
    nama: roleNameValues.map[json["nama"]]!,
    code: codeValues.map[json["code"]]!,
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id_role": idRole,
    "nama": roleNameValues.reverse[nama],
    "code": codeValues.reverse[code],
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

enum Code {
  ANG,
  BEN,
  WAL
}

final codeValues = EnumValues({
  "ANG": Code.ANG,
  "BEN": Code.BEN,
  "WAL": Code.WAL
});

enum RoleName {
  ANGGOTA,
  BENDAHARA,
  WALI_KELAS
}

final roleNameValues = EnumValues({
  "Anggota": RoleName.ANGGOTA,
  "Bendahara": RoleName.BENDAHARA,
  "Wali Kelas": RoleName.WALI_KELAS
});

enum Status {
  A
}

final statusValues = EnumValues({
  "A": Status.A
});

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

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
