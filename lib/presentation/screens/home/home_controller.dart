import 'dart:convert';
import 'package:get/get.dart';
import 'package:kelas_kita/data/models/tagihan_kas.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../constants.dart';
import '../../../data/api/firebase_api.dart';
import '../../../data/models/biografi_model.dart';
import '../../registration/biografi/kelas_model.dart';

class HomeController extends GetxController {
  var isLoading = true.obs;
  RxString userName = ''.obs;
  RxString idBiodata = ''.obs;
  var userStatus = ''.obs;
  var selectedKelas = KelasModel(
      idKelas: 0,
      nama: '',
      idBiodata: 0,
      jumlahKas: 0,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now()
  ).obs;
  RxList<InfoBiografiModel> biografiList = <InfoBiografiModel>[].obs;
  RxList<InfoTagihanKasModel> tagihanKasList = <InfoTagihanKasModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchBiografi();
    fetchTagihanKas();
    postFcmToken();
    FirebaseApi().initNotifications();
    Future.delayed(Duration(seconds: 4), () {
      isLoading.value = false;
    });
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

  Future<void> saveIdBiodata(int id_biodata) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('id_biodata', id_biodata.toString());
    idBiodata.value = id_biodata.toString();
  }

  Future<void> refreshHome() async {
    isLoading.value = true;
    await loadUserName();
    await Future.delayed(Duration(seconds: 2));
    isLoading.value = false;
  }

  Future<void> postFcmToken() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? fcmToken = prefs.getString('fcm_token');
      String? email = prefs.getString('email');
      String? token = prefs.getString('token');

      // Debug prints
      print('Email: $email');
      print('FCM Token Home: $fcmToken');
      print('Bearer Token: $token');

      if (fcmToken != null && email != null && token != null) {
        final response = await http.post(
          Uri.parse('https://kelaskita.site/api/register_fcm'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode({
            'email': email,
            'fcm_token': fcmToken,
          }),
        );

        if (response.statusCode == 200) {
          print('FCM Token posted successfully');
        } else {
          print('Failed to post FCM Token, status code: ${response.statusCode}');
          print('Response body: ${response.body}');
        }
      } else {
        print('FCM Token, email, or Bearer token is null. Unable to post FCM token.');
      }
    } catch (e) {
      print('Error posting FCM token: $e');
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

          await saveUserName(fetchedData.nama ?? '');
          prefs.setInt('id_user', userId);
          prefs.setString('isLoginGoogle', 'true');
          prefs.setString('userName', fetchedData.nama ?? '');

          await saveIdBiodata(fetchedData.idBiodata ?? 0);
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

  Future<void> fetchTagihanKas() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      int? userId = prefs.getInt('id_user');

      String? biodataIdString = prefs.getString('id_biodata');
      int? biodataId = biodataIdString != null ? int.tryParse(biodataIdString) : null;

      print('biodataId: $biodataId');  // Log the biodataId to check its value
      if (userId != null) {
        final url = Uri.parse('$baseUrl$tagihanKasUserEndPoint$biodataId');
        print('Requesting URL: $url');

        final response = await http.get(
          url,
          headers: <String, String>{
            'Authorization': 'Bearer $token',
          },
        );

        if (response.statusCode == 200) {
          var jsonResponse = json.decode(response.body) as List<dynamic>;
          print('JSON Response: $jsonResponse');

          jsonResponse.forEach((data) {
            print('Item from response: $data');
            print('Nominal type: ${data['nominal'].runtimeType}');
          });

          var fetchedData = jsonResponse.map((data) => InfoTagihanKasModel.fromJson(data)).toList();
          tagihanKasList.value = fetchedData;

          print('Successfully loaded tagihan kas data: ${tagihanKasList.length}');
        } else {
          print('Failed to load tagihan kas, status code: ${response.statusCode}');
          throw Exception('Failed to load tagihan kas');
        }
      } else {
        print('biodataId is null or User ID is null. Unable to fetch tagihan kas.');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error E: $e');
    }
  }

}
