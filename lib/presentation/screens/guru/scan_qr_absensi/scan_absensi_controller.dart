import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../constants.dart';

class ScanAbsensiController extends GetxController {
  var isLoading = false.obs;
  var scannedData = {}.obs;

  void setScannedData(String code) {
    final data = _parseScannedData(code);
    if (data != null) {
      scannedData.value = data;
    }
  }

  Future<void> postAbsensi() async {
    if (scannedData.isEmpty) {
      print("No data to post");
      return;
    }

    isLoading.value = true;

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        print("Token is null");
        isLoading.value = false;
        return;
      }

      var url = Uri.parse(baseUrl + absensiEndPoint);
      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      var response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(scannedData),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Data posted successfully!");
        Get.back(); // Navigate back after successful post
      } else {
        print("Failed to post data. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Map<String, dynamic>? _parseScannedData(String code) {
    try {
      final parts = code.split(', ');

      // Tambahkan log untuk melihat bagian yang dipecah
      print('Parts: $parts');

      if (parts.isEmpty || parts.length < 4) {
        print('Parts length is not sufficient');
        return null;
      }

      final idBiodataPart = parts.firstWhere((part) => part.startsWith('ID Biodata:'), orElse: () => '');
      final idKelasPart = parts.firstWhere((part) => part.startsWith('ID Kelas:'), orElse: () => '');
      final namaPart = parts.firstWhere((part) => part.startsWith('Nama:'), orElse: () => '');
      final kelasPart = parts.firstWhere((part) => part.startsWith('Kelas:'), orElse: () => '');

      if (idBiodataPart.isEmpty || idKelasPart.isEmpty || namaPart.isEmpty || kelasPart.isEmpty) {
        print('One of the required parts is missing');
        return null;
      }

      final idBiodata = idBiodataPart.split(': ')[1];
      final idKelas = idKelasPart.split(': ')[1];
      final nama = namaPart.split(': ')[1];
      final kelas = kelasPart.split(': ')[1];
      final waktuAbsen = DateTime.now().toIso8601String();

      return {
        "id_biodata": idBiodata,
        "id_pelajaran": idKelas,
        "nama": nama,
        "kelas": kelas,
        "waktu_absen": waktuAbsen,
        "updated_at": DateTime.now().toIso8601String(),
        "created_at": DateTime.now().toIso8601String(),
      };
    } catch (e) {
      print("Error parsing scanned data: $e");
      return null;
    }
  }
}
