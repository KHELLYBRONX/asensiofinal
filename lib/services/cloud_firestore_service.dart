import 'package:asensiofinal/models/personal_details_model.dart';
import 'package:asensiofinal/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CloudFirestoreService {
  late FirebaseFirestore _firebaseFirestore;

  static final CloudFirestoreService instance = CloudFirestoreService._();
  CloudFirestoreService._() {
    _firebaseFirestore = FirebaseFirestore.instance;
  }

  Future sendPersonalData(PersonalDetailsModel data) async {
    try {
      var uid = AuthService.instance.currentUser?.uid;
      await _firebaseFirestore
          .collection('DriverData')
          .doc(uid)
          .set(data.toJson());
    } on Exception {
      return 'Error updating db';
    }
  }
}
