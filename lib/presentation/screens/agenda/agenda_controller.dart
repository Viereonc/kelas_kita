import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AgendaController extends GetxController {
  var agendaList = [].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadAgendas();
  }

  void addAgenda(String title, String content) {
    agendaList.add({"title": title, "content": content});
    saveAgendas();
  }

  void saveAgendas() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(agendaList);
    prefs.setString('agenda_list', jsonString);
  }

  void loadAgendas() async {
    await Future.delayed(Duration(seconds: 3)); // Simulate a delay for loading
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('agenda_list');
    if (jsonString != null) {
      List<dynamic> jsonList = jsonDecode(jsonString);
      agendaList.value = jsonList.map((item) => item as Map<String, dynamic>).toList();
    }
    isLoading.value = false;
  }
}
