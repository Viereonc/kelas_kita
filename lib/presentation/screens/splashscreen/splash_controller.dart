import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kelas_kita/routes/app_routes.dart';
import 'package:kelas_kita/constants.dart';
import 'package:http/http.dart' as http;
import '../../../data/models/biografi_model.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  void checkLoginStatus() async {
    await Future.delayed(Duration(seconds: 2));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    print('isLoggedIn: $isLoggedIn');
    if (isLoggedIn == true) {
      await fetchBiografi();
    } else {
      Get.offNamed(Path.ONBOARDING_PAGE);
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
          InfoBiografiModel biografiModel = InfoBiografiModel.fromJson(jsonResponse);

          if (biografiModel != null) {
            prefs.setString('nama', biografiModel.nama ?? '');
            prefs.setInt('nis', biografiModel.nis ?? 0);
            prefs.setString('alamat', biografiModel.alamat ?? '');
            prefs.setInt('id_kelas', biografiModel.idKelas ?? 0);
            prefs.setString('status', biografiModel.status ?? '');
            print('Successfully loaded biografi data');

            String? lastPage = prefs.getString('last_page');
            if (lastPage != null) {
              Get.offNamed(lastPage);
            } else {
              if (biografiModel.status == 'A') {
                Get.offNamed(Path.HOME_PAGE);
              } else if (biografiModel.status == 'P') {
                Get.offNamed(Path.PENDING_PAGE);
              } else {
                Get.offNamed(Path.BIOGRAFI_PAGE);
              }
            }
          } else {
            print('Biografi data is null');
            Get.offNamed(Path.BIOGRAFI_PAGE);
          }
        } else {
          print('Failed to load biografi, status code: ${response.statusCode}');
          throw Exception('Failed to load biografi');
        }
      } else {
        print('User ID is null. Unable to fetch biografi.');
        Get.offNamed(Path.BIOGRAFI_PAGE);
      }
    } catch (e) {
      print('Error: $e');
      Get.offNamed(Path.BIOGRAFI_PAGE);
    }
  }
}
