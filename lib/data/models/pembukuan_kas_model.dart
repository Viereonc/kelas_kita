import 'dart:convert';

List<PembukuanKasModel> pembukuanKasModelFromJson(String str) => List<PembukuanKasModel>.from(json.decode(str).map((x) => PembukuanKasModel.fromJson(x)));

String pembukuanKasModelToJson(List<PembukuanKasModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PembukuanKasModel {
  int id;
  int idKelas;
  String nama;
  String jenis;
  int jumlahPengeluaran;
  DateTime tanggal;
  DateTime createdAt;
  DateTime updatedAt;
  Kelas kelas;

  PembukuanKasModel({
    required this.id,
    required this.idKelas,
    required this.nama,
    required this.jenis,
    required this.jumlahPengeluaran,
    required this.tanggal,
    required this.createdAt,
    required this.updatedAt,
    required this.kelas,
  });

  factory PembukuanKasModel.fromJson(Map<String, dynamic> json) => PembukuanKasModel(
    id: json["id"],
    idKelas: json["id_kelas"],
    nama: json["nama"],
    jenis: json["jenis"],
    jumlahPengeluaran: json["jumlah_pengeluaran"],
    tanggal: DateTime.parse(json["tanggal"]),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    kelas: Kelas.fromJson(json["kelas"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "id_kelas": idKelas,
    "nama": nama,
    "jenis": jenis,
    "jumlah_pengeluaran": jumlahPengeluaran,
    "tanggal": "${tanggal.year.toString().padLeft(4, '0')}-${tanggal.month.toString().padLeft(2, '0')}-${tanggal.day.toString().padLeft(2, '0')}",
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "kelas": kelas.toJson(),
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
