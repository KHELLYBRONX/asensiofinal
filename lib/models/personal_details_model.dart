import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:asensiofinal/models/gender.dart';

class PersonalDetailsModel {
  final String? city;
  final String? phoneNumber;
  final DateTime? dob;
  final String? placeOfBirth;
  final Gender? gender;
  final String? numberPlate;
  final String? dl;
  final String? carDocs;
  final String? carImage;
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
