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
        final userId = jsonResponse['user']['id_user']; // Access user_id from the response

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', token); // Save bearer token to SharedPreferences
        prefs.setInt('user_id', userId); // Save user_id to SharedPreferences

        print('Login berhasil');
        Get.toNamed(Path.BIOGRAFI_PAGE);
      } else {
        print('Login gagal: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }


}
