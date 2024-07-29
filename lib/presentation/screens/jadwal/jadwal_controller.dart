import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:kelas_kita/data/models/jadwal_kelas_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../constants.dart';

class JadwalController extends GetxController {
  RxList<JadwalKelasModel> jadwalKelasList = <JadwalKelasModel>[].obs;
  var isLoading = true.obs;
  var selectedDay = ''.obs;
  List<JadwalKelasModel> senin = [];
  List<JadwalKelasModel> selasa = [];
  List<JadwalKelasModel> rabu = [];
  List<JadwalKelasModel> kamis = [];
  List<JadwalKelasModel> jumat = [];
  List<JadwalKelasModel> sabtu = [];

  @override
  void onInit() {
    super.onInit();
    fetchJadwalPelajaran();
    selectDay(getCurrentDay());
  }

  void fetchJadwalPelajaran() async {
    isLoading.value = true;
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
          print('Data fetched successfully: ${jadwalKelasList.length} items');
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

  List<JadwalKelasModel> getScheduleForDay(String day) {
    return jadwalKelasList.where((item) => item.hari == day).toList();
  }

  void selectDay(String day) {
    selectedDay.value = day;
  }

  String formatTime(String time) {
    DateTime parsedTime = DateFormat("HH:mm:ss").parse(time);
    return DateFormat("HH:mm").format(parsedTime);
  }

  String getCurrentDay() {
    switch (DateTime.now().weekday) {
      case DateTime.monday:
        return 'Sen';
      case DateTime.tuesday:
        return 'Sel';
      case DateTime.wednesday:
        return 'Rab';
      case DateTime.thursday:
        return 'Kam';
      case DateTime.friday:
        return 'Jum';
      case DateTime.saturday:
        return 'Sab';
      default:
        return 'Sel'; // Default to Tuesday if something goes wrong
    }
  }

  void selecDay(String day) {
    selectedDay.value = day;
  }

  List<JadwalKelasModel> getScheduleDay(String day) {
    switch (day) {
      case 'Sen':
        return senin;
      case 'Sel':
        return selasa;
      case 'Rab':
        return rabu;
      case 'Kam':
        return kamis;
      case 'Jum':
        return jumat;
      case 'Sab':
        return sabtu;
      default:
        return [];
    }
  }
}
