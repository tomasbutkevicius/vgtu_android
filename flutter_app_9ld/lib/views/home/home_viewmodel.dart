import 'package:flutter/cupertino.dart';
import 'package:flutter_app_9ld/services/state_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';
import 'package:positioned_tap_detector_2/positioned_tap_detector_2.dart';

class HomeViewModel extends StateManager {
  final State _state;
  final PopupController popupController = PopupController();
  final MapController mapController = MapController();
  late List<Marker> markers;
  late int pointIndex;
  List points = [
    LatLng(51.5, -0.09),
    LatLng(49.8566, 3.3522),
  ];

  HomeViewModel(this._state) {
    pointIndex = 0;
    markers = [
      Marker(
        anchorPos: AnchorPos.align(AnchorAlign.center),
        height: 30,
        width: 30,
        point: points[pointIndex],
        builder: (ctx) => Icon(Icons.pin_drop),
      ),
      Marker(
        anchorPos: AnchorPos.align(AnchorAlign.center),
        height: 30,
        width: 30,
        point: LatLng(53.3498, -6.2603),
        builder: (ctx) => Icon(Icons.pin_drop),
      ),
      Marker(
        anchorPos: AnchorPos.align(AnchorAlign.center),
        height: 30,
        width: 30,
        point: LatLng(53.3488, -6.2613),
        builder: (ctx) => Icon(Icons.pin_drop),
      ),
      Marker(
        anchorPos: AnchorPos.align(AnchorAlign.center),
        height: 30,
        width: 30,
        point: LatLng(53.3488, -6.2613),
        builder: (ctx) => Icon(Icons.pin_drop),
      ),
      Marker(
        anchorPos: AnchorPos.align(AnchorAlign.center),
        height: 30,
        width: 30,
        point: LatLng(48.8566, 2.3522),
        builder: (ctx) => Icon(Icons.pin_drop),
      ),
      Marker(
        anchorPos: AnchorPos.align(AnchorAlign.center),
        height: 30,
        width: 30,
        point: LatLng(49.8566, 3.3522),
        builder: (ctx) => Icon(Icons.pin_drop),
      ),
    ];
    rebuildWidget(_state);
  }

  onRefreshBtnClick() {
    print("pressed refresh");
    pointIndex++;
    if (pointIndex >= points.length) {
      pointIndex = 0;
    }
    markers[0] = Marker(
      point: points[pointIndex],
      anchorPos: AnchorPos.align(AnchorAlign.center),
      height: 30,
      width: 30,
      builder: (ctx) => Icon(Icons.pin_drop),
    );
    markers = List.from(markers);
    rebuildWidget(_state);
  }

  onPopupTap() {
    debugPrint('Popup tap!');
  }

  onMapLongPress(TapPosition position, LatLng point) {
    print("long press");
    print("latitude");
    print(point.latitude);
    Marker newMarker = Marker(
      anchorPos: AnchorPos.align(AnchorAlign.center),
      height: 30,
      width: 30,
      point: point,
      builder: (ctx) => Icon(Icons.pin_drop),
    );
    markers.add(newMarker);
    rebuildWidget(_state);
  }

  onMapTap(TapPosition position, LatLng point) {
    popupController.hidePopup();
  }

}
