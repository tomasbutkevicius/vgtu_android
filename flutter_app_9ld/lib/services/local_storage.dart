
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:latlong2/latlong.dart';

class LocalStorage {
  static const _key = 'md5';

  Future<String> getSavedMd5() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String md5 = prefs.getString(_key) ?? "";

    if(md5.isEmpty){
      print("md5 not found");

      return "";
    }

    print("md5 found:");
    print(md5);


    return md5;
  }

  Future saveMd5(String md5) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("DB: saving md5");
    print(md5);


    await prefs.setString(_key, md5);
  }

}