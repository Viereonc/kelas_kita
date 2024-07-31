import 'dart:convert';
import 'package:get/get.dart';
import 'package:kelas_kita/data/models/tagihan_kas.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../constants.dart';
import '../../../data/models/biografi_model.dart';
import '../../registration/biografi/kelas_model.dart';

class HomeController extends GetxController {
  var isLoading = true.obs;
  RxString userName = ''.obs;
  var selectedKelas = KelasModel(idKelas: 0, nama: '').obs;
  RxList<InfoBiografiModel> biografiList = <InfoBiografiModel>[].obs;
  RxList<InfoTagihanKasModel> tagihanKasList = <InfoTagihanKasModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchBiografi();
    fetchTagihanKas();
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

  Future<void> refreshHome() async {
    isLoading.value = true;
    await loadUserName();
    await Future.delayed(Duration(seconds: 2));
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

          // Save the user's name in shared preferences
          await saveUserName(fetchedData.nama ?? '');

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

      if (userId != null) {
        final response = await http.get(
          Uri.parse('$baseUrl$tagihanKasUserEndPoint$userId'),
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
        print('User ID is null. Unable to fetch tagihan kas.');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error: $e');
    }
  }

}
