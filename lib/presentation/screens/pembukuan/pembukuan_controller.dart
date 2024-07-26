import 'package:get/get.dart';
import 'package:kelas_kita/data/models/program_kas_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../constants.dart';

class PembukuanKasController extends GetxController {
  RxList<ProgramKelasModel> programKelasList = <ProgramKelasModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadLoading();
    fetchProgramKasKelas();
  }

  void loadLoading() async {
    await Future.delayed(Duration(seconds: 3));
    isLoading.value = false;
  }

  void fetchProgramKasKelas() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      int? idKelas = prefs.getInt('id_kelas');

      if (idKelas != null) {
        final response = await http.get(
          Uri.parse(baseUrl + programKasKelasEndPoint + '$idKelas'),
          headers: {
            'Authorization': 'Bearer $token',
          },
        );

        if (response.statusCode == 200) {
          var fetchedData = programKelasModelFromJson(response.body);

          programKelasList.value = fetchedData;
          print('Data fetched successfully: ${programKelasList.length} items');
        } else {
          print('Failed to fetch data: ${response.statusCode}');
        }
      } else {
        print('id_kelas is null');
      }
    } catch (e) {
      print('Error fetching data: $e');
    } finally {
      isLoading.value = false;
    }
  }
}