import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../constants.dart';
import '../../../../data/models/biografi_model.dart';

class DetailProfileController extends GetxController {
  RxList<InfoBiografiModel> biografiList = <InfoBiografiModel>[].obs;
  var isLoading = true.obs;
  var profileImageUrl = ''.obs;
  var userName = ''.obs;
  var className = ''.obs;
  var bio = ''.obs;
  var email = ''.obs;
  var phoneNumber = ''.obs;
  var address = ''.obs;
  var nis = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadLoading();
    fetchBiografi();
  }

  void loadLoading() async {
    await Future.delayed(Duration(seconds: 3));
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

          userName.value = fetchedData.nama ?? '';
          bio.value = fetchedData.bio ?? '';
          className.value = fetchedData.kelas.nama ?? '';
          nis.value = fetchedData.nis.toString() ?? '';
          email.value = fetchedData.user.email ?? '';
          phoneNumber.value = fetchedData.user.nomor.toString() ?? '';
          address.value = fetchedData.alamat ?? '';

          if (fetchedData.image != null && fetchedData.image.isNotEmpty) {
            profileImageUrl.value = '$baseUrl$storage${fetchedData.image}';
          }

          print('Successfully loaded biografi data');
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
