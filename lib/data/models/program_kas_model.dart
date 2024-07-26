import 'dart:convert';

List<ProgramKelasModel> programKelasModelFromJson(String str) => List<ProgramKelasModel>.from(json.decode(str).map((x) => ProgramKelasModel.fromJson(x)));

String programKelasModelToJson(List<ProgramKelasModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProgramKelasModel {
  int idProgram;
  int idKelas;
  String nama;
  String status;
  int jumlah;
  DateTime jadwal;
  DateTime createdAt;
  DateTime updatedAt;

  ProgramKelasModel({
    required this.idProgram,
    required this.idKelas,
    required this.nama,
    required this.status,
    required this.jumlah,
    required this.jadwal,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProgramKelasModel.fromJson(Map<String, dynamic> json) => ProgramKelasModel(
    idProgram: json["id_program"],
    idKelas: json["id_kelas"],
    nama: json["nama"],
    status: json["status"],
    jumlah: json["jumlah"],
    jadwal: DateTime.parse(json["jadwal"]),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id_program": idProgram,
    "id_kelas": idKelas,
    "nama": nama,
    "status": status,
    "jumlah": jumlah,
    "jadwal": "${jadwal.year.toString().padLeft(4, '0')}-${jadwal.month.toString().padLeft(2, '0')}-${jadwal.day.toString().padLeft(2, '0')}",
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
