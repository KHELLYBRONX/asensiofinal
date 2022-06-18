// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personal_details_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PersonalDetailsModelAdapter extends TypeAdapter<PersonalDetailsModel> {
  @override
  final int typeId = 1;

  @override
  PersonalDetailsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PersonalDetailsModel(
      fields[0] as String?,
      fields[9] as String?,
      fields[1] as String?,
      fields[2] as DateTime?,
      fields[3] as String?,
      fields[4] as Gender?,
      fields[5] as String?,
      fields[6] as String?,
      fields[7] as String?,
      fields[8] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PersonalDetailsModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.city)
      ..writeByte(1)
      ..write(obj.phoneNumber)
      ..writeByte(2)
      ..write(obj.dob)
      ..writeByte(3)
      ..write(obj.placeOfBirth)
      ..writeByte(4)
      ..write(obj.gender)
      ..writeByte(5)
      ..write(obj.numberPlate)
      ..writeByte(6)
      ..write(obj.dl)
      ..writeByte(7)
      ..write(obj.carDocs)
      ..writeByte(8)
      ..write(obj.carImage)
      ..writeByte(9)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PersonalDetailsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
