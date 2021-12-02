
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotifications {
  static final FlutterLocalNotificationsPlugin _localNotifications = FlutterLocalNotificationsPlugin();


  Future notifyAboutValue() async {
    await _localNotifications.show(0, 'Found new md5 value', 'click to enter app', _notificationDetails());
  }

  static NotificationDetails _notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails('your channel id', 'your channel name',
            importance: Importance.defaultImportance, priority: Priority.defaultPriority, showWhen: false));
  }

  static Future init() async {
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid);

    await _localNotifications.initialize(initializationSettings, onSelectNotification: (payload) async {});
  }

}