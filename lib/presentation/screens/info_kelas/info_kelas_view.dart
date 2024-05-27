import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../themes/Colors.dart';
import '../../themes/FontsStyle.dart';
import 'add_info_kelas/add_info_kelas.dart';
import 'info_kelas_controller.dart';
import 'detail_info_kelas/detail_info_kelas.dart';
import 'package:timeago/timeago.dart' as timeago;


class InfoKelasScreen extends StatelessWidget {
  InfoKelasScreen({Key? key}) : super(key: key);

  final InfoKelasController infoKelasController = Get.put(InfoKelasController());

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            Container(
              child: AppBar(
                surfaceTintColor: Colors.white,
                title: Text(
                  "Info Kelas",
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
                if (infoKelasController.isLoading.value) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView.separated(
                    itemCount: infoKelasController.infoKelasList.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider(
                        color: Colors.grey,
                        thickness: 0.5,
                      );
                    },
                    itemBuilder: (BuildContext context, int index) {
                      final infoKelas = infoKelasController.infoKelasList[index];

                      DateTime itemTime = DateTime.now();
                      if (infoKelas.containsKey("time") && infoKelas["time"] != null) {
                        itemTime = DateTime.parse(infoKelas["time"]);
                      }

                      final timeAgo = '${itemTime.year}-${itemTime.month}-${itemTime.day} ${itemTime.hour}:${itemTime.minute}';

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailInfoKelas(
                                description: infoKelas["description"],
                                image: infoKelas["image"],
                              ),
                            ),
                          );
                        },
                        onLongPress: () {
                          final infoKelas = infoKelasController.infoKelasList[index];
                          final description = infoKelas["description"];
                          final imagePath = infoKelas["image"];
                          infoKelasController.openIconButtonpressed(context, index, description, imagePath);
                        },

                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01, vertical: screenHeight * 0.015),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                            ),
                            height: screenHeight * 0.25,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "PENGUMUMAN",
                                  style: tsHeader3(screenSize: screenWidth).copyWith(color: primeryColorMedium),
                                ),
                                Container(
                                  height: screenHeight * 0.17,
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible( // Menggunakan Flexible untuk memberikan ruang yang cukup untuk deskripsi
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              infoKelas["description"],
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: tsHeader3(screenSize: screenWidth),
                                            ),
                                            Container(
                                              width: screenWidth * 0.55,
                                              child: Text(
                                                timeAgo,
                                                maxLines: 2,
                                                style: tsParagraft4(screenSize: screenWidth, fontWeight: FontWeight.w500).copyWith(color: Colors.grey),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      if (infoKelas["image"] != null && infoKelas["image"].isNotEmpty)
                                        Container(
                                          margin: EdgeInsets.only(left: 50),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(5),
                                            child: Image.file(
                                              File(infoKelas["image"]),
                                              width: screenWidth * 0.45,
                                              height: screenHeight * 0.15,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        )
                                      else
                                        SizedBox(
                                          width: screenWidth * 0.45,
                                          height: screenHeight * 0.15,
                                        )
                                    ],
                                  ),
                                ),
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
      floatingActionButton: Container(
        child: FloatingActionButton(
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddInfoKelas()),
            );

            if (result != null) {
              infoKelasController.addInfoKelas(File(result["image"]), result["description"]);

            }
          },
          shape: CircleBorder(),
          backgroundColor: primeryColorMedium,
          child: Icon(Icons.add, color: Colors.white, size: 34),
        ),
      ),
    );
  }
}
