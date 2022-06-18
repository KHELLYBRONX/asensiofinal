import 'package:hive_flutter/hive_flutter.dart';

part 'gender.g.dart';

@HiveType(typeId: 2)
enum Gender {
  @HiveField(0)
  MALE,
  @HiveField(1)
  FEMALE
}
