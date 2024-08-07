// To parse this JSON data, do
//
//     final infoBiografiModel = infoBiografiModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<InfoBiografiModel> infoBiografiModelFromJson(String str) => List<InfoBiografiModel>.from(json.decode(str).map((x) => InfoBiografiModel.fromJson(x)));

String infoBiografiModelToJson(List<InfoBiografiModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class InfoBiografiModel {
  int idBiodata;
  int idUser;
  int idKelas;
  String nama;
  int nis;
  String alamat;
  String image;
  String? bio;
  Status status;
  DateTime createdAt;
  DateTime updatedAt;
  RoleName roleName;
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
    required this.image,
    this.bio,
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
    nama: json["nama"],
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
  WAL,
  SEK,
  KET,
  WAK,
  GUR
}

final codeValues = EnumValues({
  "ANG": Code.ANG,
  "BEN": Code.BEN,
  "WAL": Code.WAL,
  "SEK": Code.SEK,
  "KET": Code.KET,
  "WAK": Code.WAK,
  "GUR": Code.GUR,
});

enum RoleName {
  ANGGOTA,
  BENDAHARA,
  WALI_KELAS,
  SEKRETARIS,
  KETUA_KELAS,
  WAKIL_KETUA_KELAS,
  GURU,
}

final roleNameValues = EnumValues({
  "Anggota": RoleName.ANGGOTA,
  "Bendahara": RoleName.BENDAHARA,
  "Wali Kelas": RoleName.WALI_KELAS,
  "Sekretaris": RoleName.SEKRETARIS,
  "Ketua Kelas": RoleName.KETUA_KELAS,
  "Wakil Ketua Kelas": RoleName.WAKIL_KETUA_KELAS,
  "Guru": RoleName.GURU
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
  dynamic? fcmToken;
  DateTime createdAt;
  DateTime updatedAt;

  User({
    required this.idUser,
    required this.username,
    required this.email,
    required this.nomor,
    this.fcmToken,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    idUser: json["id_user"],
    username: json["username"],
    email: json["email"],
    nomor: json["nomor"],
    fcmToken: json["fcm_token"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id_user": idUser,
    "username": username,
    "email": email,
    "nomor": nomor,
    "fcm_token": fcmToken,
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
