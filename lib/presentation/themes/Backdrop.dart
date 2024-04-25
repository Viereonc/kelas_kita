import 'package:flutter/material.dart';
import 'Colors.dart';

//BackDrop
BoxShadow primaryBackDrop({
  double? opacity
}) => BoxShadow(
  color: primeryColorDark.withOpacity(opacity ?? 0.5),
  offset: Offset(0, 0),
  blurRadius: 12,
);
