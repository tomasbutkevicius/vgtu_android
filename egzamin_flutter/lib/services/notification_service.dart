import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotifications {
  static final FlutterLocalNotificationsPlugin _localNotifications = FlutterLocalNotificationsPlugin();

  static bool batteryNotificationShowed = false;

  Future notifyEmailSent() async {
    batteryNotificationShowed = true;
    await _localNotifications.show(0, 'Is failo nuskaityta informacija issiusta', '', _notificationDetails());
  }

  static NotificationDetails _notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails('your channel id', 'your channel name',
            importance: Importance.max, priority: Priority.max, showWhen: false, playSound: true),);
  }

  static Future init() async {
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('launch_background');
    final InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid);

    await _localNotifications.initialize(initializationSettings, onSelectNotification: (payload) async {});
  }

  Future cancelNotifications() async {
    await _localNotifications.cancelAll();
    batteryNotificationShowed = false;
  }
}