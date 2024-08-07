import 'dart:async';
import 'dart:convert';

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../constants.dart';
import '../../../data/models/biografi_model.dart';
import '../../../data/models/jadwal_kelas_model.dart';

class QrCodeSiswaController extends GetxController {
  RxList<InfoBiografiModel> biografiList = <InfoBiografiModel>[].obs;
  RxList<JadwalKelasModel> jadwalKelasList = <JadwalKelasModel>[].obs;
  RxString selectedPelajaran = ''.obs;
  RxString selectedIdPelajaran = ''.obs;
  RxString qrData = ''.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    fetchBiografi();
    fetchJadwalPelajaran();
    _startQrCodeTimer();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  Future<void> fetchJadwalPelajaran() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      int? idKelas = prefs.getInt('id_kelas');

      if (idKelas != null) {
        final response = await http.get(
          Uri.parse(baseUrl + getJadwalKelasEndPoint + '$idKelas'),
          headers: {
            'Authorization': 'Bearer $token',
          },
        );

        if (response.statusCode == 200) {
          var fetchedData = jadwalKelasModelFromJson(response.body);
          jadwalKelasList.value = fetchedData;
        } else {
          print('Failed to fetch data: ${response.statusCode}');
        }
      } else {
        print('id_kelas is null');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  Future<void> fetchBiografi() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      int? userId = prefs.getInt('id_user');

      if (userId != null) {
        final response = await http.get(
          Uri.parse('$baseUrl$biodataEndpointGet$userId'),
          headers: <String, String>{
            'Authorization': 'Bearer $token',
          },
        );

        if (response.statusCode == 200) {
          var jsonResponse = json.decode(response.body);
          print('JSON Response: $jsonResponse');

          var fetchedData = InfoBiografiModel.fromJson(jsonResponse);
          biografiList.value = [fetchedData];

          print('Successfully loaded biografi data: ${biografiList.length}');
        } else {
          print('Failed to load biografi, status code: ${response.statusCode}');
          throw Exception('Failed to load biografi');
        }
      } else {
        print('User ID is null. Unable to fetch biografi.');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error: $e');
    }
  }

  void setSelectedPelajaran(String pelajaran, int idPelajaran) {
    selectedPelajaran.value = pelajaran;
    selectedIdPelajaran.value = idPelajaran.toString();
    _generateQrCode();
  }

  void _generateQrCode() {
    final biografi = biografiList.isNotEmpty ? biografiList.first : null;
    final data = 'Pelajaran: ${selectedPelajaran.value}, '
        'Nama: ${biografi?.nama ?? 'N/A'}, '
        'ID Kelas: ${biografi?.kelas.idKelas ?? 'N/A'}, '
        'Waktu Absen: ${DateTime.now().toIso8601String()}, '
        'ID Biodata: ${biografi?.idBiodata ?? 'N/A'}, '
        'ID Pelajaran: ${selectedIdPelajaran.value}';
    qrData.value = data;
  }

  void _startQrCodeTimer() {
    _timer = Timer.periodic(Duration(seconds: 7), (timer) {
      if (selectedPelajaran.value.isNotEmpty) {
        _generateQrCode();
      }
    });
  }
}
