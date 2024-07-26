import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProgramKelasView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            margin: EdgeInsets.only(left: 3.0),
            padding: EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 56, 122, 223),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Icon(Icons.arrow_back_ios_new, color: Colors.white),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Tambah Program',
          style: GoogleFonts.manrope(
            textStyle: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 25),
          Container(
            height: 1.0,
            margin: EdgeInsets.symmetric(horizontal: 25.0),
            color: Colors.grey,
          ),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Text(
                'Nama Program',
                style: GoogleFonts.manrope(
                  textStyle: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            width: 350,
            height: 46,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Color(0xFF757575),
              ),
            ),
            child: TextFormField(
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
                hintText: 'Nama Program',
                hintStyle: TextStyle(
                    fontSize: 16, color: Colors.black.withOpacity(0.20)),
              ),
            ),
          ),
          SizedBox(height: 25),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Text(
                'Target Pengeluaran',
                style: GoogleFonts.manrope(
                  textStyle: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            width: 350,
            height: 46,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Color(0xFF757575),
              ),
            ),
            child: TextFormField(
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
                hintText: 'Target Pengeluaran',
                hintStyle: TextStyle(
                    fontSize: 16, color: Colors.black.withOpacity(0.20)),
              ),
            ),
          ),
          SizedBox(height: 25),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Text(
                'Jadwal Program',
                style: GoogleFonts.manrope(
                  textStyle: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            width: 350,
            height: 46,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Color(0xFF757575), // Warna stroke
              ),
            ),
            child: TextFormField(
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
                hintText: 'Jadwal Program',
                hintStyle: TextStyle(
                    fontSize: 16, color: Colors.black.withOpacity(0.20)),
              ),
            ),
          ),
          SizedBox(height: 25),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Text(
                'Ketentuan Program',
                style: GoogleFonts.manrope(
                  textStyle: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            width: 350,
            height: 46,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Color(0xFF757575), // Warna stroke
              ),
            ),
            child: TextFormField(
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
                hintText: 'Ketentuan Program',
                hintStyle: TextStyle(
                    fontSize: 16, color: Colors.black.withOpacity(0.20)),
              ),
            ),
          ),
          SizedBox(height: 30),
          Container(
            width: 350,
            height: 46,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 56, 122, 223),
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: TextButton(
              onPressed: () {
              },
              child: Text(
                'Unggah Program Kelas',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
