import 'package:flutter/material.dart';
import 'package:kelas_kita/presentation/themes/Colors.dart';

import '../../themes/FontsStyle.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: screenWidth * 0.05, right: screenWidth * 0.05, top: screenHeight * 0.03, bottom: screenHeight * 0.03),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Hello, Ammar Faris 👋', style: tsHeader3()),
                Padding(padding: EdgeInsets.symmetric(vertical: 13)),
                Container(
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
                          borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(13), bottomRight: Radius.circular(10), bottomLeft: Radius.circular(13)),
                          color: primeryColorDark
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.attach_money, size: 64, color: Colors.white,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Total Kas Kelas 11 PPLG 2', style: tsParagraft3().copyWith(color: Colors.white)),
                                Padding(padding: EdgeInsets.only(top: screenHeight * 0.01)),
                                Text('Rp 50.000', style: tsHeader2().copyWith(color: Colors.white)),
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
                            IconButton(onPressed: () {}, icon: Icon(Icons.arrow_circle_right_rounded, size: 30, color: primeryColorDark,))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 13)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: screenHeight * 0.01),
                          width: screenWidth * 0.14,
                          height: screenHeight * 0.078,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13),
                            color: Color(0xFF41BEBE),
                          ),
                          child: Center(
                            child: Icon(Icons.meeting_room, size: 44, color: Colors.white,),
                          ),
                        ),
                        Text('Info Kelas', style: tsSubHeader5(fontWeight: FontWeight.bold),)
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: screenHeight * 0.01),
                          width: screenWidth * 0.14,
                          height: screenHeight * 0.078,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13),
                            color: Color(0xFFFF844F),
                          ),
                          child: Center(
                            child: Icon(Icons.task, size: 44, color: Colors.white,),
                          ),
                        ),
                        Text('Info Tugas', style: tsSubHeader5(fontWeight: FontWeight.bold),)
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: screenHeight * 0.01),
                          width: screenWidth * 0.14,
                          height: screenHeight * 0.078,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13),
                            color: Color(0xFF3EB67B),
                          ),
                          child: Center(
                            child: Icon(Icons.attach_money, size: 44, color: Colors.white,),
                          ),
                        ),
                        Text('Kas', style: tsSubHeader5(fontWeight: FontWeight.bold),)
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: screenHeight * 0.01),
                          width: screenWidth * 0.14,
                          height: screenHeight * 0.078,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13),
                            color: Color(0xFFFFBF43),
                          ),
                          child: Center(
                            child: Icon(Icons.sticky_note_2_sharp, size: 44, color: Colors.white,),
                          ),
                        ),
                        Text('Note', style: tsSubHeader5(fontWeight: FontWeight.bold),)
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: screenHeight * 0.01),
                          width: screenWidth * 0.14,
                          height: screenHeight * 0.078,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13),
                            color: Color(0xFF5675E3),
                          ),
                          child: Center(
                            child: Icon(Icons.account_tree, size: 44, color: Colors.white,),
                          ),
                        ),
                        Text('Struktur', style: tsSubHeader5(fontWeight: FontWeight.bold),)
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: screenHeight * 0.55,
            decoration: BoxDecoration(
              color: Color(0xFFF8F4F3),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50))
            ),
            child: Padding(
              padding: EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Tagihan Tas Kelas", style: tsSubHeader3()),
                  Expanded(
                    child: ListView.builder(
                      itemCount: 9,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Container(
                            padding: EdgeInsets.only(left: screenWidth * 0.05),
                            height: screenHeight * 0.12,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  height: screenHeight * 0.07,
                                  width: screenWidth * 0.12,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFEB4335),
                                    borderRadius: BorderRadius.circular(15)
                                  ),
                                  child: Center(
                                    child: Icon(Icons.list_outlined, color: Colors.white, size: 34,),
                                  ),
                                ),
                                SizedBox(width: 20,),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Kas Pada Tanggal 3 Maret 2024', style: tsSubHeader4(fontWeight: FontWeight.bold),),
                                    Text('Belum Dibayar', style: tsParagraft4(),),
                                    Text('Rp.5.000', style: tsParagraft4().copyWith(color: Color(0xFFBE1833)),),
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
    );
  }
}
