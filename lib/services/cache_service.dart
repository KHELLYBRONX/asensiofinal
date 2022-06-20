import 'package:asensiofinal/models/personal_details_model.dart';
import 'package:hive/hive.dart';

class CacheService {
  static final CacheService instance = CacheService._();
  Box<PersonalDetailsModel>? box;
  CacheService._() {
    initBox();
  }

  initBox() async {
    box = await Hive.openBox(userBox);
  }

  static const String userBox = 'user';

  Future<void> saveUser(PersonalDetailsModel data) async {
    box ??= await Hive.openBox<PersonalDetailsModel>(userBox);
    // box?.add(data);
    box?.put('user', data);
  }

  Future deleteUser() async {
    box ??= await Hive.openBox(userBox);
    box?.delete('user');
    box?.clear();
  }

  Future<PersonalDetailsModel?> getUser() async {
    box ??= await Hive.openBox(userBox);
    return box?.get('user');
  }
}
