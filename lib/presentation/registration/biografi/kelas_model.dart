import 'dart:convert';

class KelasModel {
  int idKelas;
  String nama;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic sekolah;

  KelasModel({
    required this.idKelas,
    required this.nama,
    this.createdAt,
    this.updatedAt,
    this.sekolah,
  });

  factory KelasModel.fromJson(Map<String, dynamic> json) => KelasModel(
    idKelas: json["id_kelas"],
    nama: json["nama"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    sekolah: json["sekolah"],
  );

  Map<String, dynamic> toJson() => {
    "id_kelas": idKelas,
    "nama": nama,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "sekolah": sekolah,
  };
}
