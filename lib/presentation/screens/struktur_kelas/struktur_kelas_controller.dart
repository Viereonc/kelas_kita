import 'package:get/get.dart';
import 'models/model_struktur.dart';

class StrukturKelasController extends GetxController {
  var isLoading = true.obs;
  var classMembers = <ClassMember>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadLoading();
    loadClassMembers();
  }

  void loadLoading() async {
    await Future.delayed(Duration(seconds: 3));
    isLoading.value = false;
  }

  void loadClassMembers() {
    classMembers.addAll([
      ClassMember(
        name: 'Dwi Janto',
        role: 'Wali Kelas',
        absen: '01',
        alamat: 'Desa Mayong, Jepara',
        nis: '04987',
        phone: '088987654321',
        image: 'assets/images/pak_dwi.png',
      ),
      ClassMember(
        name: 'Asyella Veratia Azahra Putri Qodri',
        role: 'Ketua Kelas',
        absen: '06',
        alamat: 'Loram Kulon, Kudus',
        nis: '04997',
        phone: '081543987612',
        image: '',
      ),
      ClassMember(
        name: 'Vicko Amelino',
        role: 'Wakil Ketua',
        absen: '34',
        alamat: 'Melati Lor, Kudus',
        nis: '21635',
        phone: '08913452689',
        image: '',
      ),
      ClassMember(
        name: 'Fawwaz Taufiqi Rachman',
        role: 'Bendahara',
        absen: '16',
        alamat: 'Besito, Kudus',
        nis: '53612',
        phone: '08512278903',
        image: '',
      ),
      ClassMember(
        name: 'Alya Rana Raya',
        role: 'Sekretaris',
        absen: '04',
        alamat: 'Besito, Kudus',
        nis: '04995',
        phone: '08172612678',
        image: '',
      ),
    ]);
  }
}