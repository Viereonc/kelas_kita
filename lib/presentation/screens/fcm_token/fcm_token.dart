import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../../constants.dart';

class MessagingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getTokenAndRegister(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return Center(
            child: Text('FCM Token: ${snapshot.data}'),
          );
        }
      },
    );
  }

  Future<String?> _getTokenAndRegister() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      // Navigate to a specific page (this needs a proper context)
      // Navigator.pushNamed(context, '/message', arguments: MessageArguments(message, true));
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? bearerToken = prefs.getString('token');
    String? token = await FirebaseMessaging.instance.getToken();
    print("FCM Token: $token");
    if (token != null) {
      await http.post(
        Uri.parse(baseUrl + loginEndpoint),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $bearerToken ',
        },
        body: jsonEncode({'token': token}),
      );
    }
    return token;
  }
}
