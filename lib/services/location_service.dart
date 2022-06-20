import 'package:geolocator/geolocator.dart';

class LocationService {
  static final instance = LocationService._();
  LocationService._();

  Stream<Position> getLocationStream() async* {
    yield* Geolocator.getPositionStream();
  }
}
