import 'package:get/get.dart';

class AgendaController extends GetxController {
  var agendaList = [].obs;

  void addAgenda(String title, String content) {
    agendaList.add({"title": title, "content": content});
  }
}
