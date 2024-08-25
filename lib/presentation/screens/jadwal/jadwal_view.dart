import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kelas_kita/presentation/screens/jadwal/jadwal_controller.dart';
import 'package:kelas_kita/presentation/screens/jadwal/jadwal_piket_view.dart';
import 'package:kelas_kita/presentation/themes/Colors.dart';
import 'package:kelas_kita/presentation/widgets/BottomNavigationBar/BottomNavigationBar.dart';

import '../../../constants.dart';
import '../../../data/models/jadwal_kelas_model.dart';
import '../../widgets/BottomNavigationBarGuru/BottomNavigationBar.dart';

class JadwalScreen extends StatelessWidget {
  // Initialize the JadwalController using GetX
  final JadwalController jadwalController = Get.put(JadwalController());

  // Refresh data method to be called when user pulls to refresh
  Future<void> _refreshData(BuildContext context) async {
    return jadwalController.fetchJadwalPelajaran();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: () => _refreshData(context),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.06),

              // Header with navigation buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      // Handle back arrow press
                    },
                  ),
                  Text(
                    'Maret',
                    style: TextStyle(
                      fontFamily: 'tsHeader1',
                      fontWeight: FontWeight.bold,
                      fontSize: screenHeight * 0.03,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_forward_ios),
                    onPressed: () {
                      // Handle forward arrow press
                    },
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.02),

              // Day selection buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildDayContainer(
                    screenWidth,
                    screenHeight,
                    'Sen',
                    jadwalController,
                  ),
                  _buildDayContainer(
                    screenWidth,
                    screenHeight,
                    'Sel',
                    jadwalController,
                  ),
                  _buildDayContainer(
                    screenWidth,
                    screenHeight,
                    'Rab',
                    jadwalController,
                  ),
                  _buildDayContainer(
                    screenWidth,
                    screenHeight,
                    'Kam',
                    jadwalController,
                  ),
                  _buildDayContainer(
                    screenWidth,
                    screenHeight,
                    'Jum',
                    jadwalController,
                  ),
                  _buildDayContainer(
                    screenWidth,
                    screenHeight,
                    'Sab',
                    jadwalController,
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.02),

              // Button to change schedule
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => JadwalPiket()),
                  );
                },
                child: Container(
                  width: screenWidth * 0.91,
                  height: screenHeight * 0.037,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(screenHeight * 0.010),
                    color: Color.fromARGB(255, 56, 122, 223),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: screenWidth * 0.04),
                        child: Text(
                          'Ganti Jadwal',
                          style: TextStyle(
                            fontFamily: 'tsParagraft1',
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            fontSize: screenHeight * 0.018,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(screenWidth * 0.02),
                        child: SvgPicture.asset(
                          'lib/assets/icons/ep_switch (1).svg',
                          width: screenWidth * 0.03,
                          height: screenHeight * 0.03,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.03),

              // Divider line
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
              SizedBox(height: screenHeight * 0.02),

              // Schedule display based on selected day
              Obx(() {
                if (jadwalController.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }

                String selectedDay = jadwalController.selectedDay.value;
                List<JadwalKelasModel> scheduleItems =
                    jadwalController.getScheduleForDay(selectedDay);

                if (scheduleItems.isEmpty) {
                  return Center(
                    child: Text('No schedule available for $selectedDay'),
                  );
                }

                return _buildScheduleContainer(
                  screenHeight,
                  screenWidth,
                  scheduleItems,
                  context,
                );
              }),
            ],
          ),
        ),
      ),

      // Floating action button
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        margin: EdgeInsets.only(top: 30),
        height: 64,
        width: 64,
        child: FloatingActionButton(
          onPressed: () {
            if (jadwalController.userStatus.value == 'Wali Kelas') {
              Get.toNamed('/qrcodeguruscreen');
            } else {
              Get.toNamed('/qrcodesiswascreen');
            }
          },
          backgroundColor: primeryColorMedium,
          elevation: 0,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 3, color: Colors.white),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Icon(
            Icons.qr_code,
            color: Colors.white,
          ),
        ),
      ),

      // Bottom navigation bar based on user status
      bottomNavigationBar: Obx(() {
        if (jadwalController.userStatus.value == 'Wali Kelas') {
          return BottomNavbarGuru();
        } else {
          return BottomNavbar();
        }
      }),
    );
  }

  // Container for each day's schedule button
  Widget _buildDayContainer(double screenWidth, double screenHeight, String day,
      JadwalController controller) {
    return Obx(() {
      bool isSelected = controller.selectedDay.value == day;
      Color containerColor =
          isSelected ? Color.fromARGB(255, 56, 122, 223) : Colors.white;
      Color textColor =
          isSelected ? Colors.white : Color.fromARGB(255, 56, 122, 223);

      return GestureDetector(
        onTap: () {
          controller.selectDay(day);
        },
        child: Container(
          width: screenWidth * 0.15,
          height: screenHeight * 0.085,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(screenHeight * 0.026),
            color: containerColor,
            border: Border.all(
              color: Color.fromARGB(255, 56, 122, 223),
            ),
          ),
          child: Center(
            child: Text(
              day,
              style: TextStyle(
                fontFamily: 'tsSubHeader1',
                fontWeight: FontWeight.w600,
                color: textColor,
                fontSize: screenHeight * 0.022,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    });
  }

  // Container to display schedule items for the selected day
  Widget _buildScheduleContainer(double screenHeight, double screenWidth,
      List<JadwalKelasModel> scheduleItems, BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        padding: EdgeInsets.symmetric(vertical: screenHeight * 0.012),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: List.generate(scheduleItems.length, (index) {
            var item = scheduleItems[index];
            return _buildScheduleItem(screenWidth, screenHeight, item, context);
          }),
        ),
      ),
    );
  }

  // Widget to display a single schedule item
  Widget _buildScheduleItem(
    double screenWidth,
    double screenHeight,
    JadwalKelasModel item,
    BuildContext context,
  ) {
    final JadwalController jadwalController = Get.find();
    int absensiCount = item.absensi.length;
    int visibleCount = absensiCount > 3 ? 3 : absensiCount;
    int hiddenCount = absensiCount - 3;

    return GestureDetector(
      onTap: () =>
          _showAbsensiDialog(context, item.absensi), // Pass absensi list here
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
                child: Text(
                  '${jadwalController.formatTime(item.jamMulai)}',
                  style: TextStyle(
                    fontFamily: 'tsSubHeader2',
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: 1,
                height: 103,
                color: Colors.grey,
                margin: EdgeInsets.only(left: screenWidth * 0.01),
              ),
            ],
          ),
          SizedBox(width: screenWidth * 0.05),
          Align(
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10),
                  width: screenWidth * 0.7,
                  height: 124,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromARGB(255, 56, 122, 223),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: screenWidth * 0.08),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          item.namaPelajaran,
                          style: TextStyle(
                            fontFamily: 'tsParagraft2',
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 2),
                        Row(
                          children: [
                            SvgPicture.asset(
                              'lib/assets/icons/teacher.svg',
                              width: 16,
                              height: 16,
                            ),
                            SizedBox(width: 5),
                            Text(
                              item.guru,
                              style: TextStyle(
                                fontFamily: 'tsParagraft3',
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 3),
                        Row(
                          children: [
                            Icon(
                              CupertinoIcons.clock,
                              color: Colors.white,
                              size: 19,
                            ),
                            SizedBox(width: 5),
                            Text(
                              '${jadwalController.formatTime(item.jamMulai)} - ${jadwalController.formatTime(item.jamSelesai)}',
                              style: TextStyle(
                                fontFamily: 'tsParagraft3',
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 7),
                        Container(
                          height: screenHeight * 0.03,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              // Stack for the first 3 CircleAvatars
                              ...List.generate(
                                visibleCount,
                                (index) {
                                  return Positioned(
                                    left: 20.0 * index,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: Colors.black, width: 0.5),
                                      ),
                                      child: CircleAvatar(
                                        backgroundImage: NetworkImage(baseUrl +
                                            storage +
                                            item.absensi[index].image),
                                        radius: 13,
                                        backgroundColor: Colors.white,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              // Indicator for hidden items
                              if (hiddenCount > 0)
                                Positioned(
                                  left: 20.0 *
                                      visibleCount, // Positioned right after the visible avatars
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Colors.black, width: 0.5),
                                    ),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 13,
                                      child: Center(
                                        child: Text(
                                          '+ $hiddenCount',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Show a dialog with list of absensi
  void _showAbsensiDialog(BuildContext context, List<Absensi> absensiList) {
  // Sort the list so that late students appear at the top
  absensiList.sort((a, b) {
    if (a.telat == b.telat) {
      return 0; // if both are the same (both late or both not late), maintain original order
    }
    return a.telat == 1 ? -1 : 1; // if a is late and b is not, a should come first
  });

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Daftar Kehadiran Siswa'),
        content: Container(
          width: double.maxFinite,
          child: Obx(() {
            if (jadwalController.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            }

            if (absensiList.isEmpty) {
              return Center(child: Text('No students are late.'));
            }

            return ListView.builder(
              shrinkWrap: true,
              itemCount: absensiList.length,
              itemBuilder: (BuildContext context, int index) {
                Absensi absensi = absensiList[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage:
                        NetworkImage(baseUrl + storage + absensi.image),
                    backgroundColor: Colors.white,
                  ),
                  title: Text(absensi.nama),
                  subtitle: RichText(
                    text: TextSpan(
                      text: '${absensi.waktuAbsen} ',
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        if (absensi.telat == 1)
                          TextSpan(
                            text: '(Telat)',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red, // Optional: Customize the color
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            );
          }),
        ),
        actions: [
          TextButton(
            child: Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

}
