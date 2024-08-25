import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../kas_controller.dart';

class QrCodePage extends StatelessWidget {
  final String userName;
  final int nominal;
  final int idBiodata;
  final KasController kasController = Get.put(KasController());

  QrCodePage({required this.userName, required this.nominal, required this.idBiodata});

  Future<int?> _getIdBiodata() async {
    return await kasController.fetchBiodataId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code'),
      ),
      body: Center(
        child: FutureBuilder<int?>(
          future: _getIdBiodata(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Nama: $userName'),
                  Text('Nominal: $nominal'),
                  Text('ID Biodata: $idBiodata'),
                  SizedBox(height: 20),
                  QrImageView(
                    data: 'Nama: $userName\nNominal: $nominal\nID Biodata: $idBiodata',
                    version: QrVersions.auto,
                    size: 200.0,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, 'Konfirmasi');
                    },
                    child: Text('Konfirmasi'),
                  ),
                ],
              );
            } else {
              return Text('No data available');
            }
          },
        ),
      ),
    );
  }
}
