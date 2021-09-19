import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotifications {
  static final FlutterLocalNotificationsPlugin _localNotifications = FlutterLocalNotificationsPlugin();

  static bool batteryNotificationShowed = false;

  Future notifyAboutLowBattery() async {
    batteryNotificationShowed = true;
    await _localNotifications.show(0, 'Your battery is low', 'click to enter app', _notificationDetails());
  }

  static NotificationDetails _notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails('your channel id', 'your channel name', 'your channel description',
            importance: Importance.defaultImportance, priority: Priority.defaultPriority, showWhen: false));
  }

  static Future init() async {
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('ic_stat_bat');
    final InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid);

    await _localNotifications.initialize(initializationSettings, onSelectNotification: (payload) async {});
  }

  Future cancelNotifications() async {
    await _localNotifications.cancelAll();
    batteryNotificationShowed = false;
  }
}
