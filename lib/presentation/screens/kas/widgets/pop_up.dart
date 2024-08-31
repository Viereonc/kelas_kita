import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:kelas_kita/presentation/screens/kas/kas_controller.dart';
import 'package:kelas_kita/presentation/screens/kas/widgets/qr_code.dart';
import 'package:kelas_kita/presentation/themes/FontsStyle.dart';
import 'package:midtrans_sdk/midtrans_sdk.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

void showGopayPopup(BuildContext context) async {
  final TextEditingController nominalController = TextEditingController();
  final KasController kasController = Get.put(KasController());
  final int? idKelas = await kasController.getIdKelas();
  final int? idBiodata = await kasController.fetchBiodataId();
  final String? nama = await kasController.getName();
  double screenHeight = MediaQuery.of(context).size.height;
  double screenWidth = MediaQuery.of(context).size.width;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenHeight * 0.01),
        title: Text('Masukkan Nominal', style: tsParagraft3(screenSize: screenWidth)),
        content: Container(
          margin: EdgeInsets.symmetric(vertical: 15),
          child: TextFormField(
            decoration: InputDecoration(
              labelText: 'Nominal',
              hintText: 'Masukkan jumlah nominal',
              hintStyle: tsParagraft4(screenSize: screenWidth, fontWeight: FontWeight.w400),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
            controller: nominalController,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Batal', style: tsParagraft3(screenSize: screenWidth)),
          ),
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: nominalController,
            builder: (context, value, child) {
              final isButtonEnabled = value.text.isNotEmpty;
              return TextButton(
                onPressed: isButtonEnabled
                    ? () async {
                  final nominal = int.tryParse(nominalController.text) ?? 0;

                  print('ID Kelas: $idKelas');
                  print('Nominal: $nominal');
                  print('ID Biodata: $idBiodata');

                  nominalController.clear();
                  Navigator.of(context).pop();
                  Get.to(() => QrCodePage(userName: nama ?? '', nominal: nominal, idBiodata: idBiodata ?? 0,));
                } : null,
                child: Text(
                  'Konfirmasi',
                  style: tsParagraft3(screenSize: screenWidth).copyWith(
                    color: isButtonEnabled ? Colors.black : Colors.grey,
                  ),
                ),
              );
            },
          ),
        ],
      );
    },
  );
}

