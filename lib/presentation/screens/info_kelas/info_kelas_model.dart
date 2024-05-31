import 'dart:convert';

List<InfoKelasModel> infoKelasModelFromJson(String str) => List<InfoKelasModel>.from(json.decode(str).map((x) => InfoKelasModel.fromJson(x)));

String infoKelasModelToJson(List<InfoKelasModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class InfoKelasModel {
  int idInformasiKelas;
  int idKelas;
  String image;
  String pengumuman;
  DateTime createdAt;
  DateTime updatedAt;

  InfoKelasModel({
    required this.idInformasiKelas,
    required this.idKelas,
    required this.image,
    required this.pengumuman,
    required this.createdAt,
    required this.updatedAt,
  });

  factory InfoKelasModel.fromJson(Map<String, dynamic> json) => InfoKelasModel(
    idInformasiKelas: json["id_informasi_kelas"],
    idKelas: json["id_kelas"],
    image: json["image"],
    pengumuman: json["pengumuman"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id_informasi_kelas": idInformasiKelas,
    "id_kelas": idKelas,
    "image": image,
    "pengumuman": pengumuman,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
