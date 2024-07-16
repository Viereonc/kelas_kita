import 'package:get/get.dart';
import 'package:kelas_kita/data/models/jadwal_piket_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../constants.dart';

class JadwalPiketController extends GetxController {
  RxList<JadwalPiketModel> jadwalPiketList = <JadwalPiketModel>[].obs;
  var isLoading = true.obs;
  var selectedDay = '';

  @override
  void onInit() {
    super.onInit();
    loadLoading();
    fetchJadwalPiket();
  }

  void loadLoading() async {
    await Future.delayed(Duration(seconds: 3));
    isLoading.value = false;
  }

  void fetchJadwalPiket() async {
    isLoading.value = true;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      int? idKelas = prefs.getInt('id_kelas');

      if (idKelas != null) {
        final response = await http.get(
          Uri.parse(baseUrl + getJadwalPiketEndPoint + '$idKelas'),
          headers: {
            'Authorization': 'Bearer $token',
          },
        );

        if (response.statusCode == 200) {
          var fetchedData = jadwalPiketModelFromJson(response.body);
          jadwalPiketList.value = fetchedData;
          print('Data fetched successfully: ${jadwalPiketList.length} items');
          print('First item: ${fetchedData.isNotEmpty ? fetchedData[0].toJson() : 'No data'}');
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

  List<JadwalPiketModel> getScheduleForDay(String day) {
    return jadwalPiketList.where((item) => item.hari == day).toList();
  }

  void selectDay(String day) {
    selectedDay = day;
    update();
  }
}
