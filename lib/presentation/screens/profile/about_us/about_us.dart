import 'package:flutter/material.dart';

import '../../../themes/Colors.dart';
import '../../../themes/FontsStyle.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

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
              "About Us",
              style: tsHeader2(),
            ),
            centerTitle: true,
            leading: Container(
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Container(
                  decoration: BoxDecoration(
                    color: primeryColorMedium,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Icon(Icons.arrow_back_ios_new, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: screenWidth * 0.05, right: screenWidth * 0.05, bottom: screenHeight * 0.1),
        child: Column(
          children: [
            Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            Container(
              height: screenHeight * 0.53,
              margin: EdgeInsets.only(top: screenHeight * 0.03),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: screenHeight * 0.53,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Kelas Kita', style: tsHeader3(),),
                        Text('KelasKita adalah aplikasi untuk pengelolaan kelas menjadi lebih terstruktur dan teratur. Dengan fitur-fitur seperti pembukuan kas, jadwal piket, jadwal pelajaran, absensi, dan masih banyak lagi, KelasKita dirancang untuk memudahkan dalam mengelola dan mengatur kelas, sehingga guru dan murid  dapat lebih efisien menggunakan waktu mereka untuk fokus pada proses belajar-mengajar dan pencapaian tujuan pembelajaran.', style: tsParagraft4(),),
                        Text('Tentang Kami', style: tsHeader3(),),
                        Text('Beberapa hal tentang kami:', style: tsParagraft4(),),
                        Text('\u2022 Vicko: Backend', style: tsParagraft4(),),
                        Text('\u2022 Arvia: Frontend', style: tsParagraft4(),),
                        Text('\u2022 Faris: Frontend', style: tsParagraft4(),),
                        Text('\u2022 Izal: Frontend', style: tsParagraft4(),),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
