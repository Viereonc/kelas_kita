import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoadingContainer1 extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;
  final Color primeryColorDark;

  const ShimmerLoadingContainer1({
    Key? key,
    required this.screenWidth,
    required this.screenHeight,
    required this.primeryColorDark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
        height: screenHeight * 0.15,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.grey,
            width: screenWidth * 0.003,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: screenWidth * 0.65,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(13),
                  bottomRight: Radius.circular(10),
                  bottomLeft: Radius.circular(13),
                ),
                color: primeryColorDark,
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: screenWidth * 0.2,
                    height: screenHeight * 0.02,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Container(
                    width: screenWidth * 0.08,
                    height: screenWidth * 0.08,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShimmerLoadingIcons extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;

  const ShimmerLoadingIcons({
    Key? key,
    required this.screenWidth,
    required this.screenHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        margin: EdgeInsets.only(right: screenWidth * 0.03, left: screenWidth * 0.03, top: screenHeight * 0.05),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(5, (index) {
            return Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: screenHeight * 0.01),
                  width: screenWidth * 0.15,
                  height: screenWidth * 0.15,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                    color: Colors.grey[300],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[300],
                  ),
                  width: screenWidth * 0.1,
                  height: screenHeight * 0.02,
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}

class ShimmerLoadingListView extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;

  const ShimmerLoadingListView({
    Key? key,
    required this.screenWidth,
    required this.screenHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        itemCount: 9,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
            child: Container(
              padding: EdgeInsets.only(left: screenWidth * 0.05),
              height: screenHeight * 0.11,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[300],
              ),
              child: Row(
                children: [
                  Container(
                    height: screenWidth * 0.12,
                    width: screenWidth * 0.12,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  SizedBox(width: 20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: screenWidth * 0.6,
                        height: screenHeight * 0.02,
                        color: Colors.grey[400],
                      ),
                      Container(
                        width: screenWidth * 0.4,
                        height: screenHeight * 0.02,
                        color: Colors.grey[400],
                      ),
                      Container(
                        width: screenWidth * 0.3,
                        height: screenHeight * 0.02,
                        color: Colors.grey[400],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
