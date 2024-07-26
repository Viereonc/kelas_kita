import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kelas_kita/presentation/screens/pembukuan/program_kelas_view.dart';

class PembukuanView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            margin: EdgeInsets.only(left: 3.0),
            padding: EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 56, 122, 223),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Icon(Icons.arrow_back_ios_new, color: Colors.white),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Pembukuan Kas',
          style: GoogleFonts.manrope(
            textStyle: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: screenHeight * 0.02),
            Center(
              child: Container(
                width: screenWidth * 0.9,
                height: screenHeight * 0.12,
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenHeight * 0.02),
                decoration: BoxDecoration(
                  color: Color(0xFF142847),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Total Uang Kas',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    Text(
                      'Rp 50.000',
                      style: GoogleFonts.manrope(
                        textStyle: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: screenWidth * 0.35,
                  height: screenHeight * 0.05,
                  margin: EdgeInsets.only(left: screenWidth * 0.05),
                  decoration: BoxDecoration(
                    color: Color(0xFFE8E8E8),
                    borderRadius: BorderRadius.circular(45.0),
                  ),
                  child: Center(
                    child: Text(
                      'Program Kelas',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProgramKelasView()),
                    );
                  },
                  child: Container(
                    width: 39,
                    height: 39,
                    margin: EdgeInsets.only(right: screenWidth * 0.05),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 56, 122, 223),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.013),
            Container(
              height: 1.0,
              margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              color: Color(0xFFF2F2F2),
            ),
            SizedBox(height: screenHeight * 0.015),
            _buildListItem('Buka Bersama', 'Maret 21 2024', 'Rp500.000', 'Mempunyai 80% Kedisiplinan Kas', Colors.blue, hasDietPlanIcon: true),
            SizedBox(height: screenHeight * 0.01),
            _buildDivider(),
            SizedBox(height: screenHeight * 0.01),
            _buildDateContainer('Maret 14, 2024'),
            SizedBox(height: screenHeight * 0.01),
            _buildDivider(),
            SizedBox(height: screenHeight * 0.01),
            _buildListItem('Bazare Makanan', 'Maret 21 2024', 'Rp10.000', '', Colors.red, hasMinusIcon: true),
            SizedBox(height: screenHeight * 0.01),
            _buildListItem('Bazare Makanan', 'Maret 21 2024', 'Rp100.000', '', Colors.green, hasIcon: true),
            _buildListItem('Bazare Makanan', 'Maret 21 2024', 'Rp10.000', '', Colors.red, hasMinusIcon: true),
            SizedBox(height: screenHeight * 0.01),
            _buildDivider(),
            SizedBox(height: screenHeight * 0.01),
            _buildDateContainer('Maret 16, 2024'),
            SizedBox(height: screenHeight * 0.01),
            _buildDivider(),
            SizedBox(height: screenHeight * 0.01),
            _buildListItem('Bazare Makanan', 'Maret 21 2024', 'Rp100.000', '', Colors.green, hasIcon: true),
            _buildListItem('Bazare Makanan', 'Maret 21 2024', 'Rp10.000', '', Colors.red, hasMinusIcon: true),
            SizedBox(height: screenHeight * 0.01),
            _buildDivider(),
            SizedBox(height: screenHeight * 0.01),
            _buildDateContainer('Maret 17, 2024'),
            SizedBox(height: screenHeight * 0.01),
            _buildDivider(),
            SizedBox(height: screenHeight * 0.01),
            _buildListItem('Bazare Makanan', 'Maret 21 2024', 'Rp100.000', '', Colors.green, hasIcon: true),
            _buildListItem('Bazare Makanan', 'Maret 21 2024', 'Rp10.000', '', Colors.red, hasMinusIcon: true),
            SizedBox(height: screenHeight * 0.01),
            _buildDivider(),
          ],
        ),
      ),
    );
  }

  Widget _buildDateContainer(String date) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 130,
          height: 35,
          margin: EdgeInsets.only(left: 20.0),
          decoration: BoxDecoration(
            color: Color(0xFFE8E8E8),
            borderRadius: BorderRadius.circular(45.0),
          ),
          child: Center(
            child: Text(
              date,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildListItem(String title, String date, String amount, String subtitle, Color iconColor,
      {bool hasIcon = false, bool hasMinusIcon = false, bool hasDietPlanIcon = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: iconColor,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (hasDietPlanIcon)
                  Image.asset(
                    'lib/assets/images/fluent-mdl2_diet-plan-notebook.png',
                    width: 20, 
                    height: 20, 
                    color: Colors.white, 
                  ),
                if (hasIcon)
                  Image.asset(
                    'lib/assets/images/iconuangplus.png',
                    width: 26,
                    height: 26, 
                    color: Colors.white, 
                  ),
                if (hasMinusIcon)
                  Image.asset(
                    'lib/assets/images/iconuangmin.png',
                    width: 26, 
                    height: 26, 
                    color: Colors.white,
                  ),
              ],
            ),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    date,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: Colors.black.withOpacity(0.4),
                      ),
                    ),
                  ),
                  SizedBox(width: 135),
                  Text(
                    amount,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              if (subtitle.isNotEmpty) ...[
                SizedBox(height: 4),
                Text(
                  subtitle,
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: Colors.black.withOpacity(0.4),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 2.0,
      margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
      color: Color(0xFFF2F2F2),
    );
  }
}
