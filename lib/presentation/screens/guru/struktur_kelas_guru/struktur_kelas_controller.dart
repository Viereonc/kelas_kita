import 'dart:convert';

import 'package:get/get.dart';
import 'package:kelas_kita/data/models/biografi_model.dart';
import 'package:kelas_kita/data/models/struktur_kelas_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../../constants.dart';
import '../../../../data/models/struktur_kelas_all.dart';
import '../../../registration/biografi/kelas_model.dart';

class StrukturKelasGuruController extends GetxController {
  RxList<StrukturKelasAllModel> infoStrukturKelasList = <StrukturKelasAllModel>[].obs;
  List<KelasModel> kelasList = <KelasModel>[];
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadLoading();
    fetchStrukturKelas();
    fetchKelas();
  }

  void loadLoading() async {
    await Future.delayed(Duration(seconds: 3));
    isLoading.value = false;
  }

  Future<void> fetchKelas() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      final response = await http.get(
        Uri.parse(baseUrl + kelasEndpoint),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        kelasList = jsonResponse.map((data) => KelasModel.fromJson(data)).toList();
        print('Successfully loaded kelas');

        for (var kelas in kelasList) {
          print(kelas.nama);
        }
      } else {
        print('Failed to load kelas, status code: ${response.statusCode}');
        throw Exception('Failed to load kelas');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error: $e');
    }
  }

  void fetchStrukturKelas() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        throw Exception('Token is null');
      }

      final response = await http.get(
        Uri.parse(baseUrl + strukturKelasGuruEndpointGet),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        print('Response body: ${response.body}');

        var decodedResponse = jsonDecode(response.body);

        List<dynamic> allDataList = [];

        decodedResponse.forEach((key, value) {
          if (value != null) {
            allDataList.addAll(value);
          }
        });

        List<StrukturKelasAllModel> parsedDataList = allDataList.map((item) => StrukturKelasAllModel.fromJson(item)).toList();

        parsedDataList.sort((a, b) => a.nama.compareTo(b.nama));

        for (int i = 0; i < parsedDataList.length; i++) {
          parsedDataList[i].absen = i + 1;
        }

        infoStrukturKelasList.value = parsedDataList;
        print('Data fetched successfully: ${infoStrukturKelasList.length} items');
      } else {
        print('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
