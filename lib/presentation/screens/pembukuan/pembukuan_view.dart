import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kelas_kita/presentation/screens/pembukuan/pembukuan_controller.dart';
import 'package:kelas_kita/presentation/screens/pembukuan/program_kelas_view.dart';
import 'package:kelas_kita/presentation/screens/pembukuan/edit_pembukuan/edit_delete_option.dart';
import 'package:get/get.dart';
import 'package:kelas_kita/presentation/themes/Colors.dart';

class PembukuanView extends StatelessWidget {
  final PembukuanKasController pembukuanKasController = Get.put(PembukuanKasController());

  Future<void> _refreshData(BuildContext context) async {
    return pembukuanKasController.fetchProgramKasKelas();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        foregroundColor: Colors.white,
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
            Get.toNamed('/homescreen');
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
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 15),
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
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => _refreshData(context),
              color: primeryColorMedium,
              backgroundColor: Colors.white,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: screenHeight * 0.04),
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
                    Obx(() {
                      if (pembukuanKasController.isLoading.value) {
                        return CircularProgressIndicator();
                      } else {
                        return Column(
                          children: pembukuanKasController.programKelasList.map((program) {
                            return _buildListItem(
                              program.idProgram,
                              program.nama,
                              _formatDate(program.jadwal),
                              'Rp ${program.jumlah}',
                              'Mempunyai 80% Kedisiplinan Kas',
                              Colors.blue,
                              hasDietPlanIcon: true,
                            );
                          }).toList(),
                        );
                      }
                    }),
                    SizedBox(height: screenHeight * 0.03),
                    SizedBox(height: screenHeight * 0.01),
                    _buildDateContainer('Maret 14, 2024'),
                    SizedBox(height: screenHeight * 0.01),
                    _buildDivider(),
                    SizedBox(height: screenHeight * 0.01),
                    _buildListItem(1, 'Bazare Makanan', 'Maret 21 2024', 'Rp10.000', '', Colors.red, hasMinusIcon: true),
                    _buildListItem(2, 'Bazare Makanan', 'Maret 21 2024', 'Rp100.000', '', Colors.green, hasIcon: true),
                    _buildListItem(3, 'Bazare Makanan', 'Maret 21 2024', 'Rp10.000', '', Colors.red, hasMinusIcon: true),
                    SizedBox(height: screenHeight * 0.03),
                    SizedBox(height: screenHeight * 0.01),
                    _buildDateContainer('Maret 16, 2024'),
                    SizedBox(height: screenHeight * 0.01),
                    _buildDivider(),
                    SizedBox(height: screenHeight * 0.01),
                    _buildListItem(4, 'Bazare Makanan', 'Maret 21 2024', 'Rp100.000', '', Colors.green, hasIcon: true),
                    _buildListItem(5, 'Bazare Makanan', 'Maret 21 2024', 'Rp10.000', '', Colors.red, hasMinusIcon: true),
                    SizedBox(height: screenHeight * 0.03),
                    SizedBox(height: screenHeight * 0.01),
                    _buildDateContainer('Maret 17, 2024'),
                    SizedBox(height: screenHeight * 0.01),
                    _buildDivider(),
                    SizedBox(height: screenHeight * 0.01),
                    _buildListItem(6, 'Bazare Makanan', 'Maret 21 2024', 'Rp100.000', '', Colors.green, hasIcon: true),
                    _buildListItem(7, 'Bazare Makanan', 'Maret 21 2024', 'Rp10.000', '', Colors.red, hasMinusIcon: true),
                    SizedBox(height: screenHeight * 0.01),
                    _buildDivider(),
                  ],
                ),
              ),
            ),
          ),
        ],
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

Widget _buildListItem(
  int index,
  String title,
  String date,
  String amount,
  String subtitle,
  Color iconColor, {
  bool hasIcon = false,
  bool hasMinusIcon = false,
  bool hasDietPlanIcon = false,
}) {
  Color amountColor = Colors.black;

  if (hasIcon) {
    amountColor = Colors.green;
  } else if (hasMinusIcon) {
    amountColor = Colors.red;
  }

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
    child: GestureDetector(
      onLongPress: () {
        final program = pembukuanKasController.programKelasList.firstWhere((p) => p.idProgram == index);
        showModalBottomSheet(
          context: Get.context!, // Use Get.context to access context
          builder: (context) {
            return OptionEditDeletePembukuanKas(
              index: index,  
              idProgram: program.idProgram,
              nama: title,
              status: '', 
              jumlah: program.jumlah.toString(),
              jadwal: program.jadwal,
              createdAt: program.createdAt,
              updatedAt: program.updatedAt,
            );
          },
        );
        print('Index: $index');
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
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
                        'lib/assets/images/list.png',
                        width: 20,
                        height: 20,
                        color: Colors.white,
                      ),
                    if (hasIcon)
                      SvgPicture.asset(
                        'lib/assets/icons/ks_plus.svg',
                      ),
                    if (hasMinusIcon)
                      SvgPicture.asset(
                        'lib/assets/icons/ks_minus.svg',
                      ),
                  ],
                ),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
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
                  SizedBox(height: 5),
                  Text(
                    date,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  if (subtitle.isNotEmpty) ...[
                    Text(
                      subtitle,
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ]
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                amount,
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: amountColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

  Widget _buildDivider() {
    return Container(
      height: 1.0,
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      color: Color(0xFFF2F2F2),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.month}/${date.day}/${date.year}';
  }
}
