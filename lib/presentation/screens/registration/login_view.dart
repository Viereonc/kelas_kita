import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kelas_kita/presentation/registration/register_view.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(top: 48.0, left: 16.0),
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
                  SizedBox(height: 4),
                  Text(
                    'Login to continue',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black
                            .withOpacity(0.3), 
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
              padding: EdgeInsets.only(top: 128.0),
              child: Image.asset(
                'lib/assets/images/lr_login.png',
                width: screenWidth * 0.80,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(
                  top: 360.0,
                  left: 40.0,
                  right: 40.0), 
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      height:
                          24),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Email',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 12.0,
                          horizontal: 10.0),
                    ),
                    textInputAction: TextInputAction
                        .next, 
                    onEditingComplete: () => FocusScope.of(context)
                        .nextFocus(),
                  ),
                  SizedBox(
                      height:
                          24), 
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 12.0,
                          horizontal: 10.0),
                    ),
                    textInputAction: TextInputAction
                        .done,
                    onEditingComplete: () => FocusScope.of(context)
                        .unfocus(), 
                  ),
                  SizedBox(
                      height:
                          30), 
                  GestureDetector(
                    onTap: () {
                    },
                    child: Text(
                      'Forgot Password?',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF387ADF),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    height: 45  ,
                    decoration: BoxDecoration(
                      color: Color(0xFF387ADF),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Login',
                        style: GoogleFonts.manrope(
                          textStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                      height:
                          24),
                  Row(
                    children: [
                      Expanded(
                          child: Divider(color: Colors.black, thickness: 1)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'atau login dengan',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                          child: Divider(color: Colors.black, thickness: 1)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          'lib/assets/images/logos_google-icon.png',
                          width: 30,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.facebook,
                          size: 40,
                          color: Colors
                              .blue, 
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                      height:
                          16),
                  Center(
                      child: Text(
                        'Tidak punya akun? Register disini',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  SizedBox(height: 30),
                  Center(
                    child: SizedBox(
                      width: 360,
                      height: 44,
                      child: OutlinedButton(
                        onPressed: () {
                          // Aksi ketika tombol Register ditekan
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => RegisterView()),
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
                          'Register',
                          style: TextStyle(
                            color: const Color(0xFF387ADF),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
