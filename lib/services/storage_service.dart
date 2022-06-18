import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageService {
  late FirebaseStorage _firebaseStorage;

  StorageService._() {
    _firebaseStorage = FirebaseStorage.instance;
  }

  static StorageService instance = StorageService._();

  Future uploadCarImage(File file) async {
    try {
      String uid = const Uuid().v1();
      var snapshot =
          await _firebaseStorage.ref().child('images/' + uid).putFile(file);
      var downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } on Exception {
      rethrow;
    }
  }

  Future uploadCarDocs(File file) async {
    try {
      String uid = const Uuid().v1();
      var snapshot = await _firebaseStorage
          .ref()
          .child('docs/imageName' + uid)
          .putFile(file);
      var downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } on Exception {
      rethrow;
    }
  }
}
