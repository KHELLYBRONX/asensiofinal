import 'package:asensiofinal/models/ride.dart';
import 'package:asensiofinal/services/auth_service.dart';

class Utils {
  static List<Ride> filterRides(Map<dynamic, dynamic>? data) {
    var uid = AuthService.instance.currentUser?.uid;
    List<Ride> dataList = [];
    if (data == null) return [];
    data.forEach((key, value) {
      if (value['driver_id'] == uid) {
        dataList.add(Ride.fromJson({...value, 'id': key}));
      }
    });
    return dataList;
  }

  static List<Ride> filterHistoryRides(Map<dynamic, dynamic>? data) {
    var uid = AuthService.instance.currentUser?.uid;
    List<Ride> dataList = [];
    if (data == null) return [];
    data.forEach((key, value) {
      if (value['driver_id'] == uid &&
          (value['status'] == 'accepted' || value['status'] == 'ended')) {
        dataList.add(Ride.fromJson({...value, 'id': key}));
      }
    });
    dataList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return dataList;
  }

  static List<Ride> filterWaitingRides(Map<dynamic, dynamic>? data) {
    var uid = AuthService.instance.currentUser?.uid;
    List<Ride> dataList = [];
    if (data == null) return [];
    data.forEach((key, value) {
      if (value['driver_id'] == uid && value['status'] == 'waiting') {
        dataList.add(Ride.fromJson({...value, 'id': key}));
      }
    });
    return dataList;
  }
}
