  import 'dart:convert';
  import 'package:get/get.dart';
  import 'package:shared_preferences/shared_preferences.dart';
  import 'package:http/http.dart' as http;
  import '../../../constants.dart';
  import 'package:kelas_kita/data/models/program_kas_model.dart';

  class PembukuanKasController extends GetxController {
    RxList<ProgramKelasModel> programKelasList = <ProgramKelasModel>[].obs;
    var isLoading = true.obs;

    @override
    void onInit() {
      super.onInit();
      loadLoading();
      fetchProgramKasKelas();
    }

    void loadLoading() async {
      await Future.delayed(Duration(seconds: 3));
      isLoading.value = false;
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

    Future<void> postProgramKelas(
      String idKelas,
      String nama,
      String status,
      String jumlah, // Pastikan ini adalah string yang merepresentasikan integer
      DateTime jadwal,
      DateTime createdAt,
      DateTime updatedAt,
    ) async {
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? token = prefs.getString('token');

        if (token != null) {
          final url = Uri.parse(baseUrl + programKasEndPoint);
          final headers = {
            'Authorization': 'Bearer $token',
          };

          final request = http.MultipartRequest('POST', url)
            ..headers.addAll(headers)
            ..fields['id_kelas'] = idKelas
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
  }
