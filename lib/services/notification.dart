import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

Future initialNotification() async {
  flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('ic_launcher');
  final InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid, iOS: null);
  tz.initializeTimeZones();
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: onSelectNotification);
}

Future onSelectNotification(String payload) {
  BuildContext context;
  debugPrint("payload : $payload");
}

showNotification() async {
  await flutterLocalNotificationsPlugin.zonedSchedule(
      123,
      'وذكر',
      'أين وصلت في أعمالك؟',
      tz.TZDateTime.now(tz.local).add(const Duration(hours: 6)),
      const NotificationDetails(
          android:
              AndroidNotificationDetails('id', 'وذكر', 'wazakir وذكر')),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime);
}

void cancelNotification() async {
  await flutterLocalNotificationsPlugin.cancelAll();
}
