import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kelas_kita/presentation/screens/agenda/option_edit_delete.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AgendaController extends GetxController {
  var agendaList = [].obs;
  var isLoading = true.obs;

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadAgendas();
  }

  void addAgenda(String title, String content) {
    agendaList.add({"title": title, "content": content});
    saveAgendas();
  }

  void openIconButtonpressed(BuildContext context, int index, String title, String content) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => OptionEditDeleteAgenda(index: index, title: title, content: content),
    );
  }

  void initializeValues(String title, String content) {
    titleController.text = title;
    contentController.text = content;
  }

  void editAgenda(int index, String title, String content) {
    agendaList[index] = {"title": title, "content": content ?? ""};
    saveAgendas();
  }

  void deleteAgenda(int index) {
    agendaList.removeAt(index);
    saveAgendas();
  }

  void saveAgendas() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(agendaList);
    prefs.setString('agenda_list', jsonString);
  }

  void loadAgendas() async {
    await Future.delayed(Duration(seconds: 3));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('agenda_list');
    if (jsonString != null) {
      List<dynamic> jsonList = jsonDecode(jsonString);
      agendaList.value = jsonList.map((item) => item as Map<String, dynamic>).toList();
    }
    isLoading.value = false;
  }
}
