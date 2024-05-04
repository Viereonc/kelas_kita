import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kelas_kita/presentation/registration/login_view.dart';    

class RegisterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(top: 60.0, left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Selamat Datang',
                    style: GoogleFonts.manrope(
                      textStyle: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Register to continue',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black.withOpacity(0.3),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: 165.0),
              child: Image.asset(
                'lib/assets/images/lr_register.png',
                width: screenWidth * 0.80,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(
                top: 420.0,
                left: 40.0,
                right: 40.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  Container(
                    width: 335,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(color: Color(0xFF6C6C6C), width: 1.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Username',
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Color(0xFF6C6C6C)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 28),
                  Container(
                    width: 335,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(color: Color(0xFF6C6C6C), width: 1.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Email',
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Color(0xFF6C6C6C)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 28),
                  Container(
                    width: 335,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(color: Color(0xFF6C6C6C), width: 1.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Color(0xFF6C6C6C)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 28),
                  Container(
                    width: 335,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Color(0xFF387ADF),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: TextButton(
                      onPressed: () {
                      },
                      child: Text(
                        'Register',
                        style: GoogleFonts.manrope(
                          textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: Text(
                      'Sudah punya akun? Login Disini',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
           Positioned(
            bottom: 50,
            left: 15,
            right: 15,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: 200,
                height: 45,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginView()),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      color: const Color(0xFF387ADF),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: const Color(0xFF387ADF),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
