import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../constants.dart';
import '../../../data/models/biografi_model.dart';

class ProfileController extends GetxController {
  RxList<InfoBiografiModel> biografiList = <InfoBiografiModel>[].obs;
  var isLoading = true.obs;
  var userName = 'User'.obs;
  var profileImageUrl = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadLoading();
    loadUserName();
    fetchBiografi();
  }

  void loadLoading() async {
    await Future.delayed(Duration(seconds: 3));
    isLoading.value = false;
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  Future<void> loadUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userName.value = prefs.getString('nama') ?? 'User';
  }

  Future<void> saveUserName(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('nama', name);
    userName.value = name;
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

          userName.value = fetchedData.nama ?? '';
          // profileImageUrl.value = fetchedData. ?? '';

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
