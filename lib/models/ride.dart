import 'package:google_maps_flutter/google_maps_flutter.dart';

class Ride {
  final String id;
  final DateTime createdAt;
  final double price;
  final LatLng location;
  final LatLng des;
  final String riderId;
  final String driverId;
  final String email;
  final String status;
  final String destinationPlaceName;
  final String pickupPlaceName;

  Ride.fromJson(Map data)
      : createdAt = (DateTime.parse(data['created_at'])),
        id = data['id'],
        des = LatLng(
            data['destination']['latitude'], data['destination']['longitude']),
        location =
            LatLng(data['location']['latitude'], data['location']['longitude']),
        driverId = data['driver_id'],
        riderId = data['rider_id'],
        email = data['email'],
        status = data['status'],
        destinationPlaceName = data['destination_place_name'],
        pickupPlaceName = data['pickup_place_name'],
        price = data['price'].toDouble();
}
