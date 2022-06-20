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
      this.carImage);

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
        carImage = data['carImage'];

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
        'name': name
      };

  Map<String, dynamic> get driverCurrentLocation => {
        'name': name,
        'phoneNumber': phoneNumber,
        'numberPlate': numberPlate,
        'carImage': carImage,
      };

  PersonalDetailsModel copyWith({
    String? city,
    String? name,
    String? phoneNumber,
    DateTime? dob,
    String? placeOfBirth,
    Gender? gender,
    String? numberPlate,
    String? dl,
    String? carDocs,
    String? carImage,
  }) {
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
    );
  }
}
