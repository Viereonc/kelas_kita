import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../constants.dart';
import '../../../data/models/biografi_model.dart';
import '../../../routes/app_routes.dart';
import '../../screens/home/home_view.dart';
import 'google_sign_in.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var isLoading = false.obs;

  Future<void> loginUser(String email, String password) async {
    isLoading.value = true;
    var url = Uri.parse(baseUrl + loginEndpoint);
    var headers = {
      'Content-Type': 'application/json',
    };
    var body = jsonEncode({
      'email': email,
      'password': password,
    });

    try {
      var response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final token = jsonResponse['token'];
        final userData = jsonResponse['user'];

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        prefs.setString('token', token);
        prefs.setInt('id_user', userData['id_user']);
        // prefs.setInt('id_biodata', userData['id_biodata']);
        prefs.setString('email', userData['email']);

        emailController.clear();
        passwordController.clear();

        print('Login berhasil');
        print('Bearer Token: $token');

        await fetchBiografi();

      } else {
        print('Login gagal: ${response.body}');
        Get.snackbar(
          "Login Gagal",
          "Email atau password salah",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoading.value = false;
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
          final name = fetchedData.alamat;
          final role = jsonResponse['role_name'];

          if (name != null && name.isNotEmpty) {
            if (role == 'Wali Kelas') {
              Get.offNamed(Path.HOMEGURU_PAGE);
            } else {
              Get.offNamed(Path.HOME_PAGE);
            }
          } else {
            Get.offNamed(Path.BIOGRAFI_PAGE);
          }

          int idKelas = jsonResponse['id_kelas'];
          int idBiodata = jsonResponse['id_biodata'];
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setInt('id_kelas', idKelas);
          await prefs.setInt('id_biodata', idBiodata);

          print('Successfully loaded biografi data');
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
      throw Exception('Error: $e');
    }
  }
}
