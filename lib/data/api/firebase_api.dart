import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:kelas_kita/main.dart';
import 'package:kelas_kita/presentation/screens/info_tugas/info_tugas.dart';

import '../../presentation/screens/info_kelas/info_kelas_view.dart';
import '../../presentation/screens/notification/notif_page.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('Title : ${message.notification!.title}');
  print('Body : ${message.notification!.body}');
  print('payload : ${message.data}');
}

class FirebaseApi {
  final firebaseMessaging = FirebaseMessaging.instance;

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    final title = message.notification?.title ?? '';

    if (title.contains('Informasi Kelas')) {
      navigatorKey.currentState?.pushNamed(InfoKelasScreen.route, arguments: message);
    } else if (title.contains('Tugas')) {
      navigatorKey.currentState?.pushNamed(InfoTugasScreen.route, arguments: message);
    } else {
      navigatorKey.currentState?.pushNamed(NotificationPage.route, arguments: message);
    }
  }

  Future initPushNotifications() async {
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }

  Future<void> initNotifications() async {
    await firebaseMessaging.requestPermission();
    final fCMToken = await firebaseMessaging.getToken();
    print('Token : $fCMToken');
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    initPushNotifications();
  }
}
