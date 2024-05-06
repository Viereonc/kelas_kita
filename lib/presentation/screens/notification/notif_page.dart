import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notification',
          style: TextStyle(fontSize: 24.0), // Set font size to 24.0
        ),
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              "lib/assets/icons/adjusments.svg",
              width: 30.0,
              height: 30.0,
            ),
            onPressed: () {
              // Tambahkan logika yang ingin Anda jalankan saat ikon ditekan
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 8.0),
            child: Container(
              color: Colors.grey,
              height: 1.0,
            ),
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(top: 8.0), // Add space at the top of the ListView
        itemCount: 1,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0), // Add margin from the sides
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: const Color(0xFFF2F2F2), // Set border color to F2F2F2
                  width: 1.0,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    "lib/assets/icons/task.svg",
                    width: 40.0, // Set width to 32.0
                    height: 40.0, // Set height to 32.0
                  ),
                  SizedBox(width: 8.0), // Add some space between icon and text
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tugas CRUD',
                          style: TextStyle(
                            fontSize: 16.0, // Set font size to 16.0
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          'Tugas Laravel CRUD dari Fahmi sudah lewat deadline',
                          style: const TextStyle(fontSize: 14.0), // Set font size to 14.0
                        ),
                      ],
                    ),
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

