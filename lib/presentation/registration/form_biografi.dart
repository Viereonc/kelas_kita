import 'package:flutter/material.dart';
import 'package:kelas_kita/presentation/screens/home/home_view.dart';

class BiografiView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    Alignment textAlignment = Alignment.center;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Color.fromARGB(255, 56, 122, 223),
              height: 200,
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                automaticallyImplyLeading: false,
              ),
            ),
          ),
          Positioned(
            top: 220,
            left: 20,
            right: 20,
            child: Container(
              width: screenWidth - 40,
              height: screenHeight - 240,
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
              child: Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.person, size: 20),
                          SizedBox(width: 5),
                          Text(
                            'Nama',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Container(
                        width: 400,
                        height: 40,
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Nama',
                            hintStyle: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: Colors.black.withOpacity(0.2),
                            ),
                            contentPadding: EdgeInsets.fromLTRB(12, 20, 12, 8),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                  color: Colors.black.withOpacity(0.4)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Isi dengan nama asli',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          color: Colors.black.withOpacity(0.4),
                        ),
                      ),
                      SizedBox(
                          height: 10),
                      Row(
                        children: [
                          Icon(Icons.school, size: 20),
                          SizedBox(width: 5),
                          Text(
                            'Kelas',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Container(
                        width: 400,
                        height: 40,
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Kelas',
                            hintStyle: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: Colors.black.withOpacity(0.2),
                            ),
                            contentPadding: EdgeInsets.fromLTRB(12, 20, 12, 8),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                  color: Colors.black.withOpacity(0.4)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Isi dengan kelas Anda',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          color: Colors.black.withOpacity(0.4),
                        ),
                      ),
                      SizedBox(
                          height: 10),
                      Row(
                        children: [
                          Icon(Icons.confirmation_number, size: 20),
                          SizedBox(width: 5),
                          Text(
                            'NIS',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Container(
                        width: 400,
                        height: 40,
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'NIS',
                            hintStyle: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: Colors.black.withOpacity(0.2),
                            ),
                            contentPadding: EdgeInsets.fromLTRB(12, 20, 12, 8),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                  color: Colors.black.withOpacity(0.4)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Isi dengan NIS Anda',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          color: Colors.black.withOpacity(0.4),
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.location_on, size: 20),
                          SizedBox(width: 5),
                          Text(
                            'Alamat',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Container(
                        width: 400,
                        height: 40,
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Alamat',
                            hintStyle: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: Colors.black.withOpacity(0.2),
                            ),
                            contentPadding: EdgeInsets.fromLTRB(12, 20, 12, 8),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                  color: Colors.black.withOpacity(0.4)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Isi dengan alamat Anda',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          color: Colors.black.withOpacity(0.4),
                        ),
                      ),
                      SizedBox(height: 35),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Memusatkan tombol
                        children: [
                          Container(
                            width: 140,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Colors.red,
                                width: 2,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Back',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => HomeScreen()),
                              );
                            },
                            child: Container(
                              width: 140,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 56, 122, 223), // Warna biru
                                borderRadius: BorderRadius.circular(5),
                                // border: Border.all(
                                //   color: Color.fromARGB(255, 56, 122, 223),
                                //   width: 2,
                                // ),
                              ),
                              child: Center(
                                child: Text(
                                  'Submit',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          Positioned(
            left: -30,
            top: -45,
            child: Transform.scale(
              scale: 0.550,
              child: Image.asset(
                'lib/assets/images/lr_form.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
          Positioned(
            left: 200,
            top: 80,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Isi form dengan',
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Positioned(
            left: 217,
            top: 110,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'data kalian',
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w600,
                  fontSize: 19,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
