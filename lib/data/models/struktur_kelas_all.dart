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
  String? image;
  String bio;
  String? status;
  DateTime createdAt;
  DateTime updatedAt;
  String? roleName;
  User user;
  Kelas kelas;
  Role role;
  int? absen;

  StrukturKelasAllModel({
    required this.idBiodata,
    required this.idUser,
    required this.idKelas,
    required this.nama,
    required this.nis,
    required this.alamat,
    this.image,
    required this.bio,
    this.status,
    required this.createdAt,
    required this.updatedAt,
    this.roleName,
    required this.user,
    required this.kelas,
    required this.role,
    this.absen,
  });

  factory StrukturKelasAllModel.fromJson(Map<String, dynamic> json) {
    print('id_biodata: ${json["id_biodata"]}');
    print('id_user: ${json["id_user"]}');
    print('id_kelas: ${json["id_kelas"]}');
    print('nama: ${json["nama"]}');
    print('nis: ${json["nis"]}');
    print('alamat: ${json["alamat"]}');
    print('image: ${json["image"]}');
    print('bio: ${json["bio"]}');
    print('status: ${json["status"]}');
    print('created_at: ${json["created_at"]}');
    print('updated_at: ${json["updated_at"]}');
    print('role_name: ${json["role_name"]}');
    print('user: ${json["user"]}');
    print('kelas: ${json["kelas"]}');
    print('role: ${json["role"]}');

    return StrukturKelasAllModel(
      idBiodata: json["id_biodata"] ?? 0,
      idUser: json["id_user"] ?? 0,
      idKelas: json["id_kelas"] ?? 0,
      nama: json["nama"] ?? '',
      nis: json["nis"] ?? 0,
      alamat: json["alamat"] ?? '',
      image: json["image"],
      bio: json["bio"] ?? '',
      status: json["status"],
      createdAt: DateTime.parse(json["created_at"] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json["updated_at"] ?? DateTime.now().toIso8601String()),
      roleName: json["role_name"],
      user: User.fromJson(json["user"]),
      kelas: Kelas.fromJson(json["kelas"]),
      role: Role.fromJson(json["role"]),
      absen: json["absen"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id_biodata": idBiodata,
    "id_user": idUser,
    "id_kelas": idKelas,
    "nama": nama,
    "nis": nis,
    "alamat": alamat,
    "image": image,
    "bio": bio,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "role_name": roleName,
    "user": user.toJson(),
    "kelas": kelas.toJson(),
    "role": role.toJson(),
    "absen": absen,
  };
}

class User {
  int idUser;
  String username;
  String email;
  int nomor;
  String? fcmToken;
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

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      idUser: json["id_user"] ?? 0,
      username: json["username"] ?? '',
      email: json["email"] ?? '',
      nomor: json["nomor"] ?? 0,
      fcmToken: json["fcm_token"],
      createdAt: DateTime.parse(json["created_at"] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json["updated_at"] ?? DateTime.now().toIso8601String()),
    );
  }

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

class Kelas {
  int idKelas;
  String nama;
  DateTime? createdAt;
  DateTime? updatedAt;

  Kelas({
    required this.idKelas,
    required this.nama,
    this.createdAt,
    this.updatedAt,
  });

  factory Kelas.fromJson(Map<String, dynamic> json) {
    return Kelas(
      idKelas: json["id_kelas"] ?? 0,
      nama: json["nama"] ?? '',
      createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"]) : null,
      updatedAt: json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    "id_kelas": idKelas,
    "nama": nama,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
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

class Role {
  int idRole;
  String nama;
  String code;
  DateTime? createdAt;
  DateTime? updatedAt;

  Role({
    required this.idRole,
    required this.nama,
    required this.code,
    this.createdAt,
    this.updatedAt,
  });

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      idRole: json["id_role"] ?? 0,
      nama: json["nama"] ?? '',
      code: json["code"] ?? '',
      createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"]) : null,
      updatedAt: json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    "id_role": idRole,
    "nama": nama,
    "code": code,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
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
