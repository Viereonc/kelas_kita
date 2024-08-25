// To parse this JSON data, do
//
//     final infoStrukturKelasModel = infoStrukturKelasModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<InfoStrukturKelasModel> infoStrukturKelasModelFromJson(String str) => List<InfoStrukturKelasModel>.from(json.decode(str).map((x) => InfoStrukturKelasModel.fromJson(x)));

String infoStrukturKelasModelToJson(List<InfoStrukturKelasModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class InfoStrukturKelasModel {
  int idBiodata;
  int idUser;
  int idKelas;
  String nama;
  int nis;
  String? alamat;
  String? image;
  String? bio;
  String? status;
  DateTime createdAt;
  DateTime updatedAt;
  String? roleName;
  User user;
  Kelas kelas;
  Role role;
  List<PerformaSiswa> performaSiswas;
  int? absen;

  InfoStrukturKelasModel({
    required this.idBiodata,
    required this.idUser,
    required this.idKelas,
    required this.nama,
    required this.nis,
    this.alamat,
    this.image,
    this.bio,
    this.status,
    required this.createdAt,
    required this.updatedAt,
    this.roleName,
    required this.user,
    required this.kelas,
    required this.role,
    required this.performaSiswas,
    this.absen
  });

  factory InfoStrukturKelasModel.fromJson(Map<String, dynamic> json) => InfoStrukturKelasModel(
    idBiodata: json["id_biodata"],
    idUser: json["id_user"],
    idKelas: json["id_kelas"],
    nama: json["nama"],
    nis: json["nis"],
    alamat: json["alamat"] ?? '',
    image: json["image"] ?? '',
    bio: json["bio"] ?? '',
    status: json["status"] ?? '',
    createdAt: DateTime.parse(json["created_at"] ?? DateTime.now().toIso8601String()),
    updatedAt: DateTime.parse(json["updated_at"] ?? DateTime.now().toIso8601String()),
    roleName: json["role_name"] ?? '',
    user: User.fromJson(json["user"]),
    kelas: Kelas.fromJson(json["kelas"]),
    role: Role.fromJson(json["role"]),
    performaSiswas: List<PerformaSiswa>.from(json["performa_siswas"].map((x) => PerformaSiswa.fromJson(x))),
    absen: json["absen"],
  );

  Map<String, dynamic> toJson() => {
    "id_biodata": idBiodata,
    "id_user": idUser,
    "id_kelas": idKelas,
    "nama": nama,
    "nis": nis,
    "alamat": alamat ?? '',
    "image": image ?? '',
    "bio": bio ?? '',
    "status": status ?? '',
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "role_name": roleName ?? '',
    "user": user.toJson(),
    "kelas": kelas.toJson(),
    "role": role.toJson(),
    "performa_siswas": List<dynamic>.from(performaSiswas.map((x) => x.toJson())),
    "absen": absen,
  };
}

class Kelas {
  int idKelas;
  dynamic idBiodata;
  String nama;
  dynamic jumlahKas;
  dynamic createdAt;
  dynamic updatedAt;

  Kelas({
    required this.idKelas,
    required this.idBiodata,
    required this.nama,
    required this.jumlahKas,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Kelas.fromJson(Map<String, dynamic> json) => Kelas(
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

class PerformaSiswa {
  int id;
  int idBiodata;
  int absensi;
  int pembayaranKas;
  int jumlahIzin;
  DateTime createdAt;
  DateTime updatedAt;

  PerformaSiswa({
    required this.id,
    required this.idBiodata,
    required this.absensi,
    required this.pembayaranKas,
    required this.jumlahIzin,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PerformaSiswa.fromJson(Map<String, dynamic> json) => PerformaSiswa(
    id: json["id"],
    idBiodata: json["id_biodata"],
    absensi: json["absensi"],
    pembayaranKas: json["pembayaran_kas"],
    jumlahIzin: json["jumlah_izin"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "id_biodata": idBiodata,
    "absensi": absensi,
    "pembayaran_kas": pembayaranKas,
    "jumlah_izin": jumlahIzin,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
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
  int? nomor;
  String? idGoogle;
  String? fcmToken;
  DateTime createdAt;
  DateTime updatedAt;

  User({
    required this.idUser,
    required this.username,
    required this.email,
    this.nomor,
    this.idGoogle,
    this.fcmToken,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    idUser: json["id_user"],
    username: json["username"],
    email: json["email"],
    nomor: json["nomor"] ?? 0,
    idGoogle: json["id_google"] ?? '',
    fcmToken: json["fcm_token"] ?? '',
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id_user": idUser,
    "username": username,
    "email": email,
    "nomor": nomor,
    "id_google": idGoogle,
    "fcm_token": fcmToken,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
