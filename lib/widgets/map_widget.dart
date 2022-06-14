import 'dart:async';

import 'package:asensiofinal/provider/location_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapWidget extends StatelessWidget {
  MapWidget({Key? key}) : super(key: key);

  Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Consumer<LocationProvider>(builder: (context, provider, child) {
      var pos = CameraPosition(
          // tilt: 15,
          target: provider.getLatLng ?? _kGooglePlex.target,
          zoom: 15);

      return GoogleMap(
          onCameraMove: ((position) => print(position)),
          buildingsEnabled: true,
          // liteModeEnabled: true,
          myLocationEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          compassEnabled: true,
          initialCameraPosition: pos);
    });
  }
}
