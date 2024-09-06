import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kelas_kita/presentation/screens/jadwal/jadwal_view.dart';
import '../../themes/FontsStyle.dart';
import 'jadwal_piket_controller.dart';

class JadwalPiket extends StatelessWidget {
  final JadwalPiketController controller = Get.put(JadwalPiketController());

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return GetBuilder<JadwalPiketController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.02),
                Text(
                    'Jadwal Piket',
                    style: tsHeader3(screenSize: screenWidth)
                ),
                SizedBox(height: screenHeight * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildDayContainer(
                      screenWidth, screenHeight, 'Sen', controller),
                    _buildDayContainer(
                      screenWidth, screenHeight, 'Sel', controller),
                    _buildDayContainer(
                      screenWidth, screenHeight, 'Rab', controller),
                    _buildDayContainer(
                      screenWidth, screenHeight, 'Kam', controller),
                    _buildDayContainer(
                      screenWidth, screenHeight, 'Jum', controller),
                    _buildDayContainer(
                      screenWidth, screenHeight, 'Sab', controller),
                  ],
                ),
                SizedBox(height: screenHeight * 0.03),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.05,
                    vertical: screenHeight * 0.005),
                  child: Divider(
                    color: Colors.grey,
                    thickness: 0.5,
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                controller.isLoading.value
                    ? Center(child: CircularProgressIndicator())
                    : Column(
                        children: controller
                          .getScheduleForDay(controller.selectedDay)
                          .map((item) {
                            return Container(
                              width: screenWidth * 0.91,
                              height: screenHeight * 0.055,
                              margin: EdgeInsets.only(bottom: screenHeight * 0.03),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(screenHeight * 0.010),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.25),
                                    blurRadius: 4,
                                    spreadRadius: 0,
                                  ),
                                ],
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: screenWidth * 0.04),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    item.nama,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontFamily: 'tsParagraft1',
                                      fontWeight: FontWeight.w500,
                                      fontSize: screenHeight * 0.020,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                      ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDayContainer(double screenWidth, double screenHeight, String day,
      JadwalPiketController controller) {
    bool isBlue = controller.selectedDay == day;

    return GestureDetector(
      onTap: () {
        controller.selectDay(day);
      },
      child: Container(
        width: screenWidth * 0.15,
        height: screenHeight * 0.085,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22), 
          color: isBlue ? Color.fromARGB(255, 56, 122, 223) : Colors.white, 
          border: Border.all(
            color: isBlue ? Color.fromARGB(255, 56, 122, 223) : Color.fromARGB(255, 56, 122, 223), 
            width: 1, // Set the stroke width
          ),
        ),
        child: Center(
          child: Text(
            day,
            style: TextStyle(
              fontFamily: 'tsParagraft1',
              fontWeight: FontWeight.bold,
              color: isBlue ? Colors.white : Color.fromARGB(255, 56, 122, 223),
              fontSize: screenHeight * 0.020,
            ),
          ),
        ),
      ),
    );
  }
}
