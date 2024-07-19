import 'package:get/get.dart';
import 'package:kelas_kita/data/models/biografi_model.dart';
import 'package:kelas_kita/data/models/struktur_kelas_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../../constants.dart';
import '../../../../data/models/struktur_kelas_all.dart';

class StrukturKelasGuruController extends GetxController{
  RxList<StrukturKelasAllModel> infoStrukturKelasList = <StrukturKelasAllModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadLoading();
    fetchStrukturKelas();
  }

  void loadLoading() async {
    await Future.delayed(Duration(seconds: 3));
    isLoading.value = false;
  }

  void fetchStrukturKelas() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        throw Exception('Token is null');
      }

      final response = await http.get(
        Uri.parse(baseUrl + strukturKelasGuruEndpointGet),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        var fetchedData = strukturKelasAllModelFromJson(response.body);

        fetchedData.sort((a, b) => a.nama.compareTo(b.nama));
        for (int i = 0; i < fetchedData.length; i++) {
          fetchedData[i].absen = i + 1;
        }

        infoStrukturKelasList.value = fetchedData;
        print('Data fetched successfully: ${infoStrukturKelasList.length} items');
      } else {
        print('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    } finally {
      isLoading.value = false;
    }
  }

}
