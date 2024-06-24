import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kelas_kita/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> loginUser(String email, String password) async {
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

        if (userData['biodata'] != null) {
          final name = userData['biodata']['nama'];
          prefs.setString('nama', name);
          Get.offNamed(Path.HOME_PAGE);
        } else {
          Get.offNamed(Path.BIOGRAFI_PAGE);
        }

        prefs.setInt('id_user', userData['id_user']);
        prefs.setString('email', userData['email']);

        emailController.clear();
        passwordController.clear();

        print('Login berhasil');
        print('Bearer Token: $token');
      } else {
        print('Login gagal: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
