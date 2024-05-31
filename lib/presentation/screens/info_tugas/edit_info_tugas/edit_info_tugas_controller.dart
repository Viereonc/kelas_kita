import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kelas_kita/presentation/screens/info_tugas/info_tugas_controller.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../data/models/info_tugas.dart';

class EditInfoTugasController extends GetxController {
  final TextEditingController namaTugasController = TextEditingController();
  final TextEditingController deadlineTugasController = TextEditingController();
  final TextEditingController ketentuanTugasController = TextEditingController();

  final InfoTugasController infoKelasController = Get.find();
  final ValueNotifier<String?> selectedGuru = ValueNotifier<String?>(null);
  final List<String> guruList = ["Pak Aji", "Pak Dwi", "Pak Fahmi", "Pak Agus"];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initializeDateFormatting('id_ID', null);
  }

  void initializeValues(String namaTugas, String guruPemberiTugas, String deadlineTugas, String ketentuanTugas) {
    namaTugasController.text = namaTugas;
    selectedGuru.value = guruPemberiTugas;
    deadlineTugasController.text = deadlineTugas;
    ketentuanTugasController.text = ketentuanTugas;
  }

  Future<void> saveInfo(int index, BuildContext context) async {
    if (namaTugasController.text.isNotEmpty &&
        deadlineTugasController.text.isNotEmpty &&
        selectedGuru.value != null) {

      // Get the idKelas and kelas from the infoTugasList using the index
      InfoTugasModel currentInfo = infoKelasController.infoTugasList[index];
      String idKelas = currentInfo.idKelas.toString();
      Kelas kelas = currentInfo.kelas;

      // Assuming token is retrieved and passed appropriately
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      infoKelasController.editInfoTugas(
        index,
        namaTugasController.text,
        selectedGuru.value!,
        deadlineTugasController.text,
        ketentuanTugasController.text,
        idKelas,
        kelas,
        token!,
      );
      Navigator.pop(context);
    } else {
      // Handle empty fields case
      Get.snackbar("Error", "All fields must be filled", snackPosition: SnackPosition.BOTTOM);
    }
  }


}