import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kelas_kita/presentation/screens/agenda/agenda_controller.dart';
import 'package:kelas_kita/presentation/screens/agenda/edit_agenda/edit_agenda_view.dart';
import 'package:kelas_kita/presentation/themes/FontsStyle.dart';

class OptionEditDeleteAgenda extends StatelessWidget {
  final String title;
  final String content;
  final int index;

  const OptionEditDeleteAgenda({Key? key, required this.index, required this.title, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    final AgendaController agendaController = Get.find();

    return Container(
      height: screenHeight / 3.5,
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Center(
                child: Text(
                  "Informasi Kelas",
                  style: tsSubHeader3(screenSize: screenWidth),
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, itemIndex) {
                  List<Map<String, dynamic>> items = [
                    {
                      'icon': Icons.edit,
                      'title': 'Edit',
                      'color': Colors.orange,
                    },
                    {
                      'icon': Icons.delete,
                      'title': 'Delete',
                      'color': Colors.red,
                    },
                  ];

                  final item = items[itemIndex];

                  return InkWell(
                    onTap: () async {
                      if (item['title'] == 'Delete') {
                        bool? result = await showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: Text("Konfirmasi Hapus"),
                            content: Text("Apakah Anda yakin ingin menghapus?"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop(false);
                                },
                                child: Text("Tidak"),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop(true);
                                },
                                child: Text("Ya"),
                              ),
                            ],
                          ),
                        );
                        if (result == true) {
                          agendaController.deleteAgenda(index);
                          Navigator.of(context).pop();
                        }
                      } else if (item['title'] == 'Edit') {
                        Navigator.pop(context); // Close the bottom sheet first
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditAgendaScreen(
                              title: title ?? "",
                              index: index,
                              content: content ?? "",
                            ),
                          ),
                        );
                      }
                    },
                    child: ListTile(
                      leading: Icon(
                        item['icon'],
                        color: item['color'],
                      ),
                      title: Text(
                        item['title'],
                        style: tsSubHeader4(screenSize: screenWidth),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  );
                },
                separatorBuilder: (context, itemIndex) => Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.1, right: screenWidth * 0.05),
                  child: Divider(),
                ),
                itemCount: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
