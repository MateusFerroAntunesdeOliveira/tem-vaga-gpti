import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class LocationService {
  final String key = 'AIzaSyDh2GOW-iYT_mJVhtaNaZnKr0W0NZ7p8B4';

  Future<String> getPlacedId(String input) async {
    final String url = 'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=$input&inputtype=textquery&key=$key';

    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var placeId = json['candidates'][0]['place_id'] as String;

    return placeId;
  }

  Future<Map<String, dynamic>> getPlace(String input) async {
    final String placeId = await getPlacedId(input);

    // final String url = 'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=name,formatted_address,geometry&key=$key';
    final String url = 'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$key';

    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var results = json['result'] as Map<String, dynamic>;

    return results;
  }

  Future <Map<String, dynamic>> getDirections(String origin, String destination) async {
    final String url = 'https://maps.googleapis.com/maps/api/directions/json?origin=$origin&destination=$destination&key=$key';

    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);

    var results = {
      'bounds_ne': json['routes'][0]['bounds']['northeast'],
      'bounds_sw': json['routes'][0]['bounds']['southwest'],
      'start_location': json['routes'][0]['legs'][0]['start_location'],
      'end_location': json['routes'][0]['legs'][0]['end_location'],
      'polyline': json['routes'][0]['overview_polyline']['points'],
      'polyline_decoded': PolylinePoints().decodePolyline(json['routes'][0]['overview_polyline']['points']),
    };

    return results;

  }
  
}