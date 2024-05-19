import 'package:flutter/material.dart';

import '../../themes/Colors.dart';
import '../../themes/FontsStyle.dart';

class DetailAgenda extends StatelessWidget {
  final String title;
  final String content;

  const DetailAgenda({Key? key, required this.title, required this.content}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              Container(
                child: AppBar(
                  surfaceTintColor: Colors.white,
                  title: Text(
                    title,
                    style: tsHeader2(
                      screenSize: screenWidth
                    ),
                  ),
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
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  textAlign: TextAlign.start,
                  content,
                  style: tsParagraft4(
                    screenSize: screenWidth
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
