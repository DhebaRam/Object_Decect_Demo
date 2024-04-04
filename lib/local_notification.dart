import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';

class Notify {
  static Future<bool> instanceNotify(data) async {
    final AwesomeNotifications awesomeNotifications = AwesomeNotifications();
    return awesomeNotifications.createNotification(
        content: NotificationContent(
            id: Random().nextInt(100),
            channelKey: 'instant_notification',
            title: "Notification $data",
            body: "Notification Testing"));
  }
}

// import 'dart:io';
// import 'dart:ui';
//
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_native_timezone/flutter_native_timezone.dart';
// import 'package:flutter_push_notifications/utils/download_util.dart';
// import 'package:rxdart/subjects.dart';
// import 'package:timezone/data/latest_all.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;
//
// class NotificationService {
//   NotificationService();
//
//   final _localNotifications = FlutterLocalNotificationsPlugin();
//   final BehaviorSubject<String> behaviorSubject = BehaviorSubject();
//
//   Future<void> initializePlatformNotifications() async {
//     const AndroidInitializationSettings initializationSettingsAndroid =
//     AndroidInitializationSettings('ic_stat_justwater');
//
//     final IOSInitializationSettings initializationSettingsIOS =
//     IOSInitializationSettings(
//         requestSoundPermission: true,
//         requestBadgePermission: true,
//         requestAlertPermission: true,
//         onDidReceiveLocalNotification: onDidReceiveLocalNotification);
//
//     final InitializationSettings initializationSettings =
//     InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: initializationSettingsIOS,
//     );
//
//     await _localNotifications.initialize(initializationSettings,
//         onSelectNotification: selectNotification);
//   }
//
//   void onDidReceiveLocalNotification(
//       int id, String? title, String? body, String? payload) {
//     print('id $id');
//   }
//
//   void selectNotification(String? payload) {
//     if (payload != null && payload.isNotEmpty) {
//       behaviorSubject.add(payload);
//     }
//   }
// }
