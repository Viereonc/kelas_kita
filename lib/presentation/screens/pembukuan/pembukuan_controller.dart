  import 'dart:convert';
  import 'package:flutter/animation.dart';
  import 'package:get/get.dart';
  import 'package:kelas_kita/data/models/pembukuan_kas_model.dart';
  import 'package:shared_preferences/shared_preferences.dart';
  import 'package:http/http.dart' as http;
  import '../../../constants.dart';
  import 'package:kelas_kita/data/models/program_kas_model.dart';
  import 'package:kelas_kita/data/models/tagihan_kas.dart';

import '../../../data/models/biografi_model.dart';

class PembukuanKasController extends GetxController with SingleGetTickerProviderMixin{
  RxList<ProgramKelasModel> programKelasList = <ProgramKelasModel>[].obs;
  RxList<PembukuanKasModel> pembukuanKasList = <PembukuanKasModel>[].obs;
  RxList<InfoBiografiModel> biografiList = <InfoBiografiModel>[].obs;
  RxList<InfoTagihanKasModel> tagihanKasList = <InfoTagihanKasModel>[].obs;
  var isLoading = true.obs;
  var userStatus = ''.obs;
  var selectedType = 'Pengeluaran'.obs;
  // late AnimationController animationController;

  @override
  void onInit() {
    super.onInit();
    isLoading();
    // animationController = AnimationController(
    //   duration: const Duration(seconds: 1),
    //   vsync: this,
    // )..repeat();
    fetchProgramKasKelas();
    fetchPembukuanKasKelas();
    fetchBiografi();
    fetchTagihanKas();
  }

  // @override
  // void onClose() {
  //   animationController.dispose();
  //   super.onClose();
  // }

  void loadLoading() async {
    await Future.delayed(Duration(seconds: 1));
    isLoading.value = false;
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

          userStatus.value = fetchedData.role.nama;

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

  void fetchProgramKasKelas() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      int? idKelas = prefs.getInt('id_kelas');

      if (idKelas != null) {
        final response = await http.get(
          Uri.parse(baseUrl + programKasKelasEndPoint + '$idKelas'),
          headers: {
            'Authorization': 'Bearer $token',
          },
        );

        if (response.statusCode == 200) {
          var fetchedData = programKelasModelFromJson(response.body);
          programKelasList.value = fetchedData;
          print('Data fetched successfully: ${programKelasList.length} items');
        } else {
          print('Failed to fetch data: ${response.statusCode}');
        }
      } else {
        print('id_kelas is null');
      }
    } catch (e) {
      print('Error fetching data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void fetchPembukuanKasKelas() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      int? idKelas = prefs.getInt('id_kelas');

      if (idKelas != null) {
        final response = await http.get(
          Uri.parse(baseUrl + getPembukuanKasEndPoint + '$idKelas'),
          headers: {
            'Authorization': 'Bearer $token',
          },
        );

        if (response.statusCode == 200) {
          var fetchedData = pembukuanKasModelFromJson(response.body);
          pembukuanKasList.value = fetchedData;
          print('Data pembukuan kas fetched successfully: ${pembukuanKasList.length} items');
        } else {
          print('Failed to fetch data: ${response.statusCode}');
        }
      } else {
        print('id_kelas is null');
      }
    } catch (e) {
      print('Error fetching data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> postProgramKelas(String nama, String status, String jumlah, DateTime jadwal, DateTime createdAt, DateTime updatedAt,) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      int? idKelas = prefs.getInt('id_kelas');

      if (token != null) {
        final url = Uri.parse(baseUrl + programKasEndPoint);
        final headers = {
          'Authorization': 'Bearer $token',
        };

        final request = http.MultipartRequest('POST', url)
          ..headers.addAll(headers)
          ..fields['id_kelas'] = idKelas.toString()
          ..fields['nama'] = nama
          ..fields['status'] = status
          ..fields['jumlah'] = jumlah
          ..fields['jadwal'] = jadwal.toIso8601String()
          ..fields['created_at'] = createdAt.toIso8601String()
          ..fields['updated_at'] = updatedAt.toIso8601String();

        final response = await request.send();

        final responseString = await response.stream.bytesToString();
        if (response.statusCode == 201) {
          print('Program Kelas Berhasil Diunggah');
          fetchProgramKasKelas();
        } else {
          print('Failed to post data: ${response.statusCode}');
          print('Response body: $responseString');
        }
      } else {
        print('Token not found');
      }
    } catch (e) {
      print('Error posting data: $e');
    }
  }
  
  void deletePembukuanKas(int idProgram) async {
  print('ID Program yang akan dihapus: $idProgram');
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null) {
      final url = Uri.parse('${baseUrl}api/program_kas/$idProgram');
      print('Deleting URL: $url');
      final headers = {
        'Authorization': 'Bearer $token',
      };

      final response = await http.delete(url, headers: headers);
      final responseBody = response.body;

      if (response.statusCode == 200 || response.statusCode == 204) {
        print('Program berhasil dihapus');
        fetchProgramKasKelas();
      } else {
        print('Gagal menghapus program: ${response.statusCode}');
        print('Response body: $responseBody');
      }
    } else {
      print('Token not found');
    }
  } catch (e) {
    print('Error deleting data: $e');
  }
}

  Future<void> postPembukuanKasKelas(String nama, String jenis, String jumlah, DateTime jadwal, DateTime createdAt, DateTime updatedAt,) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      int? idKelas = prefs.getInt('id_kelas');

      if (token != null) {
        final url = Uri.parse(baseUrl + pembukuanKasEndPoint);
        final headers = {
          'Authorization': 'Bearer $token',
        };

        final request = http.MultipartRequest('POST', url)
          ..headers.addAll(headers)
          ..fields['id_kelas'] = idKelas.toString()
          ..fields['nama'] = nama
          ..fields['jenis'] = jenis
          ..fields['jumlah_pengeluaran'] = jumlah
          ..fields['tanggal'] = jadwal.toIso8601String()
          ..fields['created_at'] = createdAt.toIso8601String()
          ..fields['updated_at'] = updatedAt.toIso8601String();

        final response = await request.send();

        final responseString = await response.stream.bytesToString();
        if (response.statusCode == 201) {
          print('Program Kelas Berhasil Diunggah');
          fetchProgramKasKelas();
        } else {
          print('Failed to post data: ${response.statusCode}');
          print('Response body: $responseString');
        }
      } else {
        print('Token not found');
      }
    } catch (e) {
      print('Error posting data: $e');
    }
  }

  Future<void> fetchTagihanKas() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      // Retrieve userId and biodataId as strings, then convert them to int if possible
      String? userIdStr = prefs.getString('id_user');
      int? userId = userIdStr != null ? int.tryParse(userIdStr) : null;

      String? biodataIdStr = prefs.getString('id_biodata');
      int? biodataId = biodataIdStr != null ? int.tryParse(biodataIdStr) : null;

      print('User ID: $userId, Biodata ID: $biodataId'); // Debug print

      if (userId != null && biodataId != null) {
        final response = await http.get(
          Uri.parse('$baseUrl$tagihanKasUserEndPoint$biodataId'),
          headers: <String, String>{
            'Authorization': 'Bearer $token',
          },
        );

        if (response.statusCode == 200) {
          var jsonResponse = json.decode(response.body) as List<dynamic>;
          print('JSON Response: $jsonResponse');

          var fetchedData = jsonResponse.map((data) => InfoTagihanKasModel.fromJson(data)).toList();
          tagihanKasList.value = fetchedData;

          print('Successfully loaded tagihan kas data: ${tagihanKasList.length}');
        } else {
          print('Failed to load tagihan kas, status code: ${response.statusCode}');
          throw Exception('Failed to load tagihan kas');
        }
      } else {
        print('User ID or biodata ID is null. Unable to fetch tagihan kas.');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error: $e');
    }
  }

}
