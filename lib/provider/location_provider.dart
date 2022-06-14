import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationProvider extends ChangeNotifier {
  Position? _position;
  LocationProvider(Position? position) {
    _position = position;
  }

  Position? get position => _position;

  LatLng? get getLatLng =>
      LatLng(_position?.latitude ?? 0, _position?.longitude ?? 0);

  set postion(Position position) {
    _position = position;
    notifyListeners();
  }
}
