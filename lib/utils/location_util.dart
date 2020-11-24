// import 'dart:convert';

// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:http/http.dart' as http;
import 'package:geocoder/geocoder.dart';
import 'package:latlong/latlong.dart' as latlong;

import '../security/key_apis.dart';

class LocationUtil {
  static String generateLocationPreviewImage({
    double latitude,
    double longitude,
  }) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=${KeyApis.GOOGLE_API_KEY}';
  }

  static Future<String> getAddressFrom(latlong.LatLng position) async {
    //IPA GOOGLE
    // final url =
    //     'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=${KeyApis.GOOGLE_API_KEY}';
    // final response = await http.get(url);
    // return json.decode(response.body)['results'][0]['formatted_address'];
    final coordinates = new Coordinates(position.latitude, position.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    return "${first.addressLine}";
  }
}
