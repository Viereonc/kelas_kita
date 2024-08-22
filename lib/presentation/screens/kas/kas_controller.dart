import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kelas_kita/presentation/screens/kas/metode_pembayaran.dart';
import 'package:midtrans_sdk/midtrans_sdk.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as dot_env;
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants.dart';
import '../../../data/models/tagihan_kas.dart';

class KasController extends GetxController {
  RxList<InfoTagihanKasModel> tagihanKasList = <InfoTagihanKasModel>[].obs;
  late final MidtransSDK? midtrans;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadLoading();
    fetchTagihanKas();
    _initSdk();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    midtrans?.removeTransactionFinishedCallback();
    super.dispose();
  }

  void _initSdk() async {
    midtrans = await MidtransSDK.init(
        config: MidtransConfig(
            clientKey: dot_env.dotenv.env['MIDTRANS_CLIENT_KEY'] ?? "",
            merchantBaseUrl: "",
          colorTheme: ColorTheme(
            colorPrimary: Colors.blue,
            colorPrimaryDark: Colors.blue,
            colorSecondary: Colors.blue
          ),
        ),
    );
    midtrans?.setUIKitCustomSetting(
      skipCustomerDetailsPages: true,
    );
    midtrans!.setTransactionFinishedCallback((result) {
      showToast("Transaction completed", false);
    });
  }

  void showToast(String message, bool isError) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: isError ? Colors.red : Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void loadLoading() async {
    await Future.delayed(Duration(seconds: 3));
    isLoading.value = false;
  }

  void openIconButtonpressed (BuildContext context) {
    showModalBottomSheet(context: context, builder: (ctx) => MetodePembayaran());
  }

  Future<void> fetchTagihanKas() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      int? userId = prefs.getInt('id_user');

      String? biodataIdString = prefs.getString('id_biodata');
      int? biodataId = biodataIdString != null ? int.tryParse(biodataIdString) : null;

      print('biodataId: $biodataId');
      if (userId != null) {
        final url = Uri.parse('$baseUrl$tagihanKasUserEndPoint$biodataId');
        print('Requesting URL: $url');

        final response = await http.get(
          url,
          headers: <String, String>{
            'Authorization': 'Bearer $token',
          },
        );

        if (response.statusCode == 200) {
          var jsonResponse = json.decode(response.body) as List<dynamic>;
          print('JSON Response: $jsonResponse');

          jsonResponse.forEach((data) {
            print('Item from response: $data');
            print('Nominal type: ${data['nominal'].runtimeType}');
          });

          var fetchedData = jsonResponse.map((data) => InfoTagihanKasModel.fromJson(data)).toList();
          tagihanKasList.value = fetchedData;

          print('Successfully loaded tagihan kas data: ${tagihanKasList.length}');
        } else {
          print('Failed to load tagihan kas, status code: ${response.statusCode}');
          throw Exception('Failed to load tagihan kas');
        }
      } else {
        print('biodataId is null or User ID is null. Unable to fetch tagihan kas.');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error E: $e');
    }
  }
}
