import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kelas_kita/presentation/screens/jadwal/jadwal_piket_view.dart';

class JadwalView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 60,
            left: 0,
            right: 0,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(CupertinoIcons.back, size: 35),
                    onPressed: () {},
                  ),
                  SizedBox(width: 100),
                  Text(
                    "Maret",
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0,
                    ),
                  ),
                  SizedBox(width: 100),
                  IconButton(
                    icon: Icon(CupertinoIcons.forward, size: 35),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            top: 120,
            left: 12,
            child: _buildDayContainer("Sen", "5"),
          ),
          Positioned(
            top: 120,
            left: 74,
            child: _buildDayContainer("Sel", "6", isWhite: false),
          ),
          Positioned(
            top: 120,
            left: 136,
            child: _buildDayContainer("Rab", "7"),
          ),
          Positioned(
            top: 120,
            left: 199,
            child: _buildDayContainer("Kam", "8"),
          ),
          Positioned(
            top: 120,
            left: 262,
            child: _buildDayContainer("Jum", "9"),
          ),
          Positioned(
            top: 120,
            left: 325,
            child: _buildDayContainer("Sab", "10"),
          ),

          Positioned(
            top: 220,
            left: 12,
            child: _buildChangeScheduleContainer(screenWidth, context),
          ),

          Positioned(
            top: 280,
            left: 12,
            child: Container(
              width: screenWidth - 24,
              height: 1,
              color: Colors.black.withOpacity(0.2),
            ),
          ),

          // Text "07.40"
          Positioned(
            top: 300,
            left: 14,
            child: Text(
              "07.40",
              style: TextStyle(
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w600,
                fontSize: 15.0,
              ),
            ),
          ),

          Positioned(
            top: 330,
            left: 35,
            child: Container(
              width: 1,
              height: 80,
              color: Colors.black.withOpacity(0.3),
            ),
          ),

          Positioned(
            top: 420,
            left: 14,
            child: Text(
              "09.40",
              style: TextStyle(
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w600,
                fontSize: 15.0,
              ),
            ),
          ),

          Positioned(
            top: 305,
            left: 80,
            child: Container(
              width: 290,
              height: 106,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 56, 122, 223),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 10),
                      Text(
                        "Bahasa Indonesia",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            top: 336,
            left: 100, // Sesuaikan posisi dengan kebutuhan Anda
            child: Row(
              children: [
                Image.asset(
                  'lib/assets/images/Vector.png',
                  width: 18,
                  height: 18,
                ),
                SizedBox(width: 5),
                Text(
                  "Pak Fuad",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 12.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 358,
            left: 100,
            child: Row(
              children: [
                Image.asset(
                  'lib/assets/images/Vector.png',
                  width: 18,
                  height: 18,
                ),
                SizedBox(width: 5),
                Text(
                  "07.40 - 09.40",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 12.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            top: 360,
            left: 100,
            child: Image.asset(
              'lib/assets/images/pr_icon.png',
              width: 60,
              height: 60,
            ),
          ),

          Positioned(
            top: 450,
            left: 35,
            child: Container(
              width: 1,
              height: 80,
              color: Colors.black.withOpacity(0.3),
            ),
          ),

          Positioned(
            top: 430,
            left: 80,
            child: Container(
              width: 290,
              height: 106,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 56, 122, 223),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 10),
                      Text(
                        "Bahasa Inggris",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            top: 460,
            left: 100,
            child: Row(
              children: [
                Image.asset(
                  'lib/assets/images/Vector.png',
                  width: 18,
                  height: 18,
                ),
                SizedBox(width: 5),
                Text(
                  "Mrs Ristina",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 12.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 480,
            left: 100,
            child: Row(
              children: [
                Image.asset(
                  'lib/assets/images/Vector.png',
                  width: 18,
                  height: 18,
                ),
                SizedBox(width: 5),
                Text(
                  "10.00 - 11.40",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 12.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            top: 480,
            left: 100,
            child: Image.asset(
              'lib/assets/images/pr_icon.png',
              width: 60,
              height: 60,
            ),
          ),

          Positioned(
            top: 545,
            left: 14,
            child: Text(
              "10.40",
              style: TextStyle(
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w600,
                fontSize: 15.0,
              ),
            ),
          ),

          Positioned(
            top: 580,
            left: 35,
            child: Container(
              width: 1,
              height: 80,
              color: Colors.black.withOpacity(0.3),
            ),
          ),

          Positioned(
            top: 555,
            left: 80,
            child: Container(
              width: 290,
              height: 106,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 56, 122, 223),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 10),
                      Text(
                        "Matematika",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            top: 587,
            left: 100,
            child: Row(
              children: [
                Image.asset(
                  'lib/assets/images/Vector.png',
                  width: 18,
                  height: 18,
                ),
                SizedBox(width: 5),
                Text(
                  "Bu Fauziyah Lisfana",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 12.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 608,
            left: 100,
            child: Row(
              children: [
                Image.asset(
                  'lib/assets/images/Vector.png',
                  width: 18,
                  height: 18,
                ),
                SizedBox(width: 5),
                Text(
                  "11.40 - 12.40",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 12.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            top: 610,
            left: 100,
            child: Image.asset(
              'lib/assets/images/pr_icon.png',
              width: 60,
              height: 60,
            ),
          ),

          Positioned(
            top: 675,
            left: 14,
            child: Text(
              "14.40",
              style: TextStyle(
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w600,
                fontSize: 15.0,
              ),
            ),
          ),

          Positioned(
            top: 705,
            left: 35,
            child: Container(
              width: 1,
              height: 80,
              color: Colors.black.withOpacity(0.3),
            ),
          ),

          Positioned(
            top: 680,
            left: 80,
            child: Container(
              width: 290,
              height: 106,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 56, 122, 223),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 10),
                      Text(
                        "Web Programing",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            top: 710,
            left: 100,
            child: Row(
              children: [
                Image.asset(
                  'lib/assets/images/Vector.png',
                  width: 18,
                  height: 18,
                ),
                SizedBox(width: 5),
                Text(
                  "Pak Fahmi Ihsyad",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 12.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 730,
            left: 100,
            child: Row(
              children: [
                Image.asset(
                  'lib/assets/images/Vector.png',
                  width: 18,
                  height: 18,
                ),
                SizedBox(width: 5),
                Text(
                  "12.40 - 14.40",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 12.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            top: 733,
            left: 100,
            child: Image.asset(
              'lib/assets/images/pr_icon.png',
              width: 60,
              height: 60,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDayContainer(String day, String date, {bool isWhite = true}) {
    return Container(
      width: 58,
      height: 75,
      decoration: BoxDecoration(
        color: isWhite ? Colors.white : Color.fromARGB(255, 56, 122, 223),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Color.fromARGB(255, 56, 122, 223),
          width: 2,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            day,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 15.0,
              color: isWhite ? Colors.black.withOpacity(0.4) : Colors.white,
            ),
          ),
          SizedBox(height: 5),
          Text(
            date,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 15.0,
              color: isWhite ? Colors.black.withOpacity(0.4) : Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChangeScheduleContainer(
      double screenWidth, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => JadwalPiketView()),
        );
      },
      child: Container(
        width: screenWidth - 24,
        height: 29,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 56, 122, 223),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                "Ganti Jadwal Piket",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 15.0,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Image.asset(
                'lib/assets/images/ep_switch.png',
                width: 20,
                height: 20,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
