import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kelas_kita/data/models/biografi_model.dart';
import 'package:kelas_kita/data/models/struktur_kelas_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../constants.dart';

class StrukturKelasController extends GetxController{
  RxList<InfoStrukturKelasModel> infoStrukturKelasList = <InfoStrukturKelasModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadLoading();
    fetchStrukturKelas();
  }

  void loadLoading() async {
    await Future.delayed(Duration(seconds: 3));
    isLoading.value = false;
  }

  void fetchStrukturKelas() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      int? idKelas = prefs.getInt('id_kelas');

      if (idKelas != null) {
        final response = await http.get(
          Uri.parse(baseUrl + strukturKelasEndpointGet + '$idKelas'),
          headers: {
            'Authorization': 'Bearer $token',
          },
        );
        if (response.statusCode == 200) {
          var fetchedData = infoStrukturKelasModelFromJson(response.body);

          fetchedData.sort((a, b) => a.nama.compareTo(b.nama));
          for (int i = 0; i < fetchedData.length; i++) {
            fetchedData[i].absen = i + 1;
          }

          infoStrukturKelasList.value = fetchedData;
          print('Data fetched successfully: ${infoStrukturKelasList.length} items');
        } else {
          print('Failed to fetch data: ${response.statusCode}');
        }
      } else {
        print('id_kelas is null');
      }
    } catch (e, stacktrace) {
      print('Error fetching data: $e');
      debugPrintStack(stackTrace: stacktrace);  // This will print the full stack trace
    } finally {
      isLoading.value = false;
    }
  }

}
