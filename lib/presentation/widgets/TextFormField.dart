import 'package:flutter/material.dart';

Widget textFormField ({
  required String label,
  required TextStyle labelStyle,
  required double height,
}) {
  return Container(
    height: height,
    child: TextFormField(
      obscureText: label == "Password" ? true : false,
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
      ),
    ),
  );
}