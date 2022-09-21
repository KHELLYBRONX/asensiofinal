import 'package:hive/hive.dart';

part 'truck_type.g.dart';

@HiveType(typeId: 3)
enum TruckType {
  @HiveField(0)
  MINI_TRUCK_PICK_UP,
  @HiveField(1)
  MID_SIZED_TRUCK_PICK_UP,
  @HiveField(2)
  COMPACT_TRUCK_PICK_UP,
  @HiveField(3)
  FULL_SIZED_TRUCK_PICK_UP,
  // @HiveField(4)
  // class_4,
  // @HiveField(5)
  // class_5,
  // @HiveField(6)
  // class_6,
  // @HiveField(7)
  // class_7,
  // @HiveField(8)
  // class_8
}
