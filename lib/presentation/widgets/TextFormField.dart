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
      inputFormatters: label == "Nomor Telephone"
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
      ),
    ),
  );
}
