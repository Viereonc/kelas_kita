import 'package:flutter/material.dart';
import 'package:kelas_kita/presentation/themes/FontsStyle.dart';

class ButtonLoginRegister extends StatelessWidget {
  final String label;
  final Color textColor;
  final TextStyle textStyle;
  final Color backgroundColor;
  // final ShapeBorder shape;
  final BorderSide side;
  final VoidCallback onPressed;

  const ButtonLoginRegister({
    Key? key,
    required this.label,
    required this.textStyle,
    required this.textColor,
    required this.backgroundColor,
    // required this.shape,
    required this.side,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.only(left: screenWidth * 0.1, right: screenWidth * 0.1),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          surfaceTintColor: Colors.white,
          backgroundColor: backgroundColor,
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01, vertical: screenHeight * 0.02),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: side,
          )
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(color: textColor, fontSize: 20),
          ),
        ),
      ),
    );
  }
}

class ButtonLogOut extends StatelessWidget {
  final String label;
  final Color textColor;
  final TextStyle textStyle;
  final Color backgroundColor;
  // final ShapeBorder shape;
  final BorderSide side;
  final VoidCallback onPressed;

  const ButtonLogOut({
    Key? key,
    required this.label,
    required this.textStyle,
    required this.textColor,
    required this.backgroundColor,
    // required this.shape,
    required this.side,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            surfaceTintColor: Colors.white,
            backgroundColor: backgroundColor,
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01, vertical: screenHeight * 0.02),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: side,
            )
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.logout, size: 32, color: Colors.white,),
              Text(
                label,
                style: tsSubHeader3(fontWeight: FontWeight.bold).copyWith(color: Colors.white),
              ),
              Icon(Icons.logout, size: 32, color: Color(0xFFFF2D2D),),
            ],
          ),
        ),
      ),
    );
  }
}
