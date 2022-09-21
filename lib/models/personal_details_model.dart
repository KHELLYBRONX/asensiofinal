import 'package:asensiofinal/models/truck_type.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:asensiofinal/models/gender.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'personal_details_model.g.dart';

@HiveType(typeId: 1)
class PersonalDetailsModel {
  @HiveField(0)
  final String? city;
  @HiveField(1)
  final String? phoneNumber;
  @HiveField(2)
  final DateTime? dob;
  @HiveField(3)
  final String? placeOfBirth;
  @HiveField(4)
  final Gender? gender;
  @HiveField(5)
  final String? numberPlate;
  @HiveField(6)
  final String? dl;
  @HiveField(7)
  final String? carDocs;
  @HiveField(8)
  final String? carImage;
  @HiveField(9)
  final String? name;
  @HiveField(10)
  final String? driverImage;
  @HiveField(11)
  final TruckType? truckType;

  PersonalDetailsModel(
      this.city,
      this.name,
      this.phoneNumber,
      this.dob,
      this.placeOfBirth,
      this.gender,
      this.numberPlate,
      this.dl,
      this.carDocs,
      this.carImage,
      this.driverImage,
      this.truckType);

  static TruckType? getTruckType(int index) {
    switch (index) {
      case 0:
        return TruckType.MINI_TRUCK_PICK_UP;
      case 1:
        return TruckType.MID_SIZED_TRUCK_PICK_UP;
      case 2:
        return TruckType.COMPACT_TRUCK_PICK_UP;
      case 3:
        return TruckType.FULL_SIZED_TRUCK_PICK_UP;
      // case 4:
      //   return TruckType.class_4;
      // case 5:
      //   return TruckType.class_5;
      // case 6:
      //   return TruckType.class_6;
      // case 7:
      //   return TruckType.class_7;
      // case 8:
      //   return TruckType.class_8;
      default:
        null;
    }
  }

  PersonalDetailsModel.fromJson(Map<String, dynamic> data)
      : city = data['city'],
        name = data['name'],
        phoneNumber = data['phoneNumber'],
        dob = data['dob'] == null ? null : (data['dob'] as Timestamp).toDate(),
        placeOfBirth = data['placeOfBirth'],
        gender = data['gender'] == null
            ? null
            : (data['gender'] == 0 ? Gender.MALE : Gender.FEMALE),
        numberPlate = data['numberPlate'],
        dl = data['dl'],
        carDocs = data['carDocs'],
        carImage = data['carImage'],
        driverImage = data['driverImage'],
        truckType = getTruckType(data['truckType']);

  Map<String, dynamic> toJson() => {
        'city': city,
        'phoneNumber': phoneNumber,
        'dob': Timestamp.fromDate(dob!),
        'placeOfBirth': placeOfBirth,
        'gender': gender?.index,
        'numberPlate': numberPlate,
        'dl': dl,
        'carDocs': carDocs,
        'carImage': carImage,
        'name': name,
        'driverImage': driverImage,
        'truckType': truckType?.index
      };

  Map<String, dynamic> get driverCurrentLocation => {
        'name': name,
        'phoneNumber': phoneNumber,
        'numberPlate': numberPlate,
        'carImage': carImage,
        'driverImage': driverImage,
        'truckType': truckType?.index
      };

  PersonalDetailsModel copyWith(
      {String? city,
      String? name,
      String? phoneNumber,
      DateTime? dob,
      String? placeOfBirth,
      Gender? gender,
      String? numberPlate,
      String? dl,
      String? carDocs,
      String? carImage,
      String? driverImage,
      TruckType? truckType}) {
    return PersonalDetailsModel(
        city ?? this.city,
        name ?? this.name,
        phoneNumber ?? this.phoneNumber,
        dob ?? this.dob,
        placeOfBirth ?? this.placeOfBirth,
        gender ?? this.gender,
        numberPlate ?? this.numberPlate,
        dl ?? this.dl,
        carDocs ?? this.carDocs,
        carImage ?? this.carImage,
        driverImage ?? this.driverImage,
        truckType ?? this.truckType);
  }
}
