import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:kelas_kita/presentation/screens/jadwal/jadwal_view.dart';

class JadwalPiketView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 65,
            left: 0,
            right: 0,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 10),
                  Text(
                    "Jadwal Piket",
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Hari-hari dalam seminggu
          Positioned(
            top: 120,
            left: 12,
            child: _buildDayContainer("Sen"),
          ),
          Positioned(
            top: 120,
            left: 74,
            child: _buildDayContainer("Sel", isWhite: false),
          ),
          Positioned(
            top: 120,
            left: 136,
            child: _buildDayContainer("Rab"),
          ),
          Positioned(
            top: 120,
            left: 199,
            child: _buildDayContainer("Kam"),
          ),
          Positioned(
            top: 120,
            left: 262,
            child: _buildDayContainer("Jum"),
          ),
          Positioned(
            top: 120,
            left: 325,
            child: _buildDayContainer("Sab"),
          ),

          // Ganti Jadwal container
          Positioned(
            top: 220,
            left: 12,
            child: _buildChangeScheduleContainer(screenWidth,
                context), // Perhatikan penggunaan parameter context
          ),

          // Black line below "Ganti Jadwal"
          Positioned(
            top: 280,
            left: 12,
            child: Container(
              width: screenWidth - 24,
              height: 1,
              color: Colors.black.withOpacity(0.2),
            ),
          ),

          Positioned(
            top: 300,
            left: 12,
            child: Container(
              width: 365,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Abid Sontoloyo",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Container kedua
          Positioned(
            top: 350,
            left: 12,
            child: Container(
              width: 365,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Baratha",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            top: 400,
            left: 12,
            child: Container(
              width: 365,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Adam",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDayContainer(String day, {bool isWhite = true}) {
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
      child: Center(
        child: Text(
          day,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: 15.0,
            color: isWhite ? Colors.black.withOpacity(0.4) : Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildChangeScheduleContainer(
      double screenWidth, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => JadwalScreen()),
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
                "Ganti Jadwal Pembelajaran",
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
