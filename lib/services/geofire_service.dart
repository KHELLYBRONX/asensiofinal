import 'package:asensiofinal/models/personal_details_model.dart';
import 'package:asensiofinal/services/auth_service.dart';
import 'package:asensiofinal/utils/get_location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:geolocator/geolocator.dart';

class GeoFireService {
  late Geoflutterfire geo;
  static final instance = GeoFireService._();
  GeoFireService._() {
    geo = Geoflutterfire();
  }

  Future<void> addLocation(
      PersonalDetailsModel personalDetailsModel, Position pos) async {
    var ref = FirebaseFirestore.instance.collection('DriverLocation');
    GeoFirePoint myLocation =
        geo.point(latitude: pos.latitude, longitude: pos.longitude);
    var uid = AuthService.instance.currentUser?.uid;
    if (lastPosition != null && lastPosition!.equals(pos) ||
        lastPosition!.hasNotChanged(pos)) {
      // print('equal');
      return;
    }
    lastPosition = pos;
    await geo.collection(collectionRef: ref).setDoc(uid!, {
      'position': myLocation.data,
      ...personalDetailsModel.driverCurrentLocation
    });
  }
}

extension on Position {
  bool equals(Position that) =>
      latitude == that.latitude && longitude == that.longitude;

  bool hasNotChanged(Position that) =>
      latitude - that.latitude < 0.00001 &&
      longitude - that.longitude < 0.00001;
}
