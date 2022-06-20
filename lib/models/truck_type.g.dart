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
        return TruckType.class_1;
      case 1:
        return TruckType.class_2a;
      case 2:
        return TruckType.class_2b;
      case 3:
        return TruckType.class_3;
      case 4:
        return TruckType.class_4;
      case 5:
        return TruckType.class_5;
      case 6:
        return TruckType.class_6;
      case 7:
        return TruckType.class_7;
      case 8:
        return TruckType.class_8;
      default:
        return TruckType.class_1;
    }
  }

  @override
  void write(BinaryWriter writer, TruckType obj) {
    switch (obj) {
      case TruckType.class_1:
        writer.writeByte(0);
        break;
      case TruckType.class_2a:
        writer.writeByte(1);
        break;
      case TruckType.class_2b:
        writer.writeByte(2);
        break;
      case TruckType.class_3:
        writer.writeByte(3);
        break;
      case TruckType.class_4:
        writer.writeByte(4);
        break;
      case TruckType.class_5:
        writer.writeByte(5);
        break;
      case TruckType.class_6:
        writer.writeByte(6);
        break;
      case TruckType.class_7:
        writer.writeByte(7);
        break;
      case TruckType.class_8:
        writer.writeByte(8);
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
