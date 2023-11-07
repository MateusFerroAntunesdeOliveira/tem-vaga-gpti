import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsGooglePage extends StatefulWidget {
  @override
  State<MapsGooglePage> createState() => MapsGooglePageState();
}

class MapsGooglePageState extends State<MapsGooglePage> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-25.441105, -49.276855),
    zoom: 15,
  );

  static final Marker _kPositionMarker = Marker(
    markerId: MarkerId('positionMarker'),
    position: LatLng(-25.441105, -49.276855),
    icon: BitmapDescriptor.defaultMarker,
    infoWindow: InfoWindow(title: 'Posição atual'),
  );

  static final Marker _kDestinationMarker = Marker(
    markerId: MarkerId('destinationMarker'),
    position: LatLng(-25.4500068, -49.2494386),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    infoWindow: InfoWindow(title: 'Destino'),
  );

  static final CameraPosition _kDestionation = CameraPosition(
    bearing: 192.80,
    target: LatLng(-25.4500068, -49.2494386),
    tilt: 59.44,
    zoom: 19,
  );

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF9F150D),
        toolbarHeight: 98,
        title: const Text(
          "Mapa",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.normal,
            fontFamily: 'Montserrat',
          ),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            zoomControlsEnabled: false,
            markers: {_kPositionMarker, _kDestinationMarker},
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          Positioned(
            left: 16,
            bottom: 16,
            child: FloatingActionButton.extended(
              elevation: 10,
              label: Text("Navegar", style: TextStyle(color: Colors.white, fontSize: 16)),
              tooltip: 'Navegar',
              icon: Icon(Icons.mode_of_travel_rounded),
              backgroundColor: const Color(0xFF9F150D),
              onPressed: _goToTheDestination,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _goToTheDestination() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kDestionation));
  }
}
