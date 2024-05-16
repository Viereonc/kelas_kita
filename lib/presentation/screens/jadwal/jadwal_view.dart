import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kelas_kita/presentation/screens/jadwal/jadwal_piket_view.dart';

class JadwalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.only(
              bottom: screenHeight * 0.01,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: screenWidth * 0.05,
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context); 
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                    ),
                  ),
                ),
                Text(
                  'Maret',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'tsSubHeader1',
                    fontWeight: FontWeight.bold,
                    fontSize: screenHeight * 0.031,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    right: screenWidth * 0.05,
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.arrow_forward_ios,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            SizedBox(height: screenHeight * 0.001),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildDayContainer(
                  screenWidth,
                  screenHeight,
                  'Sen\n5',
                  context,
                ),
                _buildDayContainer(
                  screenWidth,
                  screenHeight,
                  'Sel\n6',
                  context,
                  isBlue: true,
                ),
                _buildDayContainer(
                  screenWidth,
                  screenHeight,
                  'Rab\n7',
                  context,
                ),
                _buildDayContainer(
                  screenWidth,
                  screenHeight,
                  'Kam\n8',
                  context,
                ),
                _buildDayContainer(
                  screenWidth,
                  screenHeight,
                  'Jum\n9',
                  context,
                ),
                _buildDayContainer(
                  screenWidth,
                  screenHeight,
                  'Sab\n10',
                  context,
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
              margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenHeight * 0.005),
              child: Divider(
                color: Colors.grey,
                thickness: 0.5,
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            _buildScheduleContainer(screenHeight, screenWidth),
          ],
        ),
      ),
    );
  }

  Widget _buildScheduleContainer(double screenHeight, double screenWidth) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
    padding: EdgeInsets.symmetric(vertical: screenHeight * 0.012),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
              child: Text(
                '07.40',
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
                        'Bahasa Indonesia',
                        style: TextStyle(
                          fontFamily: 'tsParagraft2',
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        'Pak Fuad',
                        style: TextStyle(
                          fontFamily: 'tsParagraft3',
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        '07.40 - 09.40',
                        style: TextStyle(
                          fontFamily: 'tsParagraft3',
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(height: 3),
                      SvgPicture.asset(
                        'lib/assets/icons/abidhitam.svg',
                        width: 23,
                        height: 23,
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

  Widget _buildDayContainer(
      double screenWidth, double screenHeight, String day, BuildContext context,
      {bool isBlue = false}) {
    Color containerColor =
        isBlue ? Color.fromARGB(255, 56, 122, 223) : Colors.white;

    return Container(
      width: screenWidth * 0.15,
      height: screenHeight * 0.085,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(screenHeight * 0.026),
        color: containerColor,
        border: Border.all(
          color: Color.fromARGB(255, 56, 122, 223),
          width: 1,
        ),
      ),
      child: Center(
        child: Text(
          day,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'tsParagraft4',
            fontWeight: FontWeight.w500,
            color: isBlue ? Colors.white : Colors.black.withOpacity(0.4),
            fontSize: screenHeight * 0.022,
          ),  
        ),
      ),
    );
  }
}
