import 'package:flutter/material.dart';
import 'package:kelas_kita/presentation/screens/home/home_view.dart';

class BiografiView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double imageWidth = screenWidth * 0.4;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                Container(
                  width: screenWidth,
                  height: screenHeight * 0.20,
                  color: Color.fromARGB(255, 56, 122, 223),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.only(left: screenWidth * 0.13),
                    child: Image.asset(
                      'lib/assets/images/lr_form.png',
                      fit: BoxFit.fill,
                      width: imageWidth,
                      height: screenHeight * 0.2,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: screenWidth * 0.54, top: screenHeight * 0.07),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Isi form dengan',
                        style: TextStyle(
                          fontFamily: 'tsSubHeader5',
                          fontWeight: FontWeight.w500,
                          fontSize: screenWidth * 0.0490,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.003),
                      Text(
                        'data kalian',
                        style: TextStyle(
                          fontFamily: 'tsSubHeader5',
                          fontWeight: FontWeight.w500,
                          fontSize: screenWidth * 0.0490,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                screenWidth * 0.05,
                screenWidth * 0.03,
                screenWidth * 0.05,
                screenHeight * 0.0,
              ),
              child: FractionallySizedBox(
                widthFactor: 0.99,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: Colors.black.withOpacity(0.2),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(screenWidth * 0.05),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildFormField(
                          label: 'Nama',
                          hint: 'Nama',
                          hintDescription: 'Isi dengan nama asli',
                          screenWidth: screenWidth,
                        ),
                        SizedBox(height: screenHeight * 0.025),
                        buildFormField(
                          label: 'Kelas',
                          hint: 'Kelas',
                          hintDescription: 'Isi dengan kelas Anda',
                          screenWidth: screenWidth,
                        ),
                        SizedBox(height: screenHeight * 0.025),
                        buildFormField(
                          label: 'NIS',
                          hint: 'NIS',
                          hintDescription: 'Isi dengan NIS Anda',
                          screenWidth: screenWidth,
                        ),
                        SizedBox(height: screenHeight * 0.025),
                        buildFormField(
                          label: 'Alamat',
                          hint: 'Alamat',
                          hintDescription: 'Isi dengan alamat Anda',
                          screenWidth: screenWidth,
                        ),
                        SizedBox(height: screenHeight * 0.10),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(
          screenWidth * 0.06,
          screenHeight * 0.025,
          screenWidth * 0.06,
          screenHeight * 0.050,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildButton(
              text: 'Back',
              color: Colors.white,
              textColor: Colors.red,
              borderColor: Colors.red,
              screenWidth: screenWidth,
              onTap: () {
                Navigator.pop(context);
              },
            ),
            buildButton(
              text: 'Submit',
              color: Color.fromARGB(255, 56, 122, 223),
              textColor: Colors.white,
              screenWidth: screenWidth,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFormField({
    required String label,
    required String hint,
    required String hintDescription,
    required double screenWidth,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.person, size: screenWidth * 0.05),
            SizedBox(width: screenWidth * 0.0125),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'tsParagraft3',
                fontWeight: FontWeight.w500,
                fontSize: screenWidth * 0.04,
              ),
            ),
          ],
        ),
        SizedBox(height: screenWidth * 0.0125),
        Container(
          width: double.infinity,
          height: screenWidth * 0.1,
          child: TextFormField(
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                fontFamily: 'tsParagraft3',
                fontWeight: FontWeight.w500,
                fontSize: screenWidth * 0.0375,
                color: Colors.black.withOpacity(0.2),
              ),
              contentPadding: EdgeInsets.fromLTRB(
                screenWidth * 0.03,
                screenWidth * 0.05,
                screenWidth * 0.03,
                screenWidth * 0.02,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  color: Colors.black.withOpacity(0.4),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: screenWidth * 0.0125),
        Text(
          hintDescription,
          style: TextStyle(
            fontFamily: 'tsParagraft3',
            fontWeight: FontWeight.w500,
            fontSize: screenWidth * 0.0325,
            color: Colors.black.withOpacity(0.4),
          ),
        ),
      ],
    );
  }

  Widget buildButton({
    required String text,
    required Color color,
    required Color textColor,
    double? screenWidth,
    Color? borderColor,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: screenWidth! * 0.35,
        height: screenWidth * 0.1,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5),
          border: borderColor != null
              ? Border.all(color: borderColor, width: 2)
              : null,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: screenWidth * 0.04,
              fontWeight: FontWeight.bold,
              fontFamily: 'tsParagraft3',
            ),
          ),
        ),
      ),
    );
  }
}
