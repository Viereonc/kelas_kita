import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:kelas_kita/presentation/screens/struktur_kelas/struktur_kelas_controller.dart';
import 'package:kelas_kita/presentation/themes/Backdrop.dart';
import 'package:kelas_kita/presentation/themes/Colors.dart';
import 'package:kelas_kita/presentation/themes/FontsStyle.dart';

class StrukturKelasScreen extends StatelessWidget {
  StrukturKelasScreen({Key? key}) : super(key: key);

  final StrukturKelasController strukturKelasController = Get.put(StrukturKelasController());

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight * 0.07),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: AppBar(
            surfaceTintColor: Colors.white,
            title: Text(
              "Struktur Kelas",
              style: tsHeader2(),
            ),
            centerTitle: true,
            leading: Container(
              child: IconButton(
                onPressed: () {Navigator.pop(context);},
                icon: Container(
                  decoration: BoxDecoration(
                    color: primeryColorMedium,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                      size: screenWidth * 0.05,
                    )
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Obx(() {
        if (strukturKelasController.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),

            child: Column(
              children: [
                Container(
                  child: Divider(
                    color: Colors.grey,
                    thickness: 1.5,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02, horizontal: screenWidth * 0.02),
                        child: Container(
                          height: screenHeight * 0.18,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                primaryBackDrop(opacity: 0.1)
                              ],
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ListTile(
                                contentPadding: EdgeInsets.only(left: screenWidth * 0.05),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Dwi Janto',
                                      style: tsSubHeader4(
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    Text('Wali Kelas', style: tsParagraft5(fontWeight: FontWeight.w600),),
                                  ],
                                ),
                                leading: Container(
                                  width: screenWidth * 0.12,
                                  height: screenWidth * 0.12,
                                  decoration: BoxDecoration(
                                    color: primeryColorMedium,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                      Icons.person,
                                      color: Colors.white
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenHeight * 0.005),
                                child: Divider(
                                  color: Colors.grey,
                                  thickness: 0.5,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Absen',
                                          style: tsSubHeader4(
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: screenHeight * 0.01),
                                          child: Text(
                                            '01',
                                            style: tsParagraft5(),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Alamat',
                                          style: tsSubHeader4(
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        Container(
                                            margin: EdgeInsets.only(top: screenHeight * 0.01),
                                            child: Text(
                                              'Kudus Kota',
                                              style: tsParagraft5(),
                                            )
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'NIS',
                                          style: tsSubHeader4(
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: screenHeight * 0.01),
                                          child: Text(
                                            '12345',
                                            style: tsParagraft5(),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'No Telepon',
                                          style: tsSubHeader4(
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: screenHeight * 0.01),
                                          child: Text(
                                            '081222333444',
                                            style: tsParagraft5(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
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
          );
        }
      })
    );
  }
}
