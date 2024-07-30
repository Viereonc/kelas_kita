import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import Get untuk penggunaan GetX
import '../../../themes/Colors.dart';
import '../../../themes/FontsStyle.dart';
import '../agenda_controller.dart'; // Import AgendaController yang telah kita buat sebelumnya

class EditAgendaScreen extends StatelessWidget {
  final String title;
  final String content;
  final int index;

  EditAgendaScreen({Key? key, required this.title, required this.content, required this.index}) : super(key: key);

  final AgendaController agendaController = Get.find();

  @override
  Widget build(BuildContext context) {
    agendaController.initializeValues(title, content);

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
                  title: Container(
                    margin: EdgeInsets.only(top: screenHeight * 0.05),
                    width: screenWidth * 0.6,
                    height: screenHeight * 0.12,
                    child: TextField(
                      controller: agendaController.titleController,
                      textAlign: TextAlign.center,
                      style: tsHeader2(
                        screenSize: screenWidth
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Judul",
                        hintStyle: tsHeader2(
                          screenSize: screenWidth
                        ),
                      ),
                    ),
                  ),
                  centerTitle: true,
                  leading: Container(
                    child: IconButton(
                      onPressed: () {
                        agendaController.editAgenda(index, agendaController.titleController.text, agendaController.contentController.text);
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
              TextField(
                controller: agendaController.contentController,
                style: tsParagraft4(
                  screenSize: screenWidth
                ),
                maxLines: null,
                decoration: InputDecoration(
                  hintText: 'Tulis sesuatu disini',
                  border: InputBorder.none,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
