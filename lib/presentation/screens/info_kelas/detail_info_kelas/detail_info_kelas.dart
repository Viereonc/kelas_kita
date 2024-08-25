import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../constants.dart';
import '../../../themes/Colors.dart';
import '../../../themes/FontsStyle.dart';

class DetailInfoKelas extends StatelessWidget {
  final String image;
  final String description;

  const DetailInfoKelas({Key? key, required this.image, required this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              Container(
                child: AppBar(
                  backgroundColor: Colors.white,
                  surfaceTintColor: Colors.white,
                  title: Text("Pengumuman", style: tsHeader2(screenSize: screenWidth),),
                  centerTitle: true,
                  leading: Container(
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Container(
                        decoration: BoxDecoration(
                          color: primeryColorMedium,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                            child: Icon(Icons.arrow_back_ios_new, color: Colors.white)),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Divider(
                color: Colors.grey,
                thickness: 0.5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: screenHeight * 0.03),
                    child: image.isNotEmpty
                        ? ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network(
                        baseUrl + storage + image,
                        width: double.infinity,
                        height: screenHeight * 0.23,
                        fit: BoxFit.cover,
                        errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                          return Center(
                            child: Icon(
                              Icons.image_not_supported_outlined,
                              color: Colors.grey.shade300,
                              size: screenWidth * 0.3,
                            ),
                          );
                        },
                      ),
                    )
                        : SizedBox(
                      width: double.infinity,
                      height: screenHeight * 0.23,
                      child: Container(),
                    ),
                  ),
                  Text(
                    textAlign: TextAlign.start,
                    description,
                    style: tsParagraft3(screenSize: screenWidth),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
