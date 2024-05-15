import 'package:get/get.dart';
import 'package:kelas_kita/presentation/screens/SplashScreen.dart';
import 'package:kelas_kita/presentation/screens/agenda/agenda_view.dart';
import 'package:kelas_kita/presentation/screens/home/home_view.dart';
import 'package:kelas_kita/presentation/screens/jadwal/jadwal_view.dart';
import 'package:kelas_kita/presentation/screens/kas/kas_view.dart';
import 'package:kelas_kita/presentation/screens/onboarding/onboarding_view.dart';
import 'package:kelas_kita/presentation/registration/login_view.dart';
import 'package:kelas_kita/presentation/registration/register_view.dart';
import 'package:kelas_kita/presentation/screens/pembukuan/Pembukuan_view.dart';
import 'package:kelas_kita/presentation/screens/profile/profile_view.dart';
import 'package:kelas_kita/presentation/screens/notification/notif_page.dart';
import 'package:kelas_kita/presentation/screens/struktur_kelas/struktur_kelas_view.dart';
import 'package:kelas_kita/routes/app_routes.dart';

class AppPages{

  static const INITIAL = Route.SPLASHSCREEN_PAGE;
  static const ONBOARDING = Route.ONBOARDING_PAGE;
  static const LOGIN = Route.LOGINVIEW_PAGE;
  static const REGISTER = Route.REGISTERVIEW_PAGE;
  static const HOME = Route.HOMESCREEN_PAGE;
  static const NOTIFICATION = Route.NOTIFICATION_PAGE;
  static const STRUKTURKELAS = Route.STRUKTURKELAS_PAGE;
  static const PEMBUKUAN = Route.PEMBUKUAN_PAGE;
  static const KAS = Route.KAS_PAGE;
  static const JADWAL = Route.JADWAL_PAGE;
  static const AGENDA = Route.AGENDA_PAGE;
  static const PROFILE = Route.PROFILE_PAGE;

  static final routes = [

    GetPage(
      name: Path.SPLASHSCREEN_PAGE, 
      page: () => SplashScreen(),
      transition: Transition.noTransition
    ),
    GetPage(
        name: Path.ONBOARDING_PAGE,
        page: () => OnboardingScreen(),
        transition: Transition.noTransition
    ),
    GetPage(
        name: Path.LOGINVIEW_PAGE,
        page: () => LoginView(),
        transition: Transition.noTransition
    ),
    GetPage(
        name: Path.REGISTERVIEW_PAGE,
        page: () => RegisterView(),
        transition: Transition.noTransition
    ),
    GetPage(
        name: Path.HOMESCREEN_PAGE,
        page: () => HomeScreen(),
        transition: Transition.noTransition
    ),
    GetPage(
        name: Path.NOTIFICATION_PAGE,
        page: () => NotificationPage(),
        transition: Transition.noTransition
    ),
    GetPage(
        name: Path.STRUKTURKELAS_PAGE,
        page: () => StrukturKelasScreen(),
        transition: Transition.noTransition
    ),
    GetPage(
        name: Path.PEMBUKUAN_PAGE,
        page: () => PembukuanView(),
        transition: Transition.noTransition
    ),
    GetPage(
        name: Path.AGENDA_PAGE,
        page: () => AgendaScreen(),
        transition: Transition.noTransition
    ),
    GetPage(
        name: Path.KAS_PAGE,
        page: () => KasScreen(),
        transition: Transition.noTransition
    ),
    GetPage(
        name: Path.JADWAL_PAGE,
        page: () => JadwalView(),
        transition: Transition.noTransition
    ),
    GetPage(
        name: Path.PROFILE_PAGE,
        page: () => ProfileScreen(),
        transition: Transition.noTransition
    ),
  ];
}