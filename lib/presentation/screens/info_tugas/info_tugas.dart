import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:kelas_kita/presentation/screens/info_tugas/add_info_tugas/add_info_tugas.dart';
import 'package:kelas_kita/presentation/screens/info_tugas/detail_info_tugas/detail_info_tugas.dart';
import 'package:kelas_kita/presentation/screens/info_tugas/info_tugas_controller.dart';

import '../../themes/Colors.dart';
import '../../themes/FontsStyle.dart';

class InfoTugasScreen extends StatelessWidget {
  InfoTugasScreen({Key? key}) : super(key: key);

  final InfoTugasController infoTugasController = Get.put(InfoTugasController());

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
              child: Obx(() {
                if (infoTugasController.isLoading.value) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView.separated(
                    itemCount: infoTugasController.infoTugasList.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider(
                        color: Colors.grey,
                        thickness: 0.5,
                      );
                    },
                    itemBuilder: (BuildContext context, int index) {
                      final infoTugas = infoTugasController.infoTugasList[index];

                      return GestureDetector(
                        // onTap: () {
                        //   Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => DetailInfoTugas(
                        //         namaTugas: infoTugas["namaTugas"],
                        //         ketentuanTugas: infoTugas["ketentuanTugas"],
                        //       ),
                        //     ),
                        //   );
                        // },
                        onLongPress: () {
                          final infoTugas = infoTugasController.infoTugasList[index];
                          final namaTugas = infoTugas["namaTugas"];
                          final guruPemberiTugas = infoTugas["guruPemberiTugas"];
                          final deadlineTugas = infoTugas["deadlineTugas"];
                          final ketentuanTugas = infoTugas["ketentuanTugas"];
                          infoTugasController.openIconButtonpressed(context, index, namaTugas, guruPemberiTugas, deadlineTugas, ketentuanTugas);
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
                                        infoTugas["namaTugas"],
                                        style: tsSubHeader3(screenSize: screenWidth),
                                      ),
                                      Text(
                                        "Ketentuan : " + infoTugas["ketentuanTugas"],
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: tsParagraft4(screenSize: screenWidth),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Guru : " + infoTugas["guruPemberiTugas"],
                                            style: tsParagraft4(screenSize: screenWidth),
                                          ),
                                          Row(
                                            children: [
                                              Icon(Icons.calendar_month, color: Colors.red,),
                                              SizedBox(width: screenWidth * 0.02,),
                                              Text(infoTugas["deadlineTugas"],
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
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Obx(() {
        if (infoTugasController.userStatus.value == 'sekretaris') {
          return FloatingActionButton(
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddInfoTugas()),
              );
              if (result != null) {
                infoTugasController.addInfoTugas(result["namaTugas"], result["guruPemberiTugas"], result["deadlineTugas"], result["ketentuanTugas"]);
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
