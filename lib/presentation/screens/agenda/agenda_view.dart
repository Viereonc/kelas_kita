import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../themes/Colors.dart';
import '../../themes/FontsStyle.dart';
import 'add_agenda_view.dart';
import 'agenda_controller.dart';
import 'detail_agenda.dart';

class AgendaScreen extends StatelessWidget {
  AgendaScreen({Key? key}) : super(key: key);
  final AgendaController agendaController = Get.put(AgendaController());

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            Container(
              child: AppBar(
                surfaceTintColor: Colors.white,
                title: Text(
                  "Note",
                  style: tsHeader2(
                    screenSize: screenWidth,
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
                          child: Icon(Icons.arrow_back_ios_new,
                              color: Colors.white)),
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
            Expanded(
              child: Obx(() {
                if (agendaController.isLoading.value) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView.separated(
                    itemCount: agendaController.agendaList.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider(
                        color: Colors.grey,
                        thickness: 0.5,
                      );
                    },
                    itemBuilder: (BuildContext context, int index) {
                      final agenda = agendaController.agendaList[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailAgenda(
                                title: agenda["title"],
                                content: agenda["content"],
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01, vertical: screenHeight * 0.015),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                            ),
                            height: screenHeight * 0.15,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "10 Maret 2024,",
                                      style: tsHeader3(
                                        screenSize: screenWidth,
                                      ).copyWith(color: secondaryColorDark),
                                    ),
                                    SizedBox(width: screenWidth * 0.005),
                                    Text(
                                      "Minggu",
                                      style: tsParagraft4(
                                        screenSize: screenWidth,
                                      ).copyWith(color: Colors.grey),
                                    )
                                  ],
                                ),
                                Container(
                                  width: screenWidth * 0.5,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        agenda["title"],
                                        style: tsHeader3(
                                          screenSize: screenWidth
                                        ),
                                      ),
                                      SizedBox(height: 5,),
                                      Text(
                                        agenda["content"],
                                        style: tsParagraft4(
                                          screenSize: screenWidth
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              }),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Container(
        child: FloatingActionButton(
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddAgenda()),
            );

            if (result != null) {
              agendaController.addAgenda(result["title"], result["content"]);
            }
          },
          shape: CircleBorder(),
          backgroundColor: primeryColorMedium,
          child: Icon(Icons.add, color: Colors.white, size: 34),
        ),
      ),
    );
  }
}
