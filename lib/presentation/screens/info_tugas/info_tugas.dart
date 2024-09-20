import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';
import 'package:kelas_kita/presentation/screens/guru/home_guru/home_guru_view.dart';
import 'package:kelas_kita/presentation/screens/home/home_view.dart';
import 'package:kelas_kita/presentation/screens/info_tugas/add_info_tugas/add_info_tugas.dart';
import 'package:kelas_kita/presentation/screens/info_tugas/info_tugas_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as path;
import 'package:url_launcher/url_launcher.dart';

import 'package:kelas_kita/data/models/info_tugas.dart';
import '../../../constants.dart';
import '../../themes/Colors.dart';
import '../../themes/FontsStyle.dart';

class InfoTugasScreen extends StatelessWidget {
  InfoTugasScreen({Key? key}) : super(key: key);

  static const route = '/infotugasscreen';

  final InfoTugasController infoTugasController = Get.put(InfoTugasController());

  String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('d MMMM yyyy', 'id_ID'); // Specify your desired format
    return formatter.format(date);
  }

  Future<void> _refreshData(BuildContext context) async {
    return infoTugasController.fetchInformasiTugas();
  }

  Future<void> _openFile(String fileUrl) async {
    final urlFile = baseUrl + storage + fileUrl;
    print("Trying to open URL: $urlFile");

    final Uri uri = Uri.parse(urlFile);
    await launchUrl(uri, mode: LaunchMode.inAppBrowserView);
  }

  @override
  Widget build(BuildContext context) {
    final message = ModalRoute.of(context)?.settings.arguments as RemoteMessage?;

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
                      if (infoTugasController.userStatus.value == 'Wali Kelas' || infoTugasController.userStatus.value == 'Guru') {
                        Get.to(HomeScreenGuru());
                      } else {
                        Get.to(HomeScreen());
                      }
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
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            Divider(color: Colors.grey, thickness: 0.5),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => _refreshData(context),
                color: primeryColorMedium,
                backgroundColor: Colors.white,
                child: Obx(() {
                  if (infoTugasController.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    final reversedList = infoTugasController.infoTugasList.reversed.toList();
                    IconData getFileIcon(String? file) {
                      if (file == null || file.isEmpty) return Icons.insert_drive_file; // Default icon

                      String extension = path.extension(file).toLowerCase(); // Get the file extension

                      switch (extension) {
                        case '.jpg':
                        case '.jpeg':
                        case '.png':
                        case '.gif':
                          return Icons.image;
                        case '.pdf':
                          return Icons.picture_as_pdf;
                        case '.doc':
                        case '.docx':
                          return Icons.description; // Word document icon
                        case '.xls':
                        case '.xlsx':
                          return Icons.table_chart; // Excel icon
                        case '.ppt':
                        case '.pptx':
                          return Icons.slideshow; // PowerPoint icon
                        default:
                          return Icons.insert_drive_file; // Default icon for other file types
                      }
                    }
                    return ListView.builder(
                      physics: AlwaysScrollableScrollPhysics(),
                      itemCount: reversedList.length,
                      itemBuilder: (BuildContext context, int index) {
                        final infoTugas = reversedList[index];
                        final fileUrl = infoTugas.file ?? '';
                        final isFileAvailable = fileUrl.isNotEmpty;

                        return GestureDetector(
                          onLongPress: infoTugasController.userStatus.value == 'Sekretaris' || infoTugasController.userStatus.value == 'Wali Kelas' ? () {
                            final namaTugas = infoTugas.nama;
                            final guruPemberiTugas = infoTugas.guru;
                            final deadlineTugas = infoTugas.deadline;
                            final ketentuanTugas = infoTugas.ketentuan;
                            final file = infoTugas.file ?? '';
                            final idTugas = infoTugas.idTugas;
                            infoTugasController.openIconButtonpressed(context, index, namaTugas, guruPemberiTugas, deadlineTugas.toString(), ketentuanTugas, file, idTugas);
                          } : null,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01, vertical: screenHeight * 0.015),
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.transparent,
                                border: Border.all(color: Colors.black, width: 1.0),
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
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              infoTugas.nama,
                                              style: tsSubHeader3(screenSize: screenWidth, fontWeight: FontWeight.w600),
                                            ),
                                            if (isFileAvailable)
                                              Row(
                                                children: [
                                                  IconButton(
                                                    icon: Icon(Icons.open_in_new, color: Colors.grey),
                                                    onPressed: () async {
                                                      await _openFile(fileUrl);
                                                    },
                                                  ),
                                                  if (infoTugas.file != null && infoTugas.file!.isNotEmpty)
                                                    Icon(
                                                      getFileIcon(baseUrl + storage + infoTugas.file!),
                                                      color: Colors.blue,
                                                    ),
                                                ],
                                              )
                                            else SizedBox(width: 30),
                                          ],
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
        if (infoTugasController.userStatus.value == 'Sekretaris'|| infoTugasController.userStatus.value == 'Wali Kelas') {
          return FloatingActionButton(
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              String? token = prefs.getString('token');

              String idKelas = '1';

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
                    result["file"],
                    idKelas.toString(),
                    token!
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

