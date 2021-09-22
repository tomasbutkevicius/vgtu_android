
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:latlong2/latlong.dart';

class LocalStorage {
  static const _keyMarkers = 'markers';

  Future saveLocationPoints(List<Marker> markers) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("DB: saving locations...");

    List<Map<String, dynamic>> jsonMarkers = [];

    markers.forEach((marker) {
      jsonMarkers.add({
        "latitude": marker.point.latitude,
        "longitude": marker.point.longitude,
      });
    });

    await prefs.setString(_keyMarkers, jsonEncode(jsonMarkers));

    print("DB: saved locations:");
    print(jsonMarkers);
  }

  Future<List<Marker>> getMarkers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    print("DB: gettings locations from storage...");

    String encodedPoints = prefs.getString(_keyMarkers) ?? "";

    if(encodedPoints.isEmpty){
      print("DB: no locations found");

      return [];
    }

    print("DB: found locations:");
    print(encodedPoints);

    List<dynamic> jsonMarkers = jsonDecode(encodedPoints);

    List<Marker> markerList = [];
    jsonMarkers.forEach((encodedPoint) {
      markerList.add(
          Marker(
            anchorPos: AnchorPos.align(AnchorAlign.center),
            height: 30,
            width: 30,
            point: LatLng(encodedPoint["latitude"], encodedPoint['longitude']),
            builder: (ctx) => const Icon(Icons.pin_drop),
          )
      );
    });

    return markerList;
  }

}