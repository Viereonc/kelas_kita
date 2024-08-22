import 'dart:convert';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../constants.dart';
import '../../../data/models/jadwal_kelas_model.dart';
import '../../../data/models/biografi_model.dart';

class JadwalController extends GetxController {
  // Observables for storing data
  RxList<JadwalKelasModel> jadwalKelasList = <JadwalKelasModel>[].obs;
  RxList<InfoBiografiModel> biografiList = <InfoBiografiModel>[].obs;
  var userStatus = ''.obs;
  var isLoading = true.obs;
  var selectedDay = ''.obs;
  var absensiList = <Absensi>[].obs;

  // Schedules for different days
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
    fetchBiografi();
  }

  // Fetching the schedule data
  void fetchJadwalPelajaran() async {
    isLoading.value = true;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      int? idKelas = prefs.getInt('id_kelas');

      if (idKelas != null) {
        final response = await http.get(
          Uri.parse('$baseUrl$getJadwalKelasEndPoint$idKelas'),
          headers: {
            'Authorization': 'Bearer $token',
          },
        );

        if (response.statusCode == 200) {
          var fetchedData = jadwalKelasModelFromJson(response.body);
          jadwalKelasList.value = fetchedData;

          // Update schedules based on the fetched data
          _updateSchedules();

          print('Data fetched successfully: ${jadwalKelasList.length} items');
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

  // Update the schedules based on the selected day
  void _updateSchedules() {
    senin = getScheduleForDay('Sen');
    selasa = getScheduleForDay('Sel');
    rabu = getScheduleForDay('Rab');
    kamis = getScheduleForDay('Kam');
    jumat = getScheduleForDay('Jum');
    sabtu = getScheduleForDay('Sab');
  }

  // Get the schedule for a specific day
  List<JadwalKelasModel> getScheduleForDay(String day) {
    return jadwalKelasList.where((item) => item.hari == day).toList();
  }

  // Set the selected day
  void selectDay(String day) {
    selectedDay.value = day;
  }

  // Format the time from HH:mm:ss to HH:mm
  String formatTime(String time) {
    DateTime parsedTime = DateFormat("HH:mm:ss").parse(time);
    return DateFormat("HH:mm").format(parsedTime);
  }

  // Get the current day of the week in a specific format
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

  // Fetch biography data for the user
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

          userStatus.value = fetchedData.role.nama.toString();

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
}
