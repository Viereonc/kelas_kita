import 'dart:convert';

List<StrukturKelasAllModel> strukturKelasAllModelFromJson(String str) => List<StrukturKelasAllModel>.from(json.decode(str).map((x) => StrukturKelasAllModel.fromJson(x)));

String strukturKelasAllModelToJson(List<StrukturKelasAllModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StrukturKelasAllModel {
  int idBiodata;
  int idUser;
  int idKelas;
  int idRole;
  String nama;
  int nis;
  Alamat alamat;
  dynamic bio;
  Status status;
  DateTime createdAt;
  DateTime updatedAt;
  User user;
  Kelas kelas;
  int? absen; // New property

  StrukturKelasAllModel({
    required this.idBiodata,
    required this.idUser,
    required this.idKelas,
    required this.idRole,
    required this.nama,
    required this.nis,
    required this.alamat,
    required this.bio,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    required this.kelas,
    this.absen,
  });

  factory StrukturKelasAllModel.fromJson(Map<String, dynamic> json) => StrukturKelasAllModel(
    idBiodata: json["id_biodata"],
    idUser: json["id_user"],
    idKelas: json["id_kelas"],
    idRole: json["id_role"],
    nama: json["nama"],
    nis: json["nis"],
    alamat: alamatValues.map[json["alamat"]]!,
    bio: json["bio"],
    status: statusValues.map[json["status"]]!,
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    user: User.fromJson(json["user"]),
    kelas: Kelas.fromJson(json["kelas"]),
    absen: json["absen"],
  );

  Map<String, dynamic> toJson() => {
    "id_biodata": idBiodata,
    "id_user": idUser,
    "id_kelas": idKelas,
    "id_role": idRole,
    "nama": nama,
    "nis": nis,
    "alamat": alamatValues.reverse[alamat],
    "bio": bio,
    "status": statusValues.reverse[status],
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "user": user.toJson(),
    "kelas": kelas.toJson(),
    "absen": absen,
  };
}

enum Alamat {
  DEPOK,
  KUDUS,
  REMBANG
}

final alamatValues = EnumValues({
  "Depok": Alamat.DEPOK,
  "Kudus": Alamat.KUDUS,
  "Rembang": Alamat.REMBANG
});

class Kelas {
  int idKelas;
  Nama nama;
  dynamic createdAt;
  dynamic updatedAt;

  Kelas({
    required this.idKelas,
    required this.nama,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Kelas.fromJson(Map<String, dynamic> json) => Kelas(
    idKelas: json["id_kelas"],
    nama: namaValues.map[json["nama"]]!,
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id_kelas": idKelas,
    "nama": namaValues.reverse[nama],
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

enum Nama {
  THE_11_PPLG_1,
  THE_11_PPLG_2
}

final namaValues = EnumValues({
  "11 PPLG 1": Nama.THE_11_PPLG_1,
  "11 PPLG 2": Nama.THE_11_PPLG_2
});

enum Status {
  A
}

final statusValues = EnumValues({
  "A": Status.A
});

class User {
  int idUser;
  String username;
  String email;
  int nomor;
  DateTime createdAt;
  DateTime updatedAt;

  User({
    required this.idUser,
    required this.username,
    required this.email,
    required this.nomor,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    idUser: json["id_user"],
    username: json["username"],
    email: json["email"],
    nomor: json["nomor"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id_user": idUser,
    "username": username,
    "email": email,
    "nomor": nomor,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
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
