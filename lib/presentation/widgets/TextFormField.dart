import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget textFormField({
  required String label,
  required TextStyle labelStyle,
  required double height,
  TextEditingController? controller,
  TextInputType? textInputType,
  TextInputFormatter? inputFormatter,
  void Function(String)? onChanged,
  String? Function(String?)? validator,

}) {
  return Container(
    height: height,
    child: TextFormField(
      controller: controller,
      obscureText: label == "Password" ? true : false,
      keyboardType: label == "Nomor Telephone"
          ? TextInputType.phone
          : label == "Email"
          ? TextInputType.emailAddress
          : TextInputType.text,
      inputFormatters: label == "Nomor Handphone"
          ? <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
      ]
          : null,
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: labelStyle,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: Colors.black,
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black.withOpacity(0.5),
            width: 2.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black.withOpacity(0.2),
            width: 2.0,
          ),
        ),
      ),
    ),
  );
}

Widget textFormFieldTwo({
  required String label,
  required TextStyle labelStyle,
  required double height,
  TextEditingController? controller,
  TextInputType? textInputType,
  TextInputFormatter? inputFormatter,
  void Function(String)? onChanged,
  String? Function(String?)? validator,

}) {
  return Container(
    height: height,
    child: TextFormField(
      controller: controller,
      obscureText: label == "Password" ? true : false,
      keyboardType: label == "Nomor Telephone"
          ? TextInputType.phone
          : label == "Email"
          ? TextInputType.emailAddress
          : TextInputType.text,
      inputFormatters: label == "Nomor Handphone"
          ? <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
      ]
          : null,
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: labelStyle,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: Colors.black,
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black.withOpacity(0.5),
            width: 1.5,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black.withOpacity(0.3),
            width: 1.5,
          ),
        ),
      ),
    ),
  );
}
