import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../constants.dart';
import '../../../data/models/biografi_model.dart';
import 'package:kelas_kita/routes/app_routes.dart';

class PendingController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    fetchBiografi();
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

          prefs.setString('status', biografiModel.status.toString());
          print('Successfully loaded biografi data with status: ${biografiModel.status}');

          if (biografiModel.status == 'A') {
            Get.offNamed(Path.HOME_PAGE);
          } else if (biografiModel.status == 'P') {
            Get.offNamed(Path.PENDING_PAGE);
          }
        } else {
          Get.offNamed(Path.BIOGRAFI_PAGE);
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
