import 'package:get/get.dart';
import 'package:kelas_kita/presentation/screens/jadwal/model.dart';

class JadwalController extends GetxController {
  var isLoading = true.obs;
  var selectedDay = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadLoading();
    selectedDay.value = 'Sel';
  }

  void loadLoading() async {
    await Future.delayed(Duration(seconds: 3));
    isLoading.value = false;
  }

  final List<ScheduleItem> scheduleItems = [
  ScheduleItem(
    time: '07.40',
    subject: 'Bahasa Inggris',
    teacher: 'Mrs Ristina', 
    duration: '07.40 - 09.40',
    day: 'Sen',
  ),
  ScheduleItem(
    time: '09.40',
    subject: 'Bahasa Indonesia',
    teacher: 'Pak Fuad',
    duration: '09.40 - 11.40',
    day: 'Sen',
  ),
  ScheduleItem(
    time: '11.40',
    subject: 'Matematika',
    teacher: 'Bu Fauziyah Lisfana',
    duration: '11.40 - 13.40',
    day: 'Sen',
  ),
  ScheduleItem(
    time: '13.40',
    subject: 'Web Programming',
    teacher: 'Pak Fahmi Irsyad',
    duration: '13.40 - 15.40',
    day: 'Sen',
  ),
  // Selasa
  ScheduleItem(
    time: '07.40',
    subject: 'Dekstop Development/Iot',
    teacher: 'Pak Agus',
    duration: '07.40 - 09.40',
    day: 'Sel',
  ),
  ScheduleItem(
    time: '09.40',
    subject: 'Pkn',
    teacher: 'Bu Unik',
    duration: '09.40 - 11.40',
    day: 'Sel',
  ),
  ScheduleItem(
    time: '11.40',
    subject: 'Bahasa Jepang',
    teacher: 'Sensei Erike',
    duration: '11.40 - 13.40',
    day: 'Sel',
  ),
  ScheduleItem(
    time: '13.40',
    subject: 'Bahasa indonesia',
    teacher: 'Pak Aliridho',
    duration: '13.40 - 15.40',
    day: 'Sel',
  ),
  // Rabu
  ScheduleItem(
    time: '07.40',
    subject: 'Mobile Programing',
    teacher: 'Pak Aji Suryawan',
    duration: '07.40 - 09.40',
    day: 'Rab',
  ),
  ScheduleItem(
    time: '09.40',
    subject: 'Sejarah',
    teacher: 'Bu Vita',
    duration: '09.40 - 11.40',
    day: 'Rab',
  ),
  ScheduleItem(
    time: '11.40',
    subject: 'Bk',
    teacher: 'Bu Devita',
    duration: '11.40 - 13.40',
    day: 'Rab',
  ),
  ScheduleItem(
    time: '13.40',
    subject: 'Bahasa Jawa',
    teacher: 'Bu Widi',
    duration: '13.40 - 15.40',
    day: 'Rab',
  ),
  // Kamis
  ScheduleItem(
    time: '07.40',
    subject: 'Informatika',
    teacher: 'Pak Dwi Janto',
    duration: '07.40 - 09.40',
    day: 'Kam',
  ),
  ScheduleItem(
    time: '09.40',
    subject: 'Agama',
    teacher: 'Pak Ikhsyan',
    duration: '09.40 - 11.40',
    day: 'Kam',
  ),
  ScheduleItem(
    time: '13.00',
    subject: 'Bta',
    teacher: 'Pak Jumanto',
    duration: '11.40 - 13.40',
    day: 'Kam',
  ),
  // Jumat
  ScheduleItem(
    time: '07.40',
    subject: 'Pjok',
    teacher: 'Pak Imam',
    duration: '07.40 - 09.40',
    day: 'Jum',
  ),
  ScheduleItem(
    time: '09.40',
    subject: 'Bahasa Jawa',
    teacher: 'Bu Widi',
    duration: '09.40 - 10.40',
    day: 'Jum',
  ),
  ScheduleItem(
    time: '07.40',
    subject: 'Game Development',
    teacher: 'Pak Anjas',
    duration: '07.40 - 10.40',
    day: 'Sab',
  ),
  ScheduleItem(
    time: '10.40',
    subject: 'Pkn',
    teacher: 'Bu Unik',
    duration: '10.40 - 12.40',
    day: 'Sab',
  ),
  ScheduleItem(
    time: '11.40',
    subject: 'Sejarah',
    teacher: 'Bu Vita',
    duration: '12.40 - 14.40',
    day: 'Sab',
  ),
];


  List<ScheduleItem> getScheduleForDay(String day) {
    return scheduleItems.where((item) => item.day == day).toList();
  }

  void selectDay(String day) {
    selectedDay.value = day;
  }
}
