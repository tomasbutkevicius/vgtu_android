import 'dart:async';

import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_7ld/services/local_notifications.dart';
import 'package:flutter_app_7ld/services/settings.dart';
import 'package:flutter_app_7ld/services/state_manager.dart';

class HomeViewModel extends StateManager {
  final State _state;
  final Battery battery = Battery();
  LocalNotifications localNotifications = LocalNotifications();

  BatteryState? batteryState;
  late StreamSubscription<int> batteryLevelSubscription;
  
  HomeViewModel(this._state) {
    listenToBattery();
  }

  Future listenToBattery() async {
    StreamController<int> controller = StreamController<int>();
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      controller.add(await battery.batteryLevel);
    });
    Stream<int> stream = controller.stream;
    
    batteryLevelSubscription = stream.listen((value) {
      if (value <= 20) {
        if (!LocalNotifications.batteryNotificationShowed) {
          localNotifications.notifyAboutLowBattery();
        }
      } else {
        if(LocalNotifications.batteryNotificationShowed){
          LocalNotifications.batteryNotificationShowed = false;
        }
      }
    });
  }

  Future cancelBatteryListener() async {
    await batteryLevelSubscription.cancel();
  }

  onNotificationSwitch() {
    Settings.notificationsEnabled = !Settings.notificationsEnabled;
    
    if(Settings.notificationsEnabled){
      listenToBattery();
    } else {
      cancelBatteryListener();
      localNotifications.cancelNotifications();
    }

    rebuildWidget(_state);
  }
}
