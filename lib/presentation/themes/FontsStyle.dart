import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//Font Family
TextStyle tsHeader1({
  required double screenSize,
  FontWeight? fontWeight,
  Color? color,
}) => GoogleFonts.manrope(
  textStyle: TextStyle(
    color: color ?? Colors.black,
    fontSize: screenSize * 0.08,
    fontWeight: fontWeight ?? FontWeight.w700,
  ),
);

TextStyle tsHeader2({
  required double screenSize,
  FontWeight? fontWeight,
  Color? color,
}) => GoogleFonts.manrope(
  textStyle: TextStyle(
    color: color ?? Colors.black,
    fontSize: screenSize * 0.06,
    fontWeight: fontWeight ?? FontWeight.w700,
  ),
);

TextStyle tsHeader3({
  required double screenSize,
  FontWeight? fontWeight,
  Color? color,
}) => GoogleFonts.manrope(
  textStyle: TextStyle(
    color: color ?? Colors.black,
    fontSize: screenSize * 0.05,
    fontWeight: fontWeight ?? FontWeight.w700,
  ),
);

TextStyle tsSubHeader1({
  required double screenSize,
  FontWeight? fontWeight,
  Color? color,
}) => GoogleFonts.manrope(
  textStyle: TextStyle(
    color: color ?? Colors.black,
    fontSize: screenSize * 0.08,
    fontWeight: fontWeight ?? FontWeight.w600,
  ),
);

TextStyle tsSubHeader2({
  required double screenSize,
  FontWeight? fontWeight,
  Color? color
}) => GoogleFonts.manrope(
  textStyle: TextStyle(
    color: color ?? Colors.black,
    fontSize: screenSize * 0.06,
    fontWeight: fontWeight ?? FontWeight.w600,
  ),
);

TextStyle tsSubHeader3({
  required double screenSize,
  FontWeight? fontWeight,
  Color? color
}) => GoogleFonts.manrope(
  textStyle: TextStyle(
    color: color ?? Colors.black,
    fontSize: screenSize * 0.05,
    fontWeight: fontWeight ?? FontWeight.w600,
  ),
);

TextStyle tsSubHeader4({
  required double screenSize,
  FontWeight? fontWeight,
  Color? color
}) => GoogleFonts.manrope(
  textStyle: TextStyle(
    color: color ?? Colors.black,
    fontSize: screenSize * 0.04,
    fontWeight: fontWeight ?? FontWeight.w600,
  ),
);

TextStyle tsSubHeader5({
  required double screenSize,
  FontWeight? fontWeight,
  Color? color
}) => GoogleFonts.manrope(
  textStyle: TextStyle(
    color: color ?? Colors.black,
    fontSize: screenSize * 0.03,
    fontWeight: fontWeight ?? FontWeight.w600,
  ),
);

TextStyle tsSubHeader6({
  required double screenSize,
  FontWeight? fontWeight,
  Color? color
}) => GoogleFonts.manrope(
  textStyle: TextStyle(
    color: color ?? Colors.black,
    fontSize: screenSize * 0.02,
    fontWeight: fontWeight ?? FontWeight.w600,
  ),
);

TextStyle tsParagraft1({
  required double screenSize,
  FontWeight? fontWeight,
  Color? color
}) => GoogleFonts.poppins(
  textStyle: TextStyle(
    color: color ?? Colors.black,
    fontSize: screenSize * 0.06,
    fontWeight: fontWeight ?? FontWeight.w500,
  ),
);

TextStyle tsParagraft2({
  required double screenSize,
  FontWeight? fontWeight,
  Color? color
}) => GoogleFonts.poppins(
  textStyle: TextStyle(
    color: color ?? Colors.black,
    fontSize: screenSize * 0.05,
    fontWeight: fontWeight ?? FontWeight.w500,
  ),
);

TextStyle tsParagraft3({
  required double screenSize,
  FontWeight? fontWeight,
  Color? color
}) => GoogleFonts.poppins(
  textStyle: TextStyle(
    color: color ?? Colors.black,
    fontSize: screenSize * 0.04,
    fontWeight: fontWeight ?? FontWeight.w500,
  ),
);

TextStyle tsParagraft4({
  required double screenSize,
  FontWeight? fontWeight,
  Color? color
}) => GoogleFonts.poppins(
  textStyle: TextStyle(
    color: color ?? Colors.black,
    fontSize: screenSize * 0.03,
    fontWeight: fontWeight ?? FontWeight.w500,
  ),
);

TextStyle tsParagraft5({
  required double screenSize,
  FontWeight? fontWeight,
  Color? color
}) => GoogleFonts.poppins(
  textStyle: TextStyle(
    color: color ?? Colors.black,
    fontSize: screenSize * 0.02,
    fontWeight: fontWeight ?? FontWeight.w500,
  ),
);