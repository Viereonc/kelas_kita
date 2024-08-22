import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kelas_kita/presentation/screens/guru/struktur_kelas_guru/struktur_kelas_controller.dart';
import 'package:kelas_kita/presentation/themes/Backdrop.dart';
import 'package:kelas_kita/presentation/themes/Colors.dart';
import 'package:kelas_kita/presentation/themes/FontsStyle.dart';

import '../../../../data/models/struktur_kelas_all.dart';

class StrukturKelasGuruScreen extends StatelessWidget {
  StrukturKelasGuruScreen({Key? key}) : super(key: key);

  final StrukturKelasGuruController strukturKelasGuruController = Get.put(StrukturKelasGuruController());

  // List of colors to use for the icons
  final List<Color> iconColors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.orange,
    Colors.purple,
    Colors.teal,
    Colors.cyan,
    Colors.pink,
    Colors.amber,
    Colors.indigo,
  ];

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            title: Text(
              "Struktur Kelas",
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
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                    size: screenWidth * 0.05,
                  ),
                ),
              ),
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(4.0),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                color: Colors.grey,
                height: 1.5,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: screenHeight * 0.04),
          ),
          Obx(() {
            if (strukturKelasGuruController.isLoading.value) {
              return SliverToBoxAdapter(
                child: Center(child: CircularProgressIndicator()),
              );
            } else {
              var sortedList = strukturKelasGuruController.infoStrukturKelasList
                ..sort((a, b) {
                  if (a.role?.nama == 'Wali Kelas' && b.role?.nama != 'Wali Kelas') {
                    return -1;
                  } else if (a.role?.nama != 'Wali Kelas' && b.role?.nama == 'Wali Kelas') {
                    return 1;
                  } else {
                    return a.nama.compareTo(b.nama);
                  }
                });

              // Group students by their class ID
              var groupedStudents = {};
              for (var student in sortedList) {
                if (groupedStudents[student.idKelas] == null) {
                  groupedStudents[student.idKelas] = [];
                }
                groupedStudents[student.idKelas].add(student);
              }

              // Filter out classes without students
              var filteredKelasList = strukturKelasGuruController.kelasList.where((kelas) {
                return groupedStudents[kelas.idKelas] != null && groupedStudents[kelas.idKelas]!.isNotEmpty;
              }).toList();

              return SliverList(
                delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    final kelas = filteredKelasList[index];
                    final students = groupedStudents[kelas.idKelas] ?? [];

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01, horizontal: screenWidth * 0.05),
                          child: Text(
                            kelas.nama,
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                          child: Divider(
                            color: Colors.grey,
                            thickness: 1,
                          ),
                        ),
                        ...students.map((strukturKelas) {
                          bool isWaliKelas = strukturKelas.role.nama == 'Wali Kelas';

                          return Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.02,
                              horizontal: screenWidth * 0.05,
                            ),
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [primaryBackDrop(opacity: 0.1)],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ListTile(
                                    contentPadding: EdgeInsets.only(left: screenWidth * 0.05),
                                    title: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          strukturKelas.nama,
                                          style: tsSubHeader4(
                                            fontWeight: FontWeight.bold,
                                            screenSize: screenWidth,
                                          ),
                                          maxLines: 2,
                                        ),
                                        SizedBox(height: screenHeight * 0.008),
                                        Text(
                                          strukturKelas.role.nama,
                                          style: tsParagraft5(
                                            fontWeight: FontWeight.w500,
                                            screenSize: screenWidth * 1.3,
                                          ).copyWith(color: Colors.grey.withOpacity(0.9)),
                                        ),
                                      ],
                                    ),
                                    leading: Container(
                                      width: screenWidth * 0.12,
                                      height: screenWidth * 0.12,
                                      decoration: BoxDecoration(
                                        color: iconColors[index % iconColors.length],
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.person,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                      horizontal: screenWidth * 0.05,
                                      vertical: screenHeight * 0.005,
                                    ),
                                    child: Divider(
                                      color: Colors.grey,
                                      thickness: 0.5,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Absen',
                                              style: tsSubHeader4(
                                                fontWeight: FontWeight.bold,
                                                screenSize: screenWidth,
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(top: screenHeight * 0.01),
                                              child: Text(
                                                isWaliKelas ? '-' : strukturKelas.absen.toString(),
                                                style: tsParagraft5(
                                                  screenSize: screenWidth * 1.3,
                                                ).copyWith(color: primeryColorMedium),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Alamat',
                                              style: tsSubHeader4(
                                                fontWeight: FontWeight.bold,
                                                screenSize: screenWidth,
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(top: screenHeight * 0.01),
                                              child: Text(
                                                strukturKelas.alamat,
                                                style: tsParagraft5(
                                                  screenSize: screenWidth * 1.3,
                                                ).copyWith(color: Color(0xFFFFA800)),
                                              ),
                                            ),
                                          ],
                                        ),
                                        if (!isWaliKelas)
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'NIS',
                                                style: tsSubHeader4(
                                                  fontWeight: FontWeight.bold,
                                                  screenSize: screenWidth,
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(top: screenHeight * 0.01),
                                                child: Text(
                                                  strukturKelas.nis.toString(),
                                                  style: tsParagraft5(
                                                    screenSize: screenWidth * 1.3,
                                                  ).copyWith(color: secondaryColorDark),
                                                ),
                                              ),
                                            ],
                                          ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'No Telepon',
                                              style: tsSubHeader4(
                                                fontWeight: FontWeight.bold,
                                                screenSize: screenWidth,
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(top: screenHeight * 0.01),
                                              child: Text(
                                                '0${strukturKelas.user.nomor.toString()}',
                                                style: tsParagraft5(
                                                  screenSize: screenWidth * 1.3,
                                                ).copyWith(color: Color(0xFF473CC6)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ],
                    );
                  },
                  childCount: filteredKelasList.length,
                ),
              );
            }
          }),
        ],
      ),
    );
  }
}
