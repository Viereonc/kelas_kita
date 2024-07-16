import 'dart:convert';

List<JadwalKelasModel> jadwalKelasModelFromJson(String str) => List<JadwalKelasModel>.from(json.decode(str).map((x) => JadwalKelasModel.fromJson(x)));

String jadwalKelasModelToJson(List<JadwalKelasModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JadwalKelasModel {
  String namaPelajaran;
  String hari;
  String jamMulai;
  String jamSelesai;
  dynamic kelas;
  String guru;
  List<dynamic> absensi;

  JadwalKelasModel({
    required this.namaPelajaran,
    required this.hari,
    required this.jamMulai,
    required this.jamSelesai,
    required this.kelas,
    required this.guru,
    required this.absensi,
  });

  factory JadwalKelasModel.fromJson(Map<String, dynamic> json) => JadwalKelasModel(
    namaPelajaran: json["nama_pelajaran"],
    hari: json["hari"],
    jamMulai: json["jam_mulai"],
    jamSelesai: json["jam_selesai"],
    kelas: json["kelas"],
    guru: json["guru"],
    absensi: List<dynamic>.from(json["absensi"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "nama_pelajaran": namaPelajaran,
    "hari": hari,
    "jam_mulai": jamMulai,
    "jam_selesai": jamSelesai,
    "kelas": kelas,
    "guru": guru,
    "absensi": List<dynamic>.from(absensi.map((x) => x)),
  };
}
