import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kelas_kita/data/models/agenda_model.dart';
import 'package:kelas_kita/presentation/screens/agenda/option_edit_delete.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../constants.dart';

class AgendaController extends GetxController {
  RxList<InfoAgendaModel> agendaList = <InfoAgendaModel>[].obs;
  RxList<InfoAgendaModel> filteredAgendaList = <InfoAgendaModel>[].obs;
  var isLoading = true.obs;

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getAgendas();
  }

  Future<void> getAgendas() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    int? userId = prefs.getInt('id_user');

    final url = Uri.parse('$baseUrl$noteUserEndPoint');
    try {
      var response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        List<InfoAgendaModel> fetchedData = (jsonResponse as List)
            .map((data) => InfoAgendaModel.fromJson(data))
            .toList();
        agendaList.value = fetchedData;
        filteredAgendaList.value = agendaList;
        isLoading.value = false;

        print('Agendas fetched successfully');
      } else {
        print('Failed to fetch agendas: ${response.body}');
      }
    } catch (e) {
      print('Error occurred while fetching agendas: $e');
    }
  }

  Future<void> addAgenda(String title, String content) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    int? userId = prefs.getInt('id_user');

    var newAgenda = {
      "id_user": userId,
      "judul": title,
      "isi": content,
    };

    final url = Uri.parse('$baseUrl$noteUserEndPoint');
    try {
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(newAgenda),
      );

      if (response.statusCode == 201) {
        print('Agenda added successfully');
        getAgendas();
      } else {
        print('Failed to add agenda: ${response.body}');
      }
    } catch (e) {
      print('Error occurred while adding agenda: $e');
    }
  }

  Future<void> deleteAgenda(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    int? userId = prefs.getInt('id_user');

    final agenda = agendaList[index];
    final agendaId = agenda.idNote;

    final url = Uri.parse('$baseUrl$noteUserEndPoint/$agendaId');
    try {
      var response = await http.delete(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        print('Agenda deleted successfully');
        agendaList.removeAt(index); // Remove from local list
        filteredAgendaList.value = agendaList;
      } else {
        print('Failed to delete agenda: ${response.body}');
      }
    } catch (e) {
      print('Error occurred while deleting agenda: $e');
    }
  }

  void openIconButtonpressed(BuildContext context, int index, String title, String content) {
    int originalIndex = getOriginalIndex(index);
    showModalBottomSheet(
      context: context,
      builder: (ctx) => OptionEditDeleteAgenda(index: originalIndex, title: title, content: content),
    );
  }

  void initializeValues(String title, String content) {
    titleController.text = title;
    contentController.text = content;
  }

  Future<void> editAgenda(int index, String title, String content) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    int? userId = prefs.getInt('id_user');

    // Retrieve agenda ID from the list instead of shared preferences
    final agenda = agendaList[index];
    final agendaId = agenda.idNote;

    // If the agenda ID is null, return early
    if (agendaId == null) {
      print('Agenda ID is null. Cannot edit agenda.');
      return;
    }

    var updatedAgenda = {
      "judul": title,
      "isi": content,
    };

    final url = Uri.parse('$baseUrl$noteUserEndPoint/$agendaId');
    try {
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(updatedAgenda),
      );

      if (response.statusCode == 200) {
        print('Agenda updated successfully');
        agendaList[index] = InfoAgendaModel.fromJson(json.decode(response.body));
        filteredAgendaList.value = agendaList;
      } else {
        print('Failed to update agenda: ${response.body}');
      }
    } catch (e) {
      print('Error occurred while updating agenda: $e');
    }
  }

  // Method to get original index
  int getOriginalIndex(int displayedIndex) {
    int originalIndex = agendaList.length - 1 - displayedIndex;
    return originalIndex;
  }

  // New method to handle search
  void searchAgenda(String query) {
    if (query.isEmpty) {
      filteredAgendaList.value = agendaList;
    } else {
      filteredAgendaList.value = agendaList.where((agenda) {
        return agenda.judul.toLowerCase().contains(query.toLowerCase()) ||
            agenda.isi.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
  }
}
