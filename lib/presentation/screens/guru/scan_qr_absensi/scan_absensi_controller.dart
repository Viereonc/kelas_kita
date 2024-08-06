import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kelas_kita/presentation/screens/guru/scan_qr_absensi/qr_code.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../constants.dart';

class ScanAbsensiController extends GetxController {
  var isLoading = false.obs;
  var scannedData = {}.obs;
  var dialogShown = false.obs; // Flag to track if the dialog is shown

  void setScannedData(String code) {
    final data = parseScannedData(code);
    if (data != null) {
      scannedData.value = data;
      if (!dialogShown.value) {
        dialogShown.value = true; // Set the flag to true when dialog is shown
        Get.dialog(ScannedDataDialog());
      }
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

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Data posted successfully!");
        Get.back(); // Close dialog
      } else if (response.statusCode == 422) {
        print('Response body: ${response.body}');
      } else if (response.statusCode == 500) {
        print('Response body: ${response.body}');
      } else {
        print("Failed to post data. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Map<String, dynamic>? parseScannedData(String code) {
    try {
      // Use regular expressions to find the parts
      final regexPelajaran = RegExp(r'ID Pelajaran: (\d+)');
      final regexWaktuAbsen = RegExp(r'Waktu Absen: ([^\s,]+)');
      final regexBiodata = RegExp(r'ID Biodata: (\d+)');

      final idPelajaranPart = regexPelajaran.firstMatch(code)?.group(0) ?? '';
      final waktuAbsenPart = regexWaktuAbsen.firstMatch(code)?.group(0) ?? '';
      final idBiodataPart = regexBiodata.firstMatch(code)?.group(0) ?? '';

      // Log each part for debugging
      print('ID Pelajaran Part: $idPelajaranPart');
      print('Waktu Absen Part: $waktuAbsenPart');
      print('ID Biodata Part: $idBiodataPart');

      // Validate each part
      if (idPelajaranPart.isEmpty) print('ID Pelajaran part is missing');
      if (waktuAbsenPart.isEmpty) print('Waktu Absen part is missing');
      if (idBiodataPart.isEmpty) print('ID Biodata part is missing');

      // If all parts are present, parse the data
      if (idPelajaranPart.isNotEmpty && waktuAbsenPart.isNotEmpty && idBiodataPart.isNotEmpty) {
        final idPelajaran = regexPelajaran.firstMatch(code)?.group(1) ?? '';
        final waktuAbsenRaw = regexWaktuAbsen.firstMatch(code)?.group(1) ?? '';
        final idBiodata = regexBiodata.firstMatch(code)?.group(1) ?? '';

        final cleanedWaktuAbsen = waktuAbsenRaw.split('ID').first;

        // Adjust waktu_absen to correct format if needed
        final waktuAbsenTime = DateTime.parse(cleanedWaktuAbsen).toLocal().toIso8601String().substring(11, 16);

        return {
          "id_biodata": idBiodata,
          "id_pelajaran": idPelajaran,
          "waktu_absen": waktuAbsenTime,
        };
      } else {
        print('Failed to parse data due to missing parts');
        return null;
      }
    } catch (e) {
      print("Error parsing scanned data: $e");
      return null;
    }
  }
}
