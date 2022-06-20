import 'package:hive/hive.dart';

part 'truck_type.g.dart';

@HiveType(typeId: 3)
enum TruckType {
  @HiveField(0)
  class_1,
  @HiveField(1)
  class_2a,
  @HiveField(2)
  class_2b,
  @HiveField(3)
  class_3,
  @HiveField(4)
  class_4,
  @HiveField(5)
  class_5,
  @HiveField(6)
  class_6,
  @HiveField(7)
  class_7,
  @HiveField(8)
  class_8
}
