import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kelas_kita/presentation/themes/Backdrop.dart';
import 'package:kelas_kita/presentation/themes/Colors.dart';
import 'package:kelas_kita/presentation/themes/FontsStyle.dart';

class StrukturKelasScreen extends StatelessWidget {
  const StrukturKelasScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(66),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
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
                      child:
                          Icon(Icons.arrow_back_ios_new, color: Colors.white)),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Column(
          children: [
            Divider(
              color: Colors.grey,
              thickness: 1.5,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
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
                            contentPadding: EdgeInsets.only(left: 20),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(width: 30,),
                                Text('Dwi Janto', style: tsSubHeader4(fontWeight: FontWeight.bold),),
                                Text('Wali Kelas', style: tsParagraft5(fontWeight: FontWeight.w600),),
                              ],
                            ),
                            leading: CircleAvatar(
                              backgroundColor: primeryColorMedium,
                              child: Icon(Icons.person, color: Colors.white,),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: Divider(
                              color: Colors.grey,
                              thickness: 0.5,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 25, right: 25),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Absen', style: tsSubHeader4(fontWeight: FontWeight.bold),),
                                    SizedBox(height: 5,),
                                    Text('01', style: tsParagraft4(),),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Alamat', style: tsSubHeader4(fontWeight: FontWeight.bold),),
                                    SizedBox(height: 5,),
                                    Text('Kudus Kota', style: tsParagraft4(),),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('NIS', style: tsSubHeader4(fontWeight: FontWeight.bold),),
                                    SizedBox(height: 5,),
                                    Text('12345', style: tsParagraft4(),),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('No Telepon', style: tsSubHeader4(fontWeight: FontWeight.bold),),
                                    SizedBox(height: 5,),
                                    Text('081222333444', style: tsParagraft4(),),
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
      ),
    );
  }
}
