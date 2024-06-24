import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../constants.dart';
import '../../../../data/models/biografi_model.dart';

class DetailProfileController extends GetxController {
  var isLoading = true.obs;
  var userName = 'User'.obs;
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
          Uri.parse(baseUrl + biodataEndpointGet + '$userId'),
          headers: <String, String>{
            'Authorization': 'Bearer $token',
          },
        );

        if (response.statusCode == 200) {
          var jsonResponse = json.decode(response.body);
          InfoBiografiModel biografiModel = InfoBiografiModel.fromJson(jsonResponse);

          prefs.setString('nama', biografiModel.nama);
          prefs.setInt('nis', biografiModel.nis);
          prefs.setString('alamat', biografiModel.alamat);
          prefs.setInt('id_kelas', biografiModel.idKelas);
          prefs.setString('status', biografiModel.status);
          prefs.setString('email', biografiModel.user.email);
          prefs.setInt('nomor', biografiModel.user.nomor);

          userName.value = biografiModel.nama;
          nis.value = biografiModel.nis.toString();
          address.value = biografiModel.alamat;
          className.value = biografiModel.kelas.nama;
          bio.value = biografiModel.bio ?? '';
          email.value = biografiModel.user.email;
          phoneNumber.value = biografiModel.user.nomor.toString();

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
