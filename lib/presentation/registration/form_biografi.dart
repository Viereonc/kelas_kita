import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kelas_kita/presentation/themes/Colors.dart';
import 'package:kelas_kita/presentation/themes/FontsStyle.dart';
import 'package:kelas_kita/presentation/widgets/TextFormField.dart';

class BiografiView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: screenHeight * 0.05),
            color: primeryColorMedium,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(left: screenWidth * 0.1),
                  width: screenWidth * 0.4,
                  child: Image.asset(
                    'lib/assets/images/lr_form.png',
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Isi form dengan',
                      textAlign: TextAlign.left,
                      style: tsSubHeader3(
                        color: Colors.white
                      )
                    ),
                    Text(
                      'data kalian ya!',
                      textAlign: TextAlign.left,
                      style: tsSubHeader3(
                        color: Colors.white
                      )
                    ),
                  ]
                )
              ],
            ),
          ),
          Container(
            child: Column(
              children: [
                Container(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Nama"
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
