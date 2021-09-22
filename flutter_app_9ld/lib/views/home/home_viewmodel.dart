import 'package:flutter/cupertino.dart';
import 'package:flutter_app_9ld/services/local_storage.dart';
import 'package:flutter_app_9ld/services/state_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';
import 'package:positioned_tap_detector_2/positioned_tap_detector_2.dart';

class HomeViewModel extends StateManager {
  final State _state;
  late final LocalStorage _localStorage;
  final String popupMessage = "Double tap here to remove";
  final PopupController popupController = PopupController();
  final MapController mapController = MapController();
  List<Marker> markers = [];
  late int pointIndex;
  List points = [
    LatLng(51.5, -0.09),
    LatLng(49.8566, 3.3522),
  ];

  HomeViewModel(this._state) {
    _initializeHomeView();
  }

  Future _initializeHomeView() async {
     _localStorage = LocalStorage();
    pointIndex = 0;
    markers =  await _localStorage.getMarkers();
    rebuildWidget(_state);
  }

  onRefreshBtnClick() {
    _localStorage.saveLocationPoints(markers);
    rebuildWidget(_state);
  }

  onPopupTap() {
    debugPrint('Popup tap!');
  }

  onMapLongPress(TapPosition position, LatLng point) {
    print("long press. Adding a marker...");
    print(point.latitude);
    Marker newMarker = Marker(
      anchorPos: AnchorPos.align(AnchorAlign.center),
      height: 30,
      width: 30,
      point: point,
      builder: (ctx) => Icon(Icons.pin_drop),
    );
    markers.add(newMarker);

    markers = List.from(markers);
    rebuildWidget(_state);
  }

  onMapTap(TapPosition position, LatLng point) {
    popupController.hidePopup();
  }

  onPopupDoubleTap(Marker marker) {
    markers.removeWhere((element) => (element.point.latitude == marker.point.latitude && element.point.longitude == marker.point.longitude));

    markers = List.from(markers);

    rebuildWidget(_state);
  }

}
