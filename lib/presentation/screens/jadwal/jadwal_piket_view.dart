import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kelas_kita/presentation/screens/jadwal/jadwal_view.dart';

class JadwalPiket extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
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
                    onPressed: () {},
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
                  'Sen', 
                  context
                ),
                _buildDayContainer(
                  screenWidth, 
                  screenHeight, 
                  'Sel', 
                  context,
                  isBlue: true
                ),
                _buildDayContainer(
                  screenWidth, 
                  screenHeight, 
                  'Rab', 
                  context
                ),
                _buildDayContainer(
                  screenWidth, 
                  screenHeight, 
                  'Kam', 
                  context
                ),
                _buildDayContainer(
                  screenWidth, 
                  screenHeight, 
                  'Jum', 
                  context
                ),
                _buildDayContainer(
                  screenWidth, 
                  screenHeight, 
                  'Sab', 
                  context
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.02),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => JadwalScreen()),
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
                          fontSize: screenHeight * 0.020,
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
            SizedBox(height: screenHeight * 0.03),
            Container(
              width: screenWidth * 0.91,
              height: screenHeight * 0.055,
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
                    'Abid',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: 'tsParagraft1',
                      fontWeight: FontWeight.w500,
                      fontSize: screenHeight * 0.020,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            Container(
              width: screenWidth * 0.91,
              height: screenHeight * 0.055,
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
                    'Adam',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: 'tsParagraft1',
                      fontWeight: FontWeight.w500,
                      fontSize: screenHeight * 0.020,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            Container(
              width: screenWidth * 0.91,
              height: screenHeight * 0.055,
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
                    'Baratha',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: 'tsParagraft1',
                      fontWeight: FontWeight.w500,
                      fontSize: screenHeight * 0.020,
                    ),
                  ),
                ),
              ),
            ),

          ],
        ),
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

