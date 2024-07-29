import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';
import 'package:kelas_kita/presentation/screens/info_tugas/add_info_tugas/add_info_tugas.dart';
import 'package:kelas_kita/presentation/screens/info_tugas/info_tugas_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:kelas_kita/data/models/info_tugas.dart';
import '../../themes/Colors.dart';
import '../../themes/FontsStyle.dart';

class InfoTugasScreen extends StatelessWidget {
  InfoTugasScreen({Key? key}) : super(key: key);

  final InfoTugasController infoTugasController = Get.put(InfoTugasController());

  String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd'); // Specify your desired format
    return formatter.format(date);
  }

  Future<void> _refreshData(BuildContext context) async {
    return infoTugasController.fetchInformasiTugas();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            Container(
              child: AppBar(
                backgroundColor: Colors.white,
                surfaceTintColor: Colors.white,
                title: Text(
                  "Info Tugas",
                  style: tsHeader2(screenSize: screenWidth),
                ),
                centerTitle: true,
                leading: Container(
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Container(
                      decoration: BoxDecoration(
                        color: primeryColorMedium,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Icon(Icons.arrow_back_ios_new,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            Divider(
              color: Colors.grey,
              thickness: 0.5,
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => _refreshData(context), // Trigger refresh action
                child: Obx(() {
                  if (infoTugasController.isLoading.value) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    final reversedList = infoTugasController.infoTugasList.reversed.toList();
                    return ListView.builder(
                      physics: AlwaysScrollableScrollPhysics(),
                      itemCount: reversedList.length,
                      itemBuilder: (BuildContext context, int index) {
                        final infoTugas = reversedList[index];

                        return GestureDetector(
                          onLongPress: () {
                            final namaTugas = infoTugas.nama;
                            final guruPemberiTugas = infoTugas.guru;
                            final deadlineTugas = infoTugas.deadline;
                            final ketentuanTugas = infoTugas.ketentuan;
                            final idTugas = infoTugas.idTugas;
                            infoTugasController.openIconButtonpressed(context, index, namaTugas, guruPemberiTugas, deadlineTugas.toString(), ketentuanTugas, idTugas);
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01, vertical: screenHeight * 0.015),
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.transparent,
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                              ),
                              height: screenHeight * 0.17,
                              child: Column(
                                children: [
                                  Container(
                                    height: screenHeight * 0.135,
                                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          infoTugas.nama,
                                          style: tsSubHeader3(screenSize: screenWidth),
                                        ),
                                        Text(
                                          "Ketentuan : " + infoTugas.ketentuan,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: tsParagraft4(screenSize: screenWidth),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Guru : " + infoTugas.guru,
                                              style: tsParagraft4(screenSize: screenWidth),
                                            ),
                                            Row(
                                              children: [
                                                Icon(Icons.calendar_month, color: Colors.red,),
                                                SizedBox(width: screenWidth * 0.02,),
                                                Text(formatDate(infoTugas.deadline),
                                                  style: tsParagraft4(screenSize: screenWidth),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                }),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Obx(() {
        if (infoTugasController.userStatus.value == 'sekretaris') {
          return FloatingActionButton(
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              String? token = prefs.getString('token');

              int idKelas = 2; // Ensure idKelas is an integer
              String nama = "11 PPLG 2"; // Define the name of the class or retrieve it appropriately
              DateTime? createdAt; // Initialize or set the createdAt date
              DateTime? updatedAt; // Initialize or set the updatedAt date

              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddInfoTugas()),
              );

              if (result != null) {
                infoTugasController.addAndPostInfoTugas(
                    result["namaTugas"],
                    result["guruPemberiTugas"],
                    result["deadlineTugas"],
                    result["ketentuanTugas"],
                    idKelas.toString(), // Convert idKelas back to string if necessary
                    token ?? "default_token_value" // Provide a default value if token is null
                );
              }
            },
            shape: CircleBorder(),
            backgroundColor: primeryColorMedium,
            child: Icon(Icons.add, color: Colors.white, size: 34),
          );

        } else {
          return SizedBox.shrink(); // Return an empty widget if the user is not a secretary
        }
      }),
    );
  }
}

