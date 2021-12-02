import 'package:flutter/cupertino.dart';
import 'package:flutter_app_9ld/models/response.dart';
import 'package:flutter_app_9ld/services/api.dart';
import 'package:flutter_app_9ld/services/local_notification.dart';
import 'package:flutter_app_9ld/services/local_storage.dart';
import 'package:flutter_app_9ld/services/state_manager.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends StateManager {
  final State _state;
  final LocalStorage _localStorage = LocalStorage();
  final Api api = Api();
  bool updateValueAvailable = false;
  String remoteMp3Value = "";

  HomeViewModel(this._state) {
    _initializeHomeView();
  }

  Future _initializeHomeView() async {
    String md5Saved = await _localStorage.getSavedMd5();

    ResponseModel response = await api.fetch();
    remoteMp3Value = response.md5;
    print("remote md5:");
    print(response.md5);
     print("storage md5:");
     print(md5Saved);
    if(md5Saved == response.md5){
      print("MD5 IS SAME");
      updateValueAvailable = false;
      rebuildWidget(_state);
    } else {
      print("MD5 IS DIFFERENT");
      LocalNotifications localNotifications = LocalNotifications();
      await localNotifications.notifyAboutValue();
      updateValueAvailable = true;
      rebuildWidget(_state);
    }
  }

  notUpdateClick() {
    updateValueAvailable = false;
    rebuildWidget(_state);
  }


  updateClick() async {
    updateValueAvailable = false;
    await _localStorage.saveMd5(remoteMp3Value);
    rebuildWidget(_state);
  }

  resetMd5() async {
    await _initializeHomeView();
  }

}
