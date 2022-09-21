// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'truck_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TruckTypeAdapter extends TypeAdapter<TruckType> {
  @override
  final int typeId = 3;

  @override
  TruckType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TruckType.MINI_TRUCK_PICK_UP;
      case 1:
        return TruckType.MID_SIZED_TRUCK_PICK_UP;
      case 2:
        return TruckType.COMPACT_TRUCK_PICK_UP;
      case 3:
        return TruckType.FULL_SIZED_TRUCK_PICK_UP;
      default:
        return TruckType.MINI_TRUCK_PICK_UP;
    }
  }

  @override
  void write(BinaryWriter writer, TruckType obj) {
    switch (obj) {
      case TruckType.MINI_TRUCK_PICK_UP:
        writer.writeByte(0);
        break;
      case TruckType.MID_SIZED_TRUCK_PICK_UP:
        writer.writeByte(1);
        break;
      case TruckType.COMPACT_TRUCK_PICK_UP:
        writer.writeByte(2);
        break;
      case TruckType.FULL_SIZED_TRUCK_PICK_UP:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TruckTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
