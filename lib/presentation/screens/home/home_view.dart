import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kelas_kita/presentation/screens/struktur_kelas/struktur_kelas_view.dart';
import 'package:kelas_kita/presentation/themes/Colors.dart';
import 'package:kelas_kita/presentation/widgets/BottomNavigationBar/BottomNavigationBar.dart';
import '../../themes/FontsStyle.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: screenHeight * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: screenHeight * 0.02, left: screenWidth * 0.06),
                    child: Text(
                      'Hello, Ammar Faris 👋', 
                      style: tsHeader3()
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                    height: screenHeight * 0.17,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: Colors.grey,
                        width: screenWidth * 0.003,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: screenWidth * 0.65,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  topLeft: Radius.circular(13),
                                  bottomRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(13)),
                              color: primeryColorDark),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SvgPicture.asset("lib/assets/icons/he_cash.svg", width: screenWidth * 0.055, height: screenHeight * 0.055,),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Total Kas Kelas 11 PPLG 2',
                                      style: tsParagraft3()
                                          .copyWith(color: Colors.white)),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          top: screenHeight * 0.01)),
                                  Text('Rp 50.000',
                                      style: tsHeader2()
                                          .copyWith(color: Colors.white)),
                                ],
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Pembukuan \n Kas',
                                style: tsParagraft3(),
                                textAlign: TextAlign.center,
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.arrow_circle_right_rounded,
                                    size: 30,
                                    color: primeryColorDark,
                                  ))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: screenWidth * 0.03, left: screenWidth * 0.03, top: screenHeight * 0.05),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: screenHeight * 0.01),
                              width: screenWidth * 0.15,
                              height: screenWidth * 0.15,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13),
                                color: Color(0xFF41BEBE),
                              ),
                              child: Center(
                                child: SvgPicture.asset("lib/assets/icons/he_info_kelas.svg", width: screenWidth * 0.05, height: screenHeight * 0.05,)
                              ),
                            ),
                            Text(
                              'Info Kelas',
                              style: tsSubHeader5(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: screenHeight * 0.01),
                              width: screenWidth * 0.15,
                              height: screenWidth * 0.15,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13),
                                color: Color(0xFFFF844F),
                              ),
                              child: Center(
                                child: SvgPicture.asset("lib/assets/icons/he_info_tugas.svg", width: screenWidth * 0.05, height: screenHeight * 0.05,)
                              ),
                            ),
                            Text(
                              'Info Tugas',
                              style: tsSubHeader5(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: screenHeight * 0.01),
                              width: screenWidth * 0.15,
                              height: screenWidth * 0.15,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13),
                                color: Color(0xFF3EB67B),
                              ),
                              child: Center(
                                child: SvgPicture.asset("lib/assets/icons/he_kas.svg", width: screenWidth * 0.05, height: screenHeight * 0.05,)
                              ),
                            ),
                            Text(
                              'Kas',
                              style: tsSubHeader5(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: screenHeight * 0.01),
                              width: screenWidth * 0.15,
                              height: screenWidth * 0.15,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13),
                                color: Color(0xFFFFBF43),
                              ),
                              child: Center(
                                child: SvgPicture.asset("lib/assets/icons/he_note.svg", width: screenWidth * 0.05, height: screenHeight * 0.05,)
                              ),
                            ),
                            Text(
                              'Note',
                              style: tsSubHeader5(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => StrukturKelasScreen()),
                            );
                          },
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: screenHeight * 0.01),
                                width: screenWidth * 0.15,
                                height: screenWidth * 0.15,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(13),
                                  color: Color(0xFF5675E3),
                                ),
                                child: Center(
                                  child: SvgPicture.asset("lib/assets/icons/he_struktur.svg", width: screenWidth * 0.05, height: screenHeight * 0.05,)
                                ),
                              ),
                              Text(
                                'Struktur',
                                style: tsSubHeader5(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: screenHeight * 0.386,
              decoration: BoxDecoration(
                  color: Color(0xFFF8F4F3),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50))),
              child: Padding(
                padding: EdgeInsets.all(screenWidth * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Tagihan Tas Kelas", style: tsSubHeader3()),
                    Expanded(
                      child: ListView.builder(
                        itemCount: 9,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                            child: Container(
                              padding: EdgeInsets.only(left: screenWidth * 0.05),
                              height: screenHeight * 0.11,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    height: screenWidth * 0.12,
                                    width: screenWidth * 0.12,
                                    decoration: BoxDecoration(
                                        color: Color(0xFFEB4335),
                                        borderRadius: BorderRadius.circular(15)),
                                    child: Center(
                                      child: Icon(
                                        Icons.list_outlined,
                                        color: Colors.white,
                                        size: screenWidth * 0.08,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Kas Pada Tanggal 3 Maret 2024',
                                        style: tsSubHeader4(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'Belum Dibayar',
                                        style: tsParagraft4(),
                                      ),
                                      Text(
                                        'Rp.5.000',
                                        style: tsParagraft4()
                                            .copyWith(color: Color(0xFFBE1833)),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
            borderRadius: BorderRadius.circular(30)
          ),
          child: Icon(
            Icons.qr_code,
            color: Colors.white,
          ),
        ),
      ),
      bottomNavigationBar: BottomNavbar(),
    );
  }
}
