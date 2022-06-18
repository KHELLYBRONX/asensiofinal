import 'package:asensiofinal/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CloudFirestoreService{

  late FirebaseFirestore _firebaseFirestore;

  static final CloudFirestoreService instance = CloudFirestoreService._();
  CloudFirestoreService._(){
    _firebaseFirestore = FirebaseFirestore.instance;
  }


  Future sendPersonalData(Map<String,dynamic> data)async{
    try{
      var uid = AuthService.instance.currentUser?.uid;
      await _firebaseFirestore.collection('DriverData')
      .doc(uid)
      .set(data);
    }on Exception{
      return 'Error updating db';
    }
  }


}