import 'package:flutter/material.dart';
import 'package:flutter_app_9ld/views/home/home_viewmodel.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final HomeViewModel viewModel;

  @override
  void initState() {
    viewModel = HomeViewModel(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => viewModel.onRefreshBtnClick(),
        child: Icon(Icons.refresh),
      ),
      body: FlutterMap(
        mapController: viewModel.mapController,
        options: MapOptions(
          center: viewModel.points[0],
          zoom: 5,
          maxZoom: 15,
          plugins: [
            MarkerClusterPlugin(),
          ],
          onTap: (position, point) => viewModel.onMapTap(position, point),
          onLongPress: (position, point) => viewModel.onMapLongPress(position, point),
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerClusterLayerOptions(
            maxClusterRadius: 120,
            size: Size(40, 40),
            anchor: AnchorPos.align(AnchorAlign.center),
            fitBoundsOptions: FitBoundsOptions(
              padding: EdgeInsets.all(50),
            ),
            markers: viewModel.markers,
            polygonOptions: PolygonOptions(
                borderColor: Colors.blueAccent,
                color: Colors.black12,
                borderStrokeWidth: 3),
            popupOptions: PopupOptions(
                popupSnap: PopupSnap.markerTop,
                popupController: viewModel.popupController,
                popupBuilder: (_, marker) => Container(
                  width: 200,
                  height: 100,
                  color: Colors.white,
                  child: GestureDetector(
                    onTap: () => viewModel.onPopupTap(),
                    onDoubleTap: () => viewModel.onPopupDoubleTap(marker),
                    child: Text(
                      '${viewModel.popupMessage} ${marker.point}',
                    ),
                  ),
                )),
            builder: (context, markers) {
              return FloatingActionButton(
                onPressed: null,
                child: Text(markers.length.toString()),
              );
            },
          ),
        ],
      ),
    );
  }
}