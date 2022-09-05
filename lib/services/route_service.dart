import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RouteService {
  static final RouteService instance = RouteService._();
  RouteService._();
  PolylinePoints polylinePoints = PolylinePoints();
  // String googleAPiKey = "AIzaSyC4h6VEbijtnJhZ8HO3jbvd3o7YFgeOUsc";
  String googleAPiKey = "AIzaSyChlSYajoQ0gJ0tBW-_ViE5ACej3fdcn1o";
  Map<PolylineId, Polyline> polylines = {};

  Future<List<LatLng>> getPolyCoordinates(
      LatLng origin, LatLng destination) async {
    try {
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleAPiKey,
        PointLatLng(origin.latitude, origin.longitude),
        PointLatLng(destination.latitude, destination.longitude),
      );
      // if (result.points.isNotEmpty) {
      //   result.points.forEach((PointLatLng point) {
      //     polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      //   });
      // } else {
      //   print(result.errorMessage);
      // }
      // return result;
      return result.points.map((e) => LatLng(e.latitude, e.longitude)).toList();
    } on Exception catch (e) {
      throw e;
    }
  }
}
