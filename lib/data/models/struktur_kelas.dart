import 'package:flutter/material.dart';
import 'package:kelas_kita/presentation/screens/struktur_kelas/struktur_kelas_controller.dart';

class StrukturKelasModel{
  final String name;
  final String role;
  final int absen;
  final String alamat;
  final int nis;
  final int noHP;
  StrukturKelasModel ({
    required this.name,
    required this.role,
    required this.absen,
    required this.alamat,
    required this.nis,
    required this.noHP
  });
}

List<StrukturKelasModel> strukturKelasList = [
  StrukturKelasModel(name: "Dwi Janto", role: 'Wali Kelas', absen: 01, alamat: 'Jepara', nis: 04996, noHP: 085111222333),
  StrukturKelasModel(name: "Asyella Veratia Azahra Putri Qodri", role: 'Ketua Kelas', absen: 06, alamat: 'Purbalingga', nis: 04996, noHP: 085111222333),
  StrukturKelasModel(name: "Vicko Amelino Syahputra", role: 'Wakil Ketua Kelas', absen: 34, alamat: 'Kudus', nis: 04996, noHP: 085111222333),
  StrukturKelasModel(name: "Fawwaz Taufiqi Rachman", role: 'Bendahara', absen: 16, alamat: 'Depok', nis: 04996, noHP: 085111222333),
  StrukturKelasModel(name: "Alya Rana Raya", role: 'Sekretaris', absen: 04, alamat: 'Kudus', nis: 04996, noHP: 085111222333),
  StrukturKelasModel(name: "Damar Fikri Haikal", role: 'Siswa', absen: 10, alamat: 'Depok', nis: 04996, noHP: 085111222333),
  StrukturKelasModel(name: "Baratha Wijaya Kusuma Atmaja", role: 'Siswa', absen: 07, alamat: 'Rembang', nis: 04996, noHP: 085111222333),
  StrukturKelasModel(name: "Moch Siril Wafa Zidane Feliano", role: 'Siswa', absen: 21, alamat: 'Kudus', nis: 04996, noHP: 085111222333),
  StrukturKelasModel(name: "Muhammad Ammar Faris Fauzi", role: 'Siswa', absen: 24, alamat: 'Rembang', nis: 04996, noHP: 085111222333),
  StrukturKelasModel(name: "Muhammad Akbar Felda", role: 'Siswa', absen: 25, alamat: 'Kudus', nis: 04996, noHP: 085111222333),

];