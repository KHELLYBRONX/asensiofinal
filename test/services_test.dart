import 'package:asensiofinal/services/route_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  test('testing routing services', () async {
    RouteService routeService = RouteService.instance;
    // setUp(() {
    //   routeService = RouteService.instance;
    // });

    var res = await routeService.getPolyCoordinates(
        const LatLng(6.6728643, -1.5558514),
        const LatLng(6.6728641, -1.5558517));
    expect(res.isEmpty, false);
  });
}
