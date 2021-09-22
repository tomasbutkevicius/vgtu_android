
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:latlong2/latlong.dart';

class LocalStorage {
  static const _keyLocationPoints = 'locationPoints';
  static const _keyCenterPoint = 'centerPoint';

  Future saveCenterPoint(LatLng point) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("DB: saving center point...");

    Map<String, dynamic> jsonPoint = {
      "latitude": point.latitude,
      "longitude": point.longitude,
    };

    await prefs.setString(_keyCenterPoint, jsonEncode(jsonPoint));
  }

  Future<LatLng> getCenterPoint() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String encodedPoint = prefs.getString(_keyCenterPoint) ?? "";

    if(encodedPoint.isEmpty){
      print("DB: no center point found. Returning default");

      return LatLng(55.393086, 22.734465);
    }

    print("DB: center point found:");
    print(encodedPoint);

    Map<String, dynamic> jsonPoint = jsonDecode(encodedPoint);

    return LatLng(jsonPoint["latitude"], jsonPoint['longitude']);
  }

  Future saveLocationPoints(List<Marker> markers) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("DB: saving locations...");

    List<Map<String, dynamic>> jsonPoints = [];

    markers.forEach((marker) {
      jsonPoints.add({
        "latitude": marker.point.latitude,
        "longitude": marker.point.longitude,
      });
    });

    await prefs.setString(_keyLocationPoints, jsonEncode(jsonPoints));

    print("DB: saved locations:");
    print(jsonPoints);
  }

  Future<List<Marker>> getMarkers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    print("DB: gettings locations from storage...");

    String encodedPoints = prefs.getString(_keyLocationPoints) ?? "";

    if(encodedPoints.isEmpty){
      print("DB: no locations found");

      return [];
    }

    print("DB: found locations:");
    print(encodedPoints);

    List<dynamic> jsonPoints = jsonDecode(encodedPoints);

    List<Marker> markerList = [];
    jsonPoints.forEach((jsonPoint) {
      markerList.add(
          Marker(
            anchorPos: AnchorPos.align(AnchorAlign.center),
            height: 30,
            width: 30,
            point: LatLng(jsonPoint["latitude"], jsonPoint['longitude']),
            builder: (ctx) => const Icon(Icons.pin_drop),
          )
      );
    });

    return markerList;
  }

}