import 'package:get/get.dart';
import 'package:kelas_kita/presentation/screens/jadwal/jadwal_piket_model.dart';

class JadwalPiketController extends GetxController {
  var isLoading = true.obs;
  var selectedDay = 'Sen';

  @override
  void onInit() {
    super.onInit();
    loadLoading();
  }

  void loadLoading() async {
    await Future.delayed(Duration(seconds: 3));
    isLoading.value = false;
  }

  final List<ScheduleItem> scheduleItems = [
    ScheduleItem(name: 'Abid', day: 'Sen'),
    ScheduleItem(name: 'Adam', day: 'Sen'),
    ScheduleItem(name: 'Baratha', day: 'Sen'),
    ScheduleItem(name: 'Yasa', day: 'Sel'),
    ScheduleItem(name: 'Piu', day: 'Sel'),
    ScheduleItem(name: 'Nares', day: 'Sel'),
    ScheduleItem(name: 'Adit', day: 'Rab'),
    ScheduleItem(name: 'Kia', day: 'Rab'),
    ScheduleItem(name: 'Asyela', day: 'Rab'),
    ScheduleItem(name: 'Calista', day: 'Kam'),
    ScheduleItem(name: 'Arvi', day: 'Kam'),
    ScheduleItem(name: 'Mario', day: 'Kam'),
    ScheduleItem(name: 'Zidan', day: 'Jum'),
    ScheduleItem(name: 'Faris', day: 'Jum'),
    ScheduleItem(name: 'Mario', day: 'Jum'),
    ScheduleItem(name: 'Vicko', day: 'Sab'),
    ScheduleItem(name: 'Caesa', day: 'Sab'),
    ScheduleItem(name: 'Izal', day: 'Sab'),
  ];

  List<ScheduleItem> getScheduleForDay(String day) {
    return scheduleItems.where((item) => item.day == day).toList();
  }

  void selectDay(String day) {
    selectedDay = day;
    update();
  }
}
