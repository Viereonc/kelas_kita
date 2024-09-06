import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:kelas_kita/presentation/screens/info_tugas/info_tugas_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:file_picker/file_picker.dart';

import '../../../../data/models/info_tugas.dart';
import '../../../themes/Colors.dart';
import '../../../themes/FontsStyle.dart';
import '../../../widgets/Button.dart';

class AddInfoTugas extends StatelessWidget {
  AddInfoTugas({Key? key}) : super(key: key);

  final TextEditingController namaTugasController = TextEditingController();
  final TextEditingController deadlineTugasController = TextEditingController();
  final TextEditingController ketentuanTugasController = TextEditingController();

  final InfoTugasController infoTugasController = Get.find();

  final ValueNotifier<String?> selectedGuru = ValueNotifier<String?>(null);
  final List<String> guruList = ["Pak Aji", "Pak Dwi", "Pak Fahmi", "Pak Agus"];

  Future<void> _getImageFromGallery() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf', 'doc', 'docx', 'xls', 'xlsx'],
    );

    if (result != null) {
      infoTugasController.selectedFilePath.value = File(result.files.single.path!);
    } else {
      Get.snackbar(
        'Error',
        'Tidak ada file yang dipilih',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              AppBar(
                backgroundColor: Colors.white,
                surfaceTintColor: Colors.white,
                title: Text(
                  "Tambah Info Tugas",
                  style: tsHeader2(screenSize: screenWidth),
                ),
                centerTitle: true,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Container(
                    decoration: BoxDecoration(
                      color: primeryColorMedium,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Icon(Icons.arrow_back_ios_new, color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Divider(color: Colors.grey, thickness: 0.5),
              SizedBox(height: screenHeight * 0.025),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Nama Tugas",
                      style: tsSubHeader4(
                          screenSize: screenWidth,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      height: screenWidth * 0.12,
                      margin: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                      child: TextFormField(
                        controller: namaTugasController,
                        decoration: InputDecoration(
                          hintText: "Nama Tugas",
                          hintStyle: tsParagraft4(screenSize: screenWidth).copyWith(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Guru Pemberi Tugas",
                      style: tsSubHeader4(
                          screenSize: screenWidth,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                      padding: EdgeInsets.only(left: 15, right: 15),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black.withOpacity(0.4),
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: ValueListenableBuilder<String?>(
                        valueListenable: selectedGuru,
                        builder: (context, value, child) {
                          return DropdownButtonFormField<String>(
                            value: value,
                            dropdownColor: Colors.white,
                            items: guruList.map((guru) {
                              return DropdownMenuItem<String>(
                                value: guru,
                                child: Text(guru),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              selectedGuru.value = newValue;
                            },
                            decoration: InputDecoration(
                              hintText: "Pilih Guru Pemberi Tugas",
                              hintStyle: tsParagraft4(screenSize: screenWidth).copyWith(color: Colors.grey),
                              border: InputBorder.none,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Deadline Tugas",
                      style: tsSubHeader4(
                          screenSize: screenWidth,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      height: screenWidth * 0.12,
                      margin: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                      child: TextField(
                        controller: deadlineTugasController,
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: "Pilih Tanggal Deadline",
                          hintStyle: tsParagraft4(screenSize: screenWidth).copyWith(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
                        ),
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                            builder: (BuildContext context, Widget? child) {
                              return Theme(
                                data: ThemeData.light().copyWith(
                                  primaryColor: Colors.blue,
                                  hintColor: Colors.blue,
                                  buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
                                  datePickerTheme: DatePickerThemeData(
                                    surfaceTintColor: Colors.white,
                                    backgroundColor: Colors.white
                                  ),
                                ),
                                child: child!,
                              );
                            },
                          );
                          if (pickedDate != null) {
                            String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                            deadlineTugasController.text = formattedDate;
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Ketentuan Tugas",
                      style: tsSubHeader4(
                          screenSize: screenWidth,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      height: screenWidth * 0.12,
                      margin: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                      child: TextFormField(
                        controller: ketentuanTugasController,
                        decoration: InputDecoration(
                          hintText: "Ketentuan Tugas",
                          hintStyle: tsParagraft4(screenSize: screenWidth).copyWith(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tambahkan File",
                      style: tsSubHeader4(screenSize: screenWidth, fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: _getImageFromGallery,
                      child: Obx(() => Container(
                        margin: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                        height: screenHeight * 0.2,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: infoTugasController.selectedFilePath.value != null
                            ? (['jpg', 'jpeg', 'png'].contains(
                            infoTugasController.selectedFilePath.value!.path.split('.').last))
                            ? Image.file(
                          infoTugasController.selectedFilePath.value!,
                          fit: BoxFit.cover,
                          height: screenHeight * 0.15,
                        )
                            : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "File: ${infoTugasController.selectedFilePath.value!.path.split('/').last}",
                            style: TextStyle(color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                        )
                            : Center(
                          child: SvgPicture.asset("lib/assets/icons/pe_camera.svg"),
                        ),
                        width: double.infinity,
                      )),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: screenHeight * 0.03),
                child: Button(
                  label: "Unggah Tugas",
                  textStyle: tsSubHeader4(screenSize: screenWidth),
                  textColor: Colors.white,
                  backgroundColor: primeryColorMedium,
                  side: BorderSide.none,
                  onPressed: () async {
                    String? guruPemberiTugas = selectedGuru.value;
                    String deadlineTugas = deadlineTugasController.text;

                    if (guruPemberiTugas == null || deadlineTugas.isEmpty) {
                      Get.snackbar(
                        'Error',
                        'Mohon lengkapi semua kolom yang diperlukan',
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                      return;
                    }

                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    String? token = prefs.getString('token');

                    final infoTugasController = Get.find<InfoTugasController>();

                    if (infoTugasController.biografiList.isEmpty) {
                      await infoTugasController.fetchBiografi();
                    }

                    if (infoTugasController.biografiList.isNotEmpty) {
                      String idKelas = infoTugasController.biografiList[0].idKelas.toString();

                      if (token != null) {
                        await infoTugasController.addAndPostInfoTugas(
                          namaTugasController.text,
                          guruPemberiTugas,
                          deadlineTugas,
                          ketentuanTugasController.text,
                          infoTugasController.selectedFilePath.value,
                          idKelas,
                          token,
                        );
                        Navigator.pop(context);
                      } else {
                        print('Token not found');
                      }
                    } else {
                      print('Biografi list is still empty after fetching');
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
