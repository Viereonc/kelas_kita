import 'dart:convert';

List<JadwalPiketModel> jadwalPiketModelFromJson(String str) => List<JadwalPiketModel>.from(json.decode(str).map((x) => JadwalPiketModel.fromJson(x)));

String jadwalPiketModelToJson(List<JadwalPiketModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JadwalPiketModel {
  int idPiket;
  int idKelas;
  int idUser;
  String nama;
  String hari;
  String kelas;
  dynamic createdAt;
  dynamic updatedAt;

  JadwalPiketModel({
    required this.idPiket,
    required this.idKelas,
    required this.idUser,
    required this.nama,
    required this.hari,
    required this.kelas,
    required this.createdAt,
    required this.updatedAt,
  });

  factory JadwalPiketModel.fromJson(Map<String, dynamic> json) => JadwalPiketModel(
    idPiket: json["id_piket"],
    idKelas: json["id_kelas"],
    idUser: json["id_user"],
    nama: json["nama"],
    hari: json["hari"],
    kelas: json["kelas"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id_piket": idPiket,
    "id_kelas": idKelas,
    "id_user": idUser,
    "nama": nama,
    "hari": hari,
    "kelas": kelas,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
