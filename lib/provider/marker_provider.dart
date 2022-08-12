import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkersProvider extends ChangeNotifier {
  Set<Marker> _markers = Set();

  MarkersProvider();

  Set<Marker> get getMarker => _markers;

  set addMarker(LatLng pos) {
    _markers.add(Marker(
        markerId: MarkerId(pos.toString()),
        position: pos,
        icon: BitmapDescriptor.defaultMarker));
    notifyListeners();
  }

  void removeMarker(LatLng pos) {
    _markers.removeWhere((element) => element.markerId == pos.toString());
    notifyListeners();
  }
}
