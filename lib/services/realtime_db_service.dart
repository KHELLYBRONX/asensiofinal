import 'package:asensiofinal/models/ride.dart';
import 'package:asensiofinal/services/api_service.dart';
import 'package:asensiofinal/services/auth_service.dart';
import 'package:firebase_database/firebase_database.dart';

class RealtimeDatabaseService {
  late FirebaseDatabase _firebaseFirestore;

  static final RealtimeDatabaseService instance = RealtimeDatabaseService._();
  RealtimeDatabaseService._() {
    _firebaseFirestore = FirebaseDatabase.instance;
  }

  Stream<DataSnapshot> getMyRides() async* {
    // String driverId = AuthService.instance.currentUser!.uid;
    yield* _firebaseFirestore
        .ref('rideRequest')
        .onValue
        .map((event) => event.snapshot);
  }

  Future<void> acceptRide(Ride ride) async {
    await _firebaseFirestore
        .ref('rideRequest/${ride.id}')
        .update({'status': 'accepted'});
    ApiService.instance.sendSmsToClient(
        phoneNumber: ride.userPhoneNumber,
        name: ride.clientName,
        accepted: true);
  }

  Future<void> endRide(Ride ride) async {
    await _firebaseFirestore
        .ref('rideRequest/${ride.id}')
        .update({'status': 'ended'});
    ApiService.instance.endRideSms(
      phoneNumber: ride.userPhoneNumber,
      name: ride.clientName,
    );
  }

  Future<void> cancelRide(Ride ride) async {
    await _firebaseFirestore
        .ref('rideRequest/${ride.id}')
        .update({'status': 'cancelled'});
    ApiService.instance.sendSmsToClient(
        phoneNumber: ride.userPhoneNumber,
        name: ride.clientName,
        accepted: false);
  }
}
