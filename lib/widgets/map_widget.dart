import 'dart:async';

import 'package:asensiofinal/models/personal_details_model.dart';
import 'package:asensiofinal/provider/location_provider.dart';
import 'package:asensiofinal/services/geofire_service.dart';
import 'package:asensiofinal/services/location_service.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapWidget extends StatefulWidget {
  final PersonalDetailsModel personalDetailsModel;
  const MapWidget({Key? key, required this.personalDetailsModel})
      : super(key: key);

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  Completer<GoogleMapController> _controller = Completer();

  late LocationService _locationService;
  late GeoFireService _geoFireService;
  late StreamSubscription<Position> subscription;

  @override
  void initState() {
    _locationService = LocationService.instance;
    _geoFireService = GeoFireService.instance;
    subscription = _locationService.getLocationStream().listen((event) {
      if (event != null) {
        _geoFireService.addLocation(widget.personalDetailsModel, event);
      }
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LocationProvider>(builder: (context, provider, child) {
      var pos = CameraPosition(
          // tilt: 15,
          target: provider.getLatLng ?? MapWidget._kGooglePlex.target,
          zoom: 15);

      return StreamBuilder<Position>(
          stream: LocationService.instance.getLocationStream(),
          builder: (context, snapshot) {
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
    });
  }
}
