// To parse this JSON data, do
//
//     final strukturKelasAllModel = strukturKelasAllModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Map<String, List<StrukturKelasAllModel>> strukturKelasAllModelFromJson(String str) => Map.from(json.decode(str)).map((k, v) => MapEntry<String, List<StrukturKelasAllModel>>(k, List<StrukturKelasAllModel>.from(v.map((x) => StrukturKelasAllModel.fromJson(x)))));

String strukturKelasAllModelToJson(Map<String, List<StrukturKelasAllModel>> data) => json.encode(Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, List<dynamic>.from(v.map((x) => x.toJson())))));

class StrukturKelasAllModel {
  int idBiodata;
  int idUser;
  int idKelas;
  String nama;
  int nis;
  String alamat;
  String? image;
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
    this.image,
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
    nama: json["nama"].toString(),
    nis: json["nis"],
    alamat: json["alamat"],
    image: json["image"],
    bio: json["bio"],
    status: statusValues.map[json["status"]]!,
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    roleName: roleNameValues.map[json["role_name"]]!,
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
    "image": image,
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
