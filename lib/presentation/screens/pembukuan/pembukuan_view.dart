import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:kelas_kita/presentation/screens/pembukuan/add_pembukuan/add_pembukuan_kas.dart';
import 'package:kelas_kita/presentation/themes/Colors.dart';
import 'package:kelas_kita/presentation/screens/pembukuan/pembukuan_controller.dart';
import 'package:kelas_kita/presentation/screens/pembukuan/program_kelas_view.dart';

import '../../themes/FontsStyle.dart';
import 'edit_program_kas/edit_delete_option.dart';

class PembukuanView extends StatelessWidget {
  final PembukuanKasController pembukuanKasController = Get.put(PembukuanKasController());

  Future<void> _refreshData(BuildContext context) async {
    return pembukuanKasController.fetchProgramKasKelas();
  }

  Future<void> _refreshDataPembukuan(BuildContext context) async {
    return pembukuanKasController.fetchPembukuanKasKelas();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
              height: screenHeight * 0.15,
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
                    pembukuanKasController.tagihanKasList.isNotEmpty
                        ? 'Rp ${pembukuanKasController.tagihanKasList[0].jumlah}'  // Access the first element only if the list is not empty
                        : 'Rp 0',  // Default value if the list is empty
                    style: tsHeader2(screenSize: screenWidth).copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            TabBar(
              indicatorColor: Colors.blue,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              tabs: [
                Tab(text: 'Pembukuan Kas'),
                Tab(text: 'Program Kas'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildPembukuanKas(context, screenHeight),
                  _buildProgramKas(context, screenHeight),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPembukuanKas(BuildContext context, double screenHeight) {
    double screenWidth = MediaQuery.of(Get.context!).size.width;

    return RefreshIndicator(
      color: primeryColorMedium,
      backgroundColor: Colors.white,
      onRefresh: () => _refreshDataPembukuan(context),
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.03),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                        DateFormat('MMMM yyyy', 'id_ID').format(DateTime.now()),
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
                  Padding(
                    padding: EdgeInsets.only(right: screenWidth * 0.1),
                    child: Obx(() {
                      if (pembukuanKasController.userStatus.value == 'Bendahara' || pembukuanKasController.userStatus.value == 'Wali Kelas') {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              Get.context!,
                              MaterialPageRoute(builder: (context) => AddPembukuanKas()),
                            );
                          },
                          child: Container(
                            width: 39,
                            height: 39,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 56, 122, 223),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        );
                      } else {
                        return SizedBox(); // Return an empty container if not authorized
                      }
                    }),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            Obx(() {
              if (pembukuanKasController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              } else if (pembukuanKasController.pembukuanKasList.isEmpty) {
                return Center(child: Text('No data available'));
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemCount: pembukuanKasController.pembukuanKasList.length,
                  itemBuilder: (context, index) {
                    final item = pembukuanKasController.pembukuanKasList[index];
                    return _buildListItem(
                      item.id,
                      item.nama,
                      DateFormat('MMMM d yyyy', 'id_ID').format(item.tanggal),
                      'Rp ${item.jumlahPengeluaran}',
                      '',
                      item.jenis == 'Pemasukan' ? Colors.green : Colors.red,
                      hasMinusIcon: item.jenis == 'Pengeluaran',
                      hasIcon: item.jenis == 'Pemasukan',
                    );
                  },
                );
              }
            }),
            SizedBox(height: screenHeight * 0.03),
          ],
        ),
      ),
    );
  }

  Widget _buildProgramKas(BuildContext context, double screenHeight) {
    double screenWidth = MediaQuery.of(Get.context!).size.width;

    return Obx(() {
      if (pembukuanKasController.isLoading.value) {
        return Center(child: CircularProgressIndicator(color: primeryColorMedium, backgroundColor: Colors.white,));
      } else {
        return RefreshIndicator(
          color: primeryColorMedium,
          backgroundColor: Colors.white,
          onRefresh: () => _refreshData(context),
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: screenHeight * 0.03, bottom: screenHeight * 0.03),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                      Padding(
                        padding: EdgeInsets.only(right: screenWidth * 0.1,),
                        child: Obx(() {
                          if (pembukuanKasController.userStatus.value == 'Bendahara' || pembukuanKasController.userStatus.value == 'Wali Kelas') {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  Get.context!,
                                  MaterialPageRoute(builder: (context) => ProgramKelasView()),
                                );
                              },
                              child: Container(
                                width: 39,
                                height: 39,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 56, 122, 223),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              ),
                            );
                          } else {
                            return SizedBox(); // Return an empty container if not authorized
                          }
                        }),
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  padding: EdgeInsets.only(right: screenWidth * 0.1), // Add padding to account for the button
                  child: Column(
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
                  ),
                ),
              ],
            ),
          ),
        );
      }
    });
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
          if (pembukuanKasController.userStatus.value == 'Bendahara' ||
              pembukuanKasController.userStatus.value == 'Wali Kelas') {
            final program = pembukuanKasController.programKelasList.firstWhere((p) => p.idProgram == index);
            showModalBottomSheet(
              context: Get.context!,
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
          }
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            hasIcon
                ? Container(
              padding: EdgeInsets.all(14.0),
              margin: EdgeInsets.only(right: 5),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(Icons.arrow_upward, color: iconColor, size: 16.0),
            ) : hasMinusIcon ? Container(
              padding: EdgeInsets.all(14.0),
              margin: EdgeInsets.only(right: 5),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(Icons.arrow_downward, color: iconColor, size: 16.0),
            ) : hasDietPlanIcon ? Container(
              padding: EdgeInsets.all(12.0),
              margin: EdgeInsets.only(right: 5),
              decoration: BoxDecoration(
                color: primeryColorMedium,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Image.asset(
                'lib/assets/images/list.png',
                width: 20,
                height: 20,
                color: Colors.white,
              ),
            ) : Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(Icons.arrow_upward, color: iconColor, size: 16.0),
            ),
            SizedBox(width: 10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  date,
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),
                ),
                subtitle.isNotEmpty
                    ? Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    subtitle,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                )
                    : Container(),
              ],
            ),
            Spacer(),
            Text(
              amount,
              style: GoogleFonts.manrope(
                textStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: amountColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      thickness: 1,
      color: Color(0xFFE8E8E8),
      indent: 20,
      endIndent: 20,
    );
  }

  String _formatDate(DateTime date) {
    return DateFormat('d MMMM yyyy', 'id_ID').format(date);
  }
}
