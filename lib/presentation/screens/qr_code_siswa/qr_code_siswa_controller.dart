import 'dart:async';
import 'dart:convert';

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:kelas_kita/data/models/jadwal_piket_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../constants.dart';
import '../../../data/models/biografi_model.dart';
import '../../../data/models/jadwal_kelas_model.dart';

class QrCodeSiswaController extends GetxController {
  RxList<InfoBiografiModel> biografiList = <InfoBiografiModel>[].obs;
  RxList<JadwalKelasModel> jadwalKelasList = <JadwalKelasModel>[].obs;
  RxList<int> attendedLessons = <int>[].obs;
  RxString selectedPelajaran = ''.obs;
  RxString selectedIdPelajaran = ''.obs;
  // RxString selectedGuru = ''.obs;
  RxString selectedMapelPelajaran = ''.obs;
  RxString qrData = ''.obs;
  RxString userName = ''.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    fetchBiografi();
    fetchJadwalPelajaran();
    _startQrCodeTimer();
    loadUserName();
    _generateQrCodeForCurrentTime();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  bool isAlreadyAttended(int idPelajaran) {
    return attendedLessons.contains(idPelajaran);
  }

  void _generateQrCodeForCurrentTime() {
    final now = DateTime.now();
    final currentHour = now.hour.toString().padLeft(2, '0');
    final currentMinute = now.minute.toString().padLeft(2, '0');
    final currentTime = '$currentHour:$currentMinute';

    if (jadwalKelasList.isNotEmpty) {
      final pelajaran = jadwalKelasList.firstWhere(
        (jadwal) => jadwal.jamMulai.compareTo(currentTime) <= 0 &&
                    jadwal.jamSelesai.compareTo(currentTime) >= 0,
        orElse: () => JadwalKelasModel(
          idPelajaran: 0,
          namaPelajaran: 'N/A',
          hari: 'N/A',
          jamMulai: '00:00',
          jamSelesai: '00:00',
          kelas: '',
          guru: '',
          absensi: [],
        ),
      );

      selectedPelajaran.value = pelajaran.namaPelajaran;
      selectedIdPelajaran.value = pelajaran.idPelajaran.toString();
      _generateQrCode();
    } else {
      print('jadwalKelasList is empty');
    }
  }

  void markAsAttended(int idPelajaran) {
    if (!attendedLessons.contains(idPelajaran)) {
      attendedLessons.add(idPelajaran);
    }
  }

  Future<void> loadUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userName.value = prefs.getString('nama') ?? '';
  }

  Future<void> saveUserName(String nama) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('nama', nama);
    userName.value = nama;
  }

  Future<int?> fetchBiodataId() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? biodataId = prefs.getInt('id_biodata');
      return biodataId;
    } catch (e) {
      print('Error fetching id_biodata: $e');
      return null;
    }
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
          _generateQrCodeForCurrentTime(); // Generate QR code after fetching data
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

  void setSelectedPelajaran(String pelajaran, int idPelajaran, String guru) {
    selectedPelajaran.value = pelajaran;
    selectedIdPelajaran.value = idPelajaran.toString();
    _generateQrCode();
  }

  void _generateQrCode() {
    final biografi = biografiList.isNotEmpty ? biografiList.first : null;
    final pelajaran = jadwalKelasList.isNotEmpty ? jadwalKelasList.firstWhere(
        (jadwal) => jadwal.idPelajaran.toString() == selectedIdPelajaran.value,
        orElse: () => JadwalKelasModel(
          idPelajaran: 0,
          namaPelajaran: 'N/A',
          hari: 'N/A',
          jamMulai: '00:00',
          jamSelesai: '00:00',
          kelas: '',
          guru: '',
          absensi: [],
        ),
    ) : null;

    final data = 'Pelajaran: ${selectedPelajaran.value}, '
        'Nama: ${biografi?.nama ?? 'N/A'}, '
        'Nama Kelas: ${biografi?.kelas.nama ?? 'N/A'}, '
        'Waktu Absen: ${DateTime.now().toIso8601String()}, '
        'ID Biodata: ${biografi?.idBiodata ?? 'N/A'}, '
        'ID Pelajaran: ${selectedIdPelajaran.value}, '
        'Guru: ${pelajaran?.guru ?? 'N/A'}';
    qrData.value = data;
  }

  void _startQrCodeTimer() {
    _timer = Timer.periodic(Duration(seconds: 7), (timer) {
      if (jadwalKelasList.isNotEmpty) {
        _generateQrCodeForCurrentTime();
      }
    });
  }
}