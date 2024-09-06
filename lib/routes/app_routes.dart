abstract class Route {
  Route._();

  static const SPLASHSCREEN_PAGE = Path.SPLASHSCREEN_PAGE;
  static const ONBOARDINGVIEW_PAGE = Path.ONBOARDING_PAGE;
  static const LOGINVIEW_PAGE = Path.LOGIN_PAGE;
  static const INPUTEMAILVIEW_PAGE = Path.INPUTEMAIL_PAGE;
  static const REGISTERVIEW_PAGE = Path.REGISTER_PAGE;
  static const BIOGRAFIVIEW_PAGE = Path.BIOGRAFI_PAGE;
  static const PENDING_PAGE = Path.PENDING_PAGE;
  static const HOMEVIEW_PAGE = Path.HOME_PAGE;
  static const HOMEGURUVIEW_PAGE = Path.HOMEGURU_PAGE;
  static const NOTIFICATIONVIEW_PAGE = Path.NOTIFICATION_PAGE;
  static const STRUKTURKELASVIEW_PAGE = Path.STRUKTURKELAS_PAGE;
  static const STRUKTURKELASGURUVIEW_PAGE = Path.STRUKTURKELASGURU_PAGE;
  static const INFOKELASVIEW_PAGE = Path.INFOKELAS_PAGE;
  static const INFOTUGASVIEW_PAGE = Path.INFOTUGAS_PAGE;
  static const PEMBUKUANVIEW_PAGE = Path.PEMBUKUAN_PAGE;
  static const KASVIEW_PAGE = Path.KAS_PAGE;
  static const AGENDAVIEW_PAGE = Path.AGENDA_PAGE;
  static const PROFILEVIEW_PAGE = Path.PROFILE_PAGE;
  static const JADWALVIEW_PAGE = Path.JADWAL_PAGE;
  static const QRCODEVIEW_PAGE = Path.QRCODE;
  static const QRCODESISWAVIEW_PAGE = Path.QRCODESISWA;
  static const QRCODEGURUVIEW_PAGE = Path.QRCODEGURU;
  static const QRCODETUNAIVIEW_PAGE = Path.QRCODETUNAI;
  static const JADWALPIKET_PAGE = Path.JADWALPIKET;
}

abstract class Path {
  Path._();

  static const SPLASHSCREEN_PAGE = "/";
  static const ONBOARDING_PAGE = "/onboarding";
  static const LOGIN_PAGE = "/loginView";
  static const INPUTEMAIL_PAGE = "/inputemailView";
  static const REGISTER_PAGE = "/registerview";
  static const BIOGRAFI_PAGE = "/biografiView";
  static const PENDING_PAGE = "/pendingView";
  static const HOME_PAGE = "/homescreen";
  static const HOMEGURU_PAGE = "/homeguruscreen";
  static const NOTIFICATION_PAGE = "/notification";
  static const STRUKTURKELAS_PAGE = "/strukturkelasscreen";
  static const STRUKTURKELASGURU_PAGE = "/strukturkelasguruscreen";
  static const INFOKELAS_PAGE = "/infokelasscreen";
  static const INFOTUGAS_PAGE = "/infotugasscreen";
  static const PEMBUKUAN_PAGE = "/pembukuanscreen";
  static const KAS_PAGE = "/kasscreen";
  static const AGENDA_PAGE = "/agendascreen";
  static const PROFILE_PAGE = "/profilescreen";
  static const JADWAL_PAGE = "/jadwalscreen";
  static const QRCODE = "/qrcodescreen";
  static const QRCODESISWA = "/qrcodesiswascreen";
  static const QRCODEGURU = "/qrcodeguruscreen";
  static const QRCODETUNAI = "/qrcodetunaiscreen";
  static const JADWALPIKET = "/jadwalpiketscreen";
}
