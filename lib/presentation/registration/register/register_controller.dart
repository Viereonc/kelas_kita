import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kelas_kita/constants.dart';
import 'package:kelas_kita/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nomorTeleponController = TextEditingController();

  Future<void> registerUser(String username, String email, String password, String nomorHandphone) async {
    var url = Uri.parse(baseUrl + registerEndpoint);
    var headers = {
      'Content-Type': 'application/json',
    };

    int parsedNomorHandphone;
    try {
      parsedNomorHandphone = int.parse(nomorHandphone);
    } catch (e) {
      print('Invalid phone number: $e');
      return;
    }

    var body = jsonEncode({
      'username': username,
      'email': email,
      'password': password,
      'nomor': parsedNomorHandphone.toString(),
    });

    try {
      var response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 201) {
        // Registrasi berhasil
        print('Registrasi berhasil');
        print(response.body);
        Get.toNamed(Path.LOGIN_PAGE);

        // Check if the response is the success message
        if (response.body == '"Registrasi Berhasil"') {
          // Success handling logic
          // You might not need to do anything here, as the registration is already successful
          // If needed, you can add further logic here
        } else {
          // Handle unexpected response content
          print('Unexpected response content: ${response.body}');
          // Handle the error accordingly, e.g., show an error message to the user
        }
      } else {
        // Registrasi gagal
        print('Registrasi gagal');
        print(response.body);
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}