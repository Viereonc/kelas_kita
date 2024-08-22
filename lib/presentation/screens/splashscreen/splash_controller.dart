import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:kelas_kita/routes/app_routes.dart';
import 'package:kelas_kita/constants.dart';
import 'package:http/http.dart' as http;
import '../../../data/models/biografi_model.dart';

class SplashController extends GetxController {

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
    getToken();
  }

  void checkLoginStatus() async {
    await Future.delayed(Duration(seconds: 2));
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool isLoginGoogle = prefs.getBool('isLoggedIn') ?? false;
    print('isLoggedIn: $isLoginGoogle');

    if (isLoginGoogle) {
      await fetchBiografi();
    } else {
      Get.offNamed(Path.ONBOARDING_PAGE);
    }
  }

  void getToken() async {
    try {
      FirebaseMessaging messaging = FirebaseMessaging.instance;
      String? token = await messaging.getToken();
      if (token != null) {
        print('FCM Token Splash Screen: $token');
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('fcm_token', token);
      } else {
        print('Failed to get FCM token');
      }
    } catch (e) {
      print('Error fetching FCM token: $e');
    }
  }

  Future<void> fetchBiografi() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      int? userId = prefs.getInt('id_user');
      int? nis = prefs.getInt('nis');

      if (nis != null && nis > 0) {
        final role = prefs.getString('role_name');
        if (role == 'Wali Kelas') {
          Get.offNamed(Path.HOMEGURU_PAGE);
        } else {
          Get.offNamed(Path.HOME_PAGE);
        }
        return;
      }

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
            prefs.setInt('nis', biografiModel.nis);
            prefs.setString('alamat', biografiModel.alamat ?? '');
            prefs.setInt('id_kelas', biografiModel.idKelas);
            prefs.setInt('id_biodata', biografiModel.idBiodata);
            prefs.setString('email', biografiModel.user.email ?? '');
            prefs.setInt('id_user', biografiModel.idUser);
            prefs.setInt('id_biodata', biografiModel.idBiodata);
            prefs.setString('id_google', biografiModel.user.idGoogle ?? '');
            prefs.setString('status', biografiModel.status.toString());
            prefs.setString('role_name', biografiModel.roleName.toString());

            print('ID Biodata: ${biografiModel.idBiodata}');

            final role = biografiModel.roleName.toString();
            if (role == 'RoleName.WALI_KELAS') {
              Get.offNamed(Path.HOMEGURU_PAGE);
            } else {
              Get.offNamed(Path.HOME_PAGE);
            }
          } else {
            print('Biografi data is null');
            Get.offNamed(Path.BIOGRAFI_PAGE);
          }
        } else {
          print('Failed to load biografi, status code: ${response.statusCode}');
          Get.offNamed(Path.BIOGRAFI_PAGE);
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
