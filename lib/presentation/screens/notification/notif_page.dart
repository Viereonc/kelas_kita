import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kelas_kita/presentation/screens/notification/notif_controller.dart';
import 'package:kelas_kita/presentation/themes/Colors.dart';
import 'package:kelas_kita/presentation/themes/FontsStyle.dart';
import 'package:timeago/timeago.dart' as timeago; // Import timeago for time formatting

import '../../widgets/BottomNavigationBar/BottomNavigationBar.dart';
import '../../widgets/BottomNavigationBarGuru/BottomNavigationBar.dart';

class NotificationPage extends StatelessWidget {
  NotificationPage({super.key}) {}

  static const route = '/notification';

  final NotifController notifController = Get.put(NotifController());

  Future<void> _refreshData(BuildContext context) async {
    return notifController.fetchInfoNotif();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: screenHeight * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Notification',
                    style: tsParagraft1(
                      fontWeight: FontWeight.w600,
                      screenSize: screenWidth,
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.grey,
              thickness: 0.5,
            ),
            Expanded(
              child: Obx(() => notifController.isLoading.value
                  ? Center(child: CircularProgressIndicator())
                  : notifController.notifList.isEmpty
                  ? Center(child: Text("No notifications available."))
                  : RefreshIndicator(
                onRefresh: () => _refreshData(context),
                child: ListView.builder(
                  itemCount: notifController.notifList.length,
                  itemBuilder: (context, index) {
                    final notif = notifController.notifList[index];
                    final createdAt = notif.createdAt;
                    final timeAgo = timeago.format(createdAt);

                    return Column(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Container(
                                      margin: EdgeInsets.only(right: screenWidth * 0.03),
                                      child: Container(
                                          padding: EdgeInsets.all(15),
                                          margin: EdgeInsets.only(right: 5),
                                          decoration: BoxDecoration(
                                              color: primeryColorMedium,
                                              shape: BoxShape.circle
                                          ),
                                          child: Icon(Icons.notifications, color: Colors.white,)
                                      )
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: screenWidth * 0.5,
                                        child: Text(
                                            notif.title,
                                            style: tsParagraft3(
                                                fontWeight: FontWeight.w600,
                                                screenSize: screenWidth
                                            )
                                        ),
                                      ),
                                      SizedBox(height: 5,),
                                      Container(
                                        width: screenWidth * 0.5,
                                        child: Text(
                                            notif.message,
                                            style: tsParagraft5(screenSize: screenWidth)
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              // Text(
                              //   timeAgo,
                              //   style: tsParagraft5(
                              //     screenSize: screenWidth,
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.grey,
                          thickness: 0.5,
                        ),
                      ],
                    );
                  },
                ),
              )),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        margin: EdgeInsets.only(top: 30),
        height: 64,
        width: 64,
        child: FloatingActionButton(
          onPressed: () {
            if (notifController.userStatus.value == 'Wali Kelas') {
              Get.toNamed('/qrcodeguruscreen');
            } else {
              Get.toNamed('/qrcodesiswascreen');
            }
          },
          backgroundColor: primeryColorMedium,
          elevation: 0,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 3, color: Colors.white),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Icon(
            Icons.qr_code,
            color: Colors.white,
          ),
        ),
      ),
      bottomNavigationBar: Obx(() {
        if (notifController.userStatus.value == 'Wali Kelas') {
          return BottomNavbarGuru();
        } else {
          return BottomNavbar();
        }
      }),
    );
  }
}
