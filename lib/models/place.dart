import 'package:flutter/foundation.dart';
import 'package:latlong/latlong.dart';

// Tomar cuidado na hora da importação, para File interno tem que ser o :io
import 'dart:io';

class PlaceLocation {
  final double latitude;
  final double longitude;
  final String address;

  const PlaceLocation({
    @required this.latitude,
    @required this.longitude,
    this.address,
  });

  LatLng toLatLng() {
    return LatLng(this.latitude, this.longitude);
  }
}

class Place {
  final String id;
  final String title;
  final PlaceLocation location;
  final File image;

  Place({
    @required this.id,
    @required this.title,
    @required this.location,
    @required this.image,
  });
}
