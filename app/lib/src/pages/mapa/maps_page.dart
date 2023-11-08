import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../utils/utils.dart';

double lat = -1;
double long = -1;

class MapsGooglePage extends StatefulWidget {
  @override
  State<MapsGooglePage> createState() => MapsGooglePageState();
}

class MapsGooglePageState extends State<MapsGooglePage> {
  Completer<GoogleMapController> _controller = Completer();

  TextEditingController _originController = TextEditingController();
  TextEditingController _destinationController = TextEditingController();

  Set<Marker> _markers = Set<Marker>();
  Set<Polyline> _polylines = Set<Polyline>();

  int _polylineIdCounter = 1;

  CameraPosition get _initialPosCamera {
    Position? pos;
    _getPosition().then((value) => pos = value);

    return CameraPosition(
      target: LatLng(pos?.latitude ?? -25.4411050, pos?.longitude ?? -49.2768550),
      zoom: 15,
    );
  }

  @override
  void initState() {
    super.initState();
  }

  void _setMarker(LatLng point) {
    setState(() {

      _markers.clear();
      
      _markers.add(
        Marker(
          markerId: MarkerId(point.toString()),
          position: point,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          infoWindow: InfoWindow(
            title: 'Destino',
            snippet: 'Onde você quer chegar',
          ),
        ),
      );
    });
  }

  void _setPolylines(List<PointLatLng> points) {
    final String polylineIdVal = 'polyline$_polylineIdCounter';
    _polylineIdCounter++;

    _polylines.clear();

    _polylines.add(
      Polyline(
        polylineId: PolylineId(polylineIdVal),
        // consumeTapEvents: true,
        color: Colors.blue,
        width: 3,
        points: points.map((point) => LatLng(point.latitude, point.longitude)).toList(),
      ),
    );
  }

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
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    TextFormField(
                      controller: _originController,
                      textCapitalization: TextCapitalization.words,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Montserrat',
                      ),
                      decoration: InputDecoration(
                        hintText: 'Origem',
                        contentPadding: EdgeInsets.all(12),
                      ),
                      onChanged: ((value) => {}),
                    ),
                    TextFormField(
                      controller: _destinationController,
                      textCapitalization: TextCapitalization.words,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Montserrat',
                      ),
                      decoration: InputDecoration(
                        hintText: 'Destino',
                        contentPadding: EdgeInsets.all(12),
                      ),
                      onChanged: ((value) => {}),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () async {
                  var directions = await LocationService().getDirections(
                    _originController.text,
                    _destinationController.text,
                  );
                  _getPosition();
                  _goToTheDestination(
                    directions['end_location']['lat'],
                    directions['end_location']['lng'],
                    directions['bounds_ne'],
                    directions['bounds_sw'],
                  );
                  _setPolylines(directions['polyline_decoded']);
                },
                icon: Icon(Icons.search),
              ),
            ],
          ),
          Expanded(
            child: GoogleMap(
              mapType: MapType.normal,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              zoomControlsEnabled: false,
              markers: _markers,
              polylines: _polylines,
              initialCameraPosition: _initialPosCamera,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<Position> _getPosition() async {
    Permission.location.request();
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return position;
  }

  Future<void> _goToTheDestination(
    double lat,
    double lng,
    Map<String, dynamic> boundsNe,
    Map<String, dynamic> boundsSw,
  ) async {
    // final double lat = place['geometry']['location']['lat'];
    // final double lng = place['geometry']['location']['lng'];

    final GoogleMapController controller = await _controller.future;
    // controller.animateCamera(CameraUpdate.newCameraPosition(
    //   CameraPosition(
    //     target: LatLng(lat, lng),
    //     zoom: 18,
    //     tilt: 60.0,
    //     bearing: 120.0,
    //   ),
    // ));

    controller.animateCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBounds(
          southwest: LatLng(boundsSw['lat'], boundsSw['lng']),
          northeast: LatLng(boundsNe['lat'], boundsNe['lng']),
        ),
        25.0,
      ),
    );

    _setMarker(LatLng(lat, lng));
  }
}
