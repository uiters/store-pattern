import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

abstract class NotificationController {
  static FlutterLocalNotificationsPlugin plugin;

  @protected
  static void init() {
    plugin = FlutterLocalNotificationsPlugin();
    var android = AndroidInitializationSettings('app_icon');
    var ios = IOSInitializationSettings();
    var initSetting = InitializationSettings(android, ios);
    plugin.initialize(initSetting);
  }

  static Future show(String title, String body) {
    if (Platform.isIOS || Platform.isAndroid) {
      if (plugin == null) init();

      var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'store_pattern',
        'order_app',
        'Order application',
        importance: Importance.Max,
        priority: Priority.High,
      );
      var iOSPlatformChannelSpecifics = IOSNotificationDetails();
      var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics,
        iOSPlatformChannelSpecifics,
      );
      return plugin.show(0, title, body, platformChannelSpecifics, payload: 'item x');
    } else {
      return Future.value();
    }
  }
}
