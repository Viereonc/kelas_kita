import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:kelas_kita/presentation/screens/info_tugas/edit_info_tugas/edit_info_tugas_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  final int idTugas;

  EditInfoTugasScreen({Key? key, required this.index, required this.namaTugas, required this.guruPemberiTugas, required this.deadlineTugas, required this.ketentuanTugas, required this.idTugas}) : super(key: key);

  final EditInfoTugasController editInfoTugasController = Get.put(EditInfoTugasController());

  @override
  Widget build(BuildContext context) {
    editInfoTugasController.initializeValues(namaTugas, guruPemberiTugas, deadlineTugas, ketentuanTugas);

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
                          idKelas,
                          token,
                          idTugas,
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
