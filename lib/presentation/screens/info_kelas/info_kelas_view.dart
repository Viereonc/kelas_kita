import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kelas_kita/constants.dart';
import 'package:kelas_kita/presentation/widgets/shimmer_loading/list_shimmer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import '../../themes/Colors.dart';
import '../../themes/FontsStyle.dart';
import 'add_info_kelas/add_info_kelas.dart';
import 'info_kelas_controller.dart';
import 'detail_info_kelas/detail_info_kelas.dart';

class InfoKelasScreen extends StatelessWidget {
  InfoKelasScreen({Key? key}) : super(key: key);

  final InfoKelasController infoKelasController = Get.put(InfoKelasController());

  Future<void> _refreshData(BuildContext context) async {
    return infoKelasController.fetchInformasiKelas();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            AppBar(
              surfaceTintColor: Colors.white,
              backgroundColor: Colors.white,
              title: Text(
                "Info Kelas",
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
            Divider(
              color: Colors.grey,
              thickness: 0.5,
            ),
            Expanded(
              child: Obx(() {
                if (infoKelasController.isLoading.value) {
                  return buildShimmer();
                } else {
                  final reversedList = infoKelasController.infoKelasList.reversed.toList();
                  return RefreshIndicator(
                    onRefresh: () => _refreshData(context),
                    child: ListView.separated(
                      itemCount: reversedList.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider(
                          color: Colors.grey,
                          thickness: 0.5,
                        );
                      },
                      itemBuilder: (BuildContext context, int index) {
                        final infoKelas = reversedList[index];

                        DateTime createdAt = DateTime.parse(infoKelas.createdAt.toString()).toLocal();
                        DateTime? updatedAt = infoKelas.updatedAt != null ? DateTime.parse(infoKelas.updatedAt.toString()).toLocal() : null;

                        String formattedDate = DateFormat('yyyy MMMM dd, EEEE, HH:mm', 'id_ID').format(createdAt);

                        if (updatedAt != null && updatedAt.isAfter(createdAt)) {
                          formattedDate = DateFormat('yyyy MMMM dd, EEEE, HH:mm', 'id_ID').format(updatedAt) + " (telah diedit)";
                        }

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailInfoKelas(
                                  description: infoKelas.pengumuman,
                                  image: infoKelas.image,
                                ),
                              ),
                            );
                          },
                          onLongPress: infoKelasController.userStatus.value == 'Sekretaris' || infoKelasController.userStatus.value == 'Wali Kelas'
                              ? () {
                            final description = infoKelas.pengumuman;
                            final imagePath = infoKelas.image;
                            final idInfomasiKelas = infoKelas.idInformasiKelas;
                            infoKelasController.openIconButtonpressed(context, index, description, imagePath, idInfomasiKelas);
                          } : null,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01, vertical: screenHeight * 0.015),
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 1),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                              ),
                              height: screenHeight * 0.2,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: screenHeight * 0.17,
                                    width: double.infinity,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "PENGUMUMAN",
                                                    style: tsSubHeader4(screenSize: screenWidth, fontWeight: FontWeight.w700).copyWith(color: primeryColorMedium),
                                                  ),
                                                  SizedBox(height: 10,),
                                                  Text(
                                                    infoKelas.pengumuman,
                                                    maxLines: 2,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: tsSubHeader4(screenSize: screenWidth),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                width: screenWidth * 0.55,
                                                child: Text(
                                                  formattedDate,
                                                  maxLines: 2,
                                                  style: tsParagraft4(screenSize: screenWidth, fontWeight: FontWeight.w500).copyWith(color: Colors.grey),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 50),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(5),
                                            child: Image.network(
                                              baseUrl + storage + infoKelas.image,
                                              width: screenWidth * 0.45,
                                              height: screenHeight * 0.15,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
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
                    ),
                  );
                }
              }),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Obx(() {
        if (infoKelasController.userStatus.value == 'Sekretaris' || infoKelasController.userStatus.value == 'Wali Kelas') {
          return FloatingActionButton(
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              String? token = prefs.getString('token');
              String idKelas = "1";
              if (token != null) {
                infoKelasController.isLoading.value = true;
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddInfoKelas()),
                );
                if (result != null) {
                  infoKelasController.addAndPostInfoKelas(
                    File(result["image"]),
                    result["description"],
                    idKelas,
                    token,
                  ).then((_) {
                    infoKelasController.isLoading.value = false;
                  });
                }
              } else {
                print('Token not found');
              }
            },
            shape: CircleBorder(),
            backgroundColor: primeryColorMedium,
            child: Icon(Icons.add, color: Colors.white, size: 34),
          );
        } else {
          return SizedBox.shrink();
        }
      }),
    );
  }
}
