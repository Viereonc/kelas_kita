import 'package:flutter/material.dart';
import 'package:kelas_kita/presentation/themes/FontsStyle.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final Color textColor;
  final TextStyle textStyle;
  final Color backgroundColor;
  // final ShapeBorder shape;
  final BorderSide side;
  final VoidCallback onPressed;

  const CustomButton({
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

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        surfaceTintColor: Colors.white,
        backgroundColor: backgroundColor,
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1, vertical: screenHeight * 0.015),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: side,
        )
      ),
      child: Center(
        child: Text(
          label,
          style: tsSubHeader4(color: textColor),
        ),
      ),
    );
  }
}
