import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kelas_kita/presentation/screens/jadwal/jadwal_controller.dart';
import 'package:kelas_kita/presentation/screens/jadwal/jadwal_piket_view.dart';
import 'package:kelas_kita/presentation/screens/jadwal/model.dart';
import 'package:kelas_kita/presentation/themes/Colors.dart';
import 'package:kelas_kita/presentation/widgets/BottomNavigationBar/BottomNavigationBar.dart';

class JadwalScreen extends StatelessWidget {
  final JadwalController jadwalController = Get.put(JadwalController());

  JadwalScreen() {
    jadwalController.selectDay('Sel');
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return GetBuilder<JadwalController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.06),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildDayContainer(
                      screenWidth,
                      screenHeight,
                      'Sen',
                      controller,
                    ),
                    _buildDayContainer(
                      screenWidth,
                      screenHeight,
                      'Sel',
                      controller,
                    ),
                    _buildDayContainer(
                      screenWidth,
                      screenHeight,
                      'Rab',
                      controller,
                    ),
                    _buildDayContainer(
                      screenWidth,
                      screenHeight,
                      'Kam',
                      controller,
                    ),
                    _buildDayContainer(
                      screenWidth,
                      screenHeight,
                      'Jum',
                      controller,
                    ),
                    _buildDayContainer(
                      screenWidth,
                      screenHeight,
                      'Sab',
                      controller,
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),
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
                _buildScheduleContainer(screenHeight, screenWidth, controller),
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Container(
            margin: EdgeInsets.only(top: 30),
            height: 64,
            width: 64,
            child: FloatingActionButton(
              onPressed: () {},
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
          bottomNavigationBar: BottomNavbar(),
        );
      },
    );
  }

  Widget _buildScheduleContainer(
      double screenHeight, double screenWidth, JadwalController controller) {
    return Obx(() {
      String selectedDay = controller.selectedDay.value;
      List<ScheduleItem> scheduleItems =
          controller.getScheduleForDay(selectedDay);

      return SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          padding: EdgeInsets.symmetric(vertical: screenHeight * 0.012),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: scheduleItems.map((item) {
              return _buildScheduleItem(
                screenWidth,
                screenHeight,
                item.time,
                item.subject,
                item.teacher,
                item.duration,
              );
            }).toList(),
          ),
        ),
      );
    });
  }

  Widget _buildScheduleItem(double screenWidth, double screenHeight,
      String time, String subject, String teacher, String duration) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
              child: Text(
                time,
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
                width: screenWidth * 0.73,
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
                        subject,
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
                            teacher,
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
                          SvgPicture.asset(
                            'lib/assets/icons/clock.svg',
                            width: 16,
                            height: 16,
                          ),
                          SizedBox(width: 5),
                          Text(
                            duration,
                            style: TextStyle(
                              fontFamily: 'tsParagraft3',
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 9),
                      SvgPicture.asset(
                        'lib/assets/icons/abidhitam.svg',
                        width: 20,
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDayContainer(double screenWidth, double screenHeight, String day,
      JadwalController controller) {
    return Obx(() {
      bool isSelected = controller.selectedDay.value == day;
      Color containerColor =
          isSelected ? Color.fromARGB(255, 56, 122, 223) : Colors.white;

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
                color: isSelected ? Colors.white : Color.fromARGB(255, 56, 122, 223),
                fontSize: screenHeight * 0.022,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    });
  }
}
