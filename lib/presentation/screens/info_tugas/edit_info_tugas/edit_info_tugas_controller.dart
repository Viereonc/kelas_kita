import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kelas_kita/presentation/screens/info_tugas/info_tugas_controller.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../../constants.dart';
import '../../../../data/models/info_tugas.dart';

class EditInfoTugasController extends GetxController {
  final TextEditingController namaTugasController = TextEditingController();
  final TextEditingController deadlineTugasController = TextEditingController();
  final TextEditingController ketentuanTugasController = TextEditingController();
  var isLoading = true.obs;

  final ValueNotifier<String?> selectedGuru = ValueNotifier<String?>(null);
  final List<String> guruList = ["Pak Aji", "Pak Dwi", "Pak Fahmi", "Pak Agus"];

  RxList<InfoTugasModel> infoTugasList = <InfoTugasModel>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchInformasiTugas();
    initializeDateFormatting('id_ID', null);
  }

  void fetchInformasiTugas() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      final response = await http.get(
        Uri.parse(baseUrl + infoGetTugasEndPoint),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        infoTugasList.value = infoTugasModelFromJson(response.body);
        isLoading.value = false;
      } else {
        print('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  void initializeValues(String namaTugas, String guruPemberiTugas, String deadlineTugas, String ketentuanTugas) {
    namaTugasController.text = namaTugas;
    selectedGuru.value = guruPemberiTugas;
    deadlineTugasController.text = deadlineTugas;
    ketentuanTugasController.text = ketentuanTugas;
  }

  Future<void> editInfoTugas(int index, String namaTugas, String guruPemberiTugas, String deadlineTugas, String ketentuanTugas, String idKelas, Kelas kelas, String token, int idTugas) async {
    final DateTime currentTime = DateTime.now();

    int parsedIdKelas = int.parse(idKelas);

    DateTime parsedDeadline = DateTime.parse(deadlineTugas);

    InfoTugasModel updatedInfoTugas = InfoTugasModel(
        idTugas: idTugas,
        idKelas: parsedIdKelas,
        nama: namaTugas,
        guru: guruPemberiTugas,
        deadline: parsedDeadline,
        ketentuan: ketentuanTugas,
        createdAt: currentTime,
        updatedAt: currentTime,
        kelas: kelas
    );

    var url = Uri.parse('${baseUrl}api/tugas/${idTugas}');
    var headers = {
      'Authorization': 'Bearer $token',
    };
    var request = http.MultipartRequest('POST', url)
      ..headers.addAll(headers)
      ..fields['id_tugas'] = updatedInfoTugas.idTugas.toString()
      ..fields['id_kelas'] = idKelas
      ..fields['nama'] = namaTugas
      ..fields['guru'] = guruPemberiTugas
      ..fields['deadline'] = deadlineTugas
      ..fields['ketentuan'] = ketentuanTugas;

    try {
      var response = await request.send();
      fetchInformasiTugas();
      if (response.statusCode == 200) {
        print('Info kelas berhasil diedit: ${response.statusCode}');
        fetchInformasiTugas();
      } else {
        print('Gagal mengedit info kelas: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}