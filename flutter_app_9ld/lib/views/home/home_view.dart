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
      appBar: _buildAppBar(context),
      floatingActionButton: _buildBottomActionButtons(),
      body: _buildBody(),
    );
  }

  FlutterMap _buildBody() {
    return FlutterMap(
      mapController: viewModel.mapController,
      options: MapOptions(
        center: viewModel.centerPoint,
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
          fitBoundsOptions: const FitBoundsOptions(
            padding: EdgeInsets.all(50),
          ),
          markers: viewModel.markers,
          polygonOptions: PolygonOptions(borderColor: Colors.blueAccent, color: Colors.black12, borderStrokeWidth: 3),
          popupOptions: PopupOptions(
              popupSnap: PopupSnap.markerTop,
              popupController: viewModel.popupController,
              popupBuilder: (_, marker) => Container(
                    width: 150,
                    height: 50,
                    color: Colors.white,
                    child: GestureDetector(
                      onTap: () => viewModel.onPopupTap(),
                      onDoubleTap: () => viewModel.onPopupDoubleTap(marker),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.teal,
                          onSurface: Colors.grey,
                        ),
                        onPressed: () {},
                        child: Text(viewModel.popupMessage),
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
    );
  }

  FloatingActionButton _buildBottomActionButtons() {
    return FloatingActionButton(
      onPressed: () => viewModel.onRefreshBtnClick(),
      child: const Icon(Icons.save),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    const TextStyle infoBtnTextStyle = TextStyle(color: Colors.white);
    return AppBar(
      title: const Text("Personal Marker Map"),
      centerTitle: true,
      actions: [
        TextButton(
          onPressed: () => viewModel.onInfoClick(context),
          child: Text(
            viewModel.infoBtnText,
            style: infoBtnTextStyle,
          ),
        )
      ],
    );
  }
}
