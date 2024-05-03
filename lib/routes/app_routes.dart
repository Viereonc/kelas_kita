abstract class Route {
  Route._();

  static const SPLASHSCREEN_PAGE = Path.SPLASHSCREEN_PAGE;
  static const ONBOARDING_PAGE = Path.ONBOARDING_PAGE;
  static const LOGINVIEW_PAGE = Path.LOGINVIEW_PAGE;
  static const REGISTERVIEW_PAGE = Path.REGISTERVIEW_PAGE;
  static const HOMESCREEN_PAGE = Path.HOMESCREEN_PAGE;
  static const NOTIFICATION_PAGE = Path.NOTIFICATION_PAGE;
  static const STRUKTURKELAS_PAGE = Path.STRUKTURKELAS_PAGE;
  static const PROFILE_PAGE = Path.PROFILE_PAGE;
}

abstract class Path {
  Path._();

  static const SPLASHSCREEN_PAGE = "/";
  static const ONBOARDING_PAGE = "/onboarding";
  static const LOGINVIEW_PAGE = "/loginview";
  static const REGISTERVIEW_PAGE = "/registerview";
  static const HOMESCREEN_PAGE = "/homescreen";
  static const NOTIFICATION_PAGE = "/notification";
  static const STRUKTURKELAS_PAGE = "/strukturkelasscreen";
  static const PROFILE_PAGE = "/profilescreen";
}