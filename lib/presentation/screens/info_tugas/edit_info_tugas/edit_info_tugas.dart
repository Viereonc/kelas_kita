import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as path;

import '../../../../constants.dart';
import '../../../../data/models/info_tugas.dart';
import '../../../themes/Colors.dart';
import '../../../themes/FontsStyle.dart';
import '../../../widgets/Button.dart';
import '../info_tugas_controller.dart';

class EditInfoTugasScreen extends StatelessWidget {
  final int index;
  final String namaTugas;
  final String guruPemberiTugas;
  final String deadlineTugas;
  final String ketentuanTugas;
  final String file;
  final int idTugas;

  EditInfoTugasScreen({Key? key, required this.index, required this.namaTugas, required this.guruPemberiTugas, required this.deadlineTugas, required this.ketentuanTugas, required this.file, required this.idTugas}) : super(key: key);

  final InfoTugasController editInfoTugasController = Get.put(InfoTugasController());

  Widget fileTypeWidget(String filePath) {
    final extension = path.extension(filePath).toLowerCase();

    if (extension == '.pdf') {
      return Icon(Icons.picture_as_pdf, size: 80, color: Colors.red);
    } else if (extension == '.doc' || extension == '.docx') {
      return Icon(Icons.description, size: 80, color: Colors.blue);
    } else if (extension == '.xls' || extension == '.xlsx') {
      return Icon(Icons.table_chart, size: 80, color: Colors.green);
    } else if (extension == '.ppt' || extension == '.pptx') {
      return Icon(Icons.slideshow, size: 80, color: Colors.orange);
    } else if (['.jpg', '.jpeg', '.png'].contains(extension)) {
      return Image.file(
        File(filePath),
        fit: BoxFit.cover,
      );
    } else {
      return Icon(Icons.insert_drive_file, size: 80, color: Colors.grey);
    }
  }

  @override
  Widget build(BuildContext context) {
    editInfoTugasController.initializeValues(namaTugas, guruPemberiTugas, deadlineTugas, ketentuanTugas, file);

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
                  "Edit Info Tugas",
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
                        controller: editInfoTugasController.namaTugasController,
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
                        valueListenable: editInfoTugasController.selectedGuru,
                        builder: (context, value, child) {
                          return DropdownButtonFormField<String>(
                            value: value,
                            dropdownColor: Colors.white,
                            items: editInfoTugasController.guruList.map((guru) {
                              return DropdownMenuItem<String>(
                                value: guru,
                                child: Text(guru),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              editInfoTugasController.selectedGuru.value = newValue;
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
                        controller: editInfoTugasController.deadlineTugasController,
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
                            editInfoTugasController.deadlineTugasController.text = formattedDate;
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
                      margin: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                      child: TextField(
                        controller: editInfoTugasController.ketentuanTugasController,
                        decoration: InputDecoration(
                          hintText: "Ketentuan Tugas",
                          hintStyle: tsParagraft4(screenSize: screenWidth).copyWith(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
                        ),
                        style: tsParagraft4(screenSize: screenWidth),
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
                      "Edit File",
                      style: tsSubHeader4(screenSize: screenWidth, fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () => editInfoTugasController.getImageFromGallery(),
                      child: Obx(() {
                        var selectedFile = editInfoTugasController.selectedFilePath.value;
                        var fileUrl = editInfoTugasController.fileUrl.value ?? '';
                        var filePath = selectedFile?.path ?? (baseUrl + storage + fileUrl);

                        bool isImage = selectedFile != null && ['.jpg', '.jpeg', '.png'].contains(path.extension(selectedFile.path).toLowerCase());
                        bool isDocument = selectedFile != null && ['.pdf', '.doc', '.docx', '.xls', '.xlsx'].contains(path.extension(selectedFile.path).toLowerCase());

                        return ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                            height: screenHeight * 0.2,
                            width: double.infinity,
                            color: Colors.grey.shade200,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Visibility(
                                  visible: fileUrl.isNotEmpty,
                                  child: selectedFile != null
                                      ? (isImage
                                      ? Image.file(
                                    File(selectedFile!.path),
                                    fit: BoxFit.cover,
                                  )
                                      : Center(
                                    child: fileTypeWidget(selectedFile!.path),
                                  ))
                                      : (filePath.endsWith('.jpg') || filePath.endsWith('.jpeg') || filePath.endsWith('.png') // Jika file dari URL bertipe image
                                      ? Image.network(
                                    filePath,
                                    fit: BoxFit.cover,
                                  )
                                      : Center(
                                    child: fileTypeWidget(filePath), // Jika file dari URL adalah dokumen
                                  )),
                                ),
                                if (selectedFile == null && fileUrl.isEmpty) // Jika tidak ada file yang dipilih atau URL
                                  Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.add,
                                          size: 40,
                                          color: Colors.grey,
                                        ),
                                        SizedBox(height: 10,),
                                        Text('Tambahkan File ataupun Gambar')
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: screenHeight * 0.03),
                child: Button(
                  label: "Edit Info Tugas",
                  textStyle: tsSubHeader4(screenSize: screenWidth),
                  textColor: Colors.white,
                  backgroundColor: primeryColorMedium,
                  side: BorderSide.none,
                  onPressed: () async {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    String? token = prefs.getString('token');

                    final infoTugasController = Get.find<InfoTugasController>();

                    if (infoTugasController.biografiList.isEmpty) {
                      await infoTugasController.fetchBiografi();
                    }

                    if (infoTugasController.biografiList.isNotEmpty) {
                      String idKelas = infoTugasController.biografiList[0].idKelas.toString();

                      if (token != null) {
                        await editInfoTugasController.editInfoTugas(
                          index,
                          editInfoTugasController.namaTugasController.text,
                          editInfoTugasController.selectedGuru.value!,
                          editInfoTugasController.deadlineTugasController.text,
                          editInfoTugasController.ketentuanTugasController.text,
                          editInfoTugasController.selectedFilePath.value,
                          idKelas,
                          token,
                          idTugas,
                        );
                        editInfoTugasController.fetchInformasiTugas();
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
