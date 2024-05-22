import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TextShimmer extends StatelessWidget {
  final double width, height;
  const TextShimmer({Key? key, required this.width, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Shimmer.fromColors(
        child: Container(
          height: height,
          width: width,
          color: Colors.white,
        ),
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade400);
  }
}
