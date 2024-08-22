import 'dart:convert';

// Function to parse JSON data
List<JadwalKelasModel> jadwalKelasModelFromJson(String str) =>
    List<JadwalKelasModel>.from(json.decode(str).map((x) => JadwalKelasModel.fromJson(x)));

String jadwalKelasModelToJson(List<JadwalKelasModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JadwalKelasModel {
  int idPelajaran;
  String namaPelajaran;
  String hari;
  String jamMulai;
  String jamSelesai;
  String kelas;
  String guru;
  List<Absensi> absensi;

  JadwalKelasModel({
    required this.idPelajaran,
    required this.namaPelajaran,
    required this.hari,
    required this.jamMulai,
    required this.jamSelesai,
    required this.kelas,
    required this.guru,
    required this.absensi,
  });

  factory JadwalKelasModel.fromJson(Map<String, dynamic> json) => JadwalKelasModel(
    idPelajaran: json["id_pelajaran"],
    namaPelajaran: json["nama_pelajaran"],
    hari: json["hari"],
    jamMulai: json["jam_mulai"],
    jamSelesai: json["jam_selesai"],
    kelas: json["kelas"],
    guru: json["guru"],
    absensi: List<Absensi>.from(json["absensi"].map((x) => Absensi.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id_pelajaran": idPelajaran,
    "nama_pelajaran": namaPelajaran,
    "hari": hari,
    "jam_mulai": jamMulai,
    "jam_selesai": jamSelesai,
    "kelas": kelas,
    "guru": guru,
    "absensi": List<dynamic>.from(absensi.map((x) => x.toJson())),
  };
}

class Absensi {
  String nama;
  int? telat;
  String image;
  String waktuAbsen; 

  Absensi({
    required this.nama,
    this.telat,
    required this.image,
    required this.waktuAbsen, 
  });

  factory Absensi.fromJson(Map<String, dynamic> json) => Absensi(
    nama: json["nama"],
    telat: json["telat"],
    image: json["image"],
    waktuAbsen: json["waktu_absen"],
  );

  Map<String, dynamic> toJson() => {
    "nama": nama,
    "telat": telat,
    "image": image,
    "waktu_absen": waktuAbsen,
  };
}
