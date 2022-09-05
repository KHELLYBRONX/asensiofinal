import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolyLinesProvider extends ChangeNotifier {
  Set<Polyline> _polylines = {};

  PolyLinesProvider();

  Set<Polyline> get polylines => _polylines;

  void addPolyLine(List<LatLng> polylineCoordinates) async {
    PolylineId id = PolylineId(polylineCoordinates.toString());
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.deepPurpleAccent,
      points: polylineCoordinates,
      width: 8,
    );
    _polylines.add(polyline);
    // notifyListeners();
  }

  void empty() {
    _polylines = {};
  }
}
