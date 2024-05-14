import 'package:get/get.dart';
import 'package:kelas_kita/presentation/registration/form_biografi.dart';
import 'package:kelas_kita/presentation/screens/SplashScreen.dart';
import 'package:kelas_kita/presentation/screens/home/home_view.dart';
import 'package:kelas_kita/presentation/screens/onboarding/onboarding_view.dart';
import 'package:kelas_kita/presentation/registration/login_view.dart';
import 'package:kelas_kita/presentation/registration/register_view.dart';
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
        name: Path.BIOGRAFIVIEW_PAGE,
        page: () => BiografiView(),
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
        name: Path.PROFILE_PAGE,
        page: () => ProfileScreen(),
        transition: Transition.noTransition
    ),
  ];
}