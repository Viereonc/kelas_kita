import 'package:get/get.dart';
import 'package:kelas_kita/presentation/registration/biografi/form_biografi.dart';
import 'package:kelas_kita/presentation/screens/infotugas/info_tugas.dart';
import 'package:kelas_kita/presentation/screens/pending/pending_view.dart';
import 'package:kelas_kita/presentation/screens/splashscreen/SplashScreen.dart';
import 'package:kelas_kita/presentation/screens/agenda/agenda_view.dart';
import 'package:kelas_kita/presentation/screens/home/home_view.dart';
import 'package:kelas_kita/presentation/screens/info_kelas/info_kelas_view.dart';
import 'package:kelas_kita/presentation/screens/jadwal/jadwal_view.dart';
import 'package:kelas_kita/presentation/screens/kas/kas_view.dart';
import 'package:kelas_kita/presentation/screens/onboarding/onboarding_view.dart';
import 'package:kelas_kita/presentation/registration/login/login_view.dart';
import 'package:kelas_kita/presentation/screens/pembukuan/Pembukuan_view.dart';
import 'package:kelas_kita/presentation/screens/profile/profile_view.dart';
import 'package:kelas_kita/presentation/screens/notification/notif_page.dart';
import 'package:kelas_kita/presentation/screens/struktur_kelas/struktur_kelas_view.dart';
import 'package:kelas_kita/routes/app_routes.dart';

import '../presentation/registration/register/register_view.dart';

class AppPages {
  static const INITIAL = Route.SPLASHSCREEN_PAGE;
  static const ONBOARDING = Route.ONBOARDINGVIEW_PAGE;
  static const LOGIN = Route.LOGINVIEW_PAGE;
  static const REGISTER = Route.REGISTERVIEW_PAGE;
  static const BIOGRAFI = Route.BIOGRAFIVIEW_PAGE;
  static const PENDING = Route.PENDING_PAGE;
  static const HOME = Route.HOMEVIEW_PAGE;
  static const NOTIFICATION = Route.NOTIFICATIONVIEW_PAGE;
  static const STRUKTURKELAS = Route.STRUKTURKELASVIEW_PAGE;
  static const INFOKELAS = Route.INFOKELASVIEW_PAGE;
  static const INFOTUGAS = Route.INFOTUGASVIEW_PAGE;
  static const PEMBUKUAN = Route.PEMBUKUANVIEW_PAGE;
  static const KAS = Route.KASVIEW_PAGE;
  static const AGENDA = Route.AGENDAVIEW_PAGE;
  static const PROFILE = Route.PROFILEVIEW_PAGE;
  static const JADWAL = Route.JADWALVIEW_PAGE;


  static final routes = [
    GetPage(
        name: Path.SPLASHSCREEN_PAGE,
        page: () => SplashScreen(),
        transition: Transition.noTransition
    ),
    GetPage(
        name: Path.ONBOARDING_PAGE,
        page: () => OnboardingScreen(),
        transition: Transition.noTransition),
    GetPage(
        name: Path.LOGIN_PAGE,
        page: () => LoginView(),
        transition: Transition.noTransition),
    GetPage(
        name: Path.REGISTER_PAGE,
        page: () => RegisterView(),
        transition: Transition.noTransition),
    GetPage(
        name: Path.BIOGRAFI_PAGE,
        page: () => BiografiView(),
        transition: Transition.noTransition),
    GetPage(
        name: Path.PENDING_PAGE,
        page: () => PendingScreen(),
        transition: Transition.noTransition),
    GetPage(
        name: Path.HOME_PAGE,
        page: () => HomeScreen(),
        transition: Transition.noTransition),
    GetPage(
        name: Path.NOTIFICATION_PAGE,
        page: () => NotificationPage(),
        transition: Transition.noTransition),
    GetPage(
        name: Path.STRUKTURKELAS_PAGE,
        page: () => StrukturKelasScreen(),
        transition: Transition.noTransition),
    GetPage(
        name: Path.INFOKELAS_PAGE,
        page: () => InfoKelasScreen(),
        transition: Transition.noTransition),
    GetPage(
        name: Path.INFOTUGAS_PAGE,
        page: () => InfoTugas(),
        transition: Transition.noTransition),
    GetPage(
        name: Path.PEMBUKUAN_PAGE,
        page: () => PembukuanView(),
        transition: Transition.noTransition),
    GetPage(
        name: Path.AGENDA_PAGE,
        page: () => AgendaScreen(),
        transition: Transition.noTransition),
    GetPage(
        name: Path.KAS_PAGE,
        page: () => KasScreen(),
        transition: Transition.noTransition),
    GetPage(
        name: Path.PROFILE_PAGE,
        page: () => ProfileScreen(),
        transition: Transition.noTransition),
    GetPage(
        name: Path.JADWAL_PAGE,
        page: () => JadwalScreen(),
        transition: Transition.noTransition),
  ];
}
