import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

Future<Position?> getLocation() async {
  await Permission.locationAlways.request();
  var status = await Permission.locationAlways.isGranted;
  if (status) {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    return position;
  }
  return null;
}
