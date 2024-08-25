import 'dart:convert';

List<InfoHistoryBayarModel> infoHistoryBayarModelFromJson(String str) => List<InfoHistoryBayarModel>.from(json.decode(str).map((x) => InfoHistoryBayarModel.fromJson(x)));

String infoHistoryBayarModelToJson(List<InfoHistoryBayarModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class InfoHistoryBayarModel {
  int id;
  int idBiodata;
  String method;
  int nominal;
  DateTime createdAt;
  DateTime updatedAt;

  InfoHistoryBayarModel({
    required this.id,
    required this.idBiodata,
    required this.method,
    required this.nominal,
    required this.createdAt,
    required this.updatedAt,
  });

  factory InfoHistoryBayarModel.fromJson(Map<String, dynamic> json) => InfoHistoryBayarModel(
    id: json["id"],
    idBiodata: json["id_biodata"],
    method: json["method"],
    nominal: json["nominal"],
    createdAt: DateTime.parse(json["created_at"] ?? DateTime.now().toIso8601String()),
    updatedAt: DateTime.parse(json["updated_at"] ?? DateTime.now().toIso8601String()),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "id_biodata": idBiodata,
    "method": method,
    "nominal": nominal,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
