abstract class Route {
  Route._();

  static const SPLASHSCREEN_PAGE = Path.SPLASHSCREEN_PAGE;
  static const ONBOARDING_PAGE = Path.ONBOARDING_PAGE;
  static const HOMESCREEN_PAGE = Path.HOMESCREEN_PAGE;
  static const LOGINVIEW_PAGE = Path.LOGINVIEW_PAGE;
  static const REGISTERVIEW_PAGE = Path.REGISTERVIEW_PAGE;
}

abstract class Path {
  Path._();

  static const SPLASHSCREEN_PAGE = "/";
  static const ONBOARDING_PAGE = "/onboarding";
  static const HOMESCREEN_PAGE = "/homescreen";
  static const LOGINVIEW_PAGE = "/loginview";
  static const REGISTERVIEW_PAGE = "/registerview";
}
