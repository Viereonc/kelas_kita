import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kelas_kita/presentation/themes/FontsStyle.dart';
import 'package:url_launcher/url_launcher.dart';

void showGopayPopup(BuildContext context) {
  final TextEditingController nominalController = TextEditingController();

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
              border: OutlineInputBorder(),
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
          TextButton(
            onPressed: () async {
              // Get the nominal value
              String enteredNominal = nominalController.text;

              // Replace with your logic to get the Midtrans transaction token
              String transactionToken = await getMidtransTransactionToken(enteredNominal);

              // Construct the Midtrans payment URL
              String paymentUrl = "https://app.midtrans.com/snap/v2/vtweb/$transactionToken";

              // Launch the payment URL in an external browser
              print('Launching URL: $paymentUrl');
              if (await canLaunch(paymentUrl)) {
                await launch(paymentUrl);
              } else {
                throw 'Could not launch $paymentUrl';
              }

              Navigator.of(context).pop();
            },
            child: Text('Konfirmasi', style: tsParagraft3(screenSize: screenWidth)),
          ),
        ],
      );
    },
  );
}

// Placeholder function to simulate getting the Midtrans transaction token
Future<String> getMidtransTransactionToken(String nominal) async {
  // Here you would make an API call to your backend to get the transaction token
  // For example, by sending the nominal amount to your server and getting the token
  String transactionToken = "YOUR_TRANSACTION_TOKEN"; // Replace with your actual transaction token
  return transactionToken;
}
