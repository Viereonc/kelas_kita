
abstract class Route{
  Route._();

  static const SPLASHSCREEN_PAGE = Path.SPLASHSCREEN_PAGE;
  static const HOMESCREEN_PAGE = Path.HOMESCREEN_PAGE;
}

abstract class Path{
  Path._();

  static const SPLASHSCREEN_PAGE = "/";
  static const HOMESCREEN_PAGE = "/homescreen";
}