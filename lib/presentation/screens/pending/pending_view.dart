import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kelas_kita/presentation/screens/pending/pending_controller.dart';
import 'package:kelas_kita/presentation/themes/FontsStyle.dart';

class PendingScreen extends StatelessWidget {
  PendingScreen({Key? key}) : super(key: key);

  final PendingController pendingController = Get.put(PendingController());

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Tunggu konfirmasi dari wali kelas", style: tsParagraft3(screenSize: screenWidth),),
          ],
        ),
      ),
    );
  }
}
