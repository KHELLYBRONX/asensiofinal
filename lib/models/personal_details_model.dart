import 'package:asensiofinal/models/gender.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PersonalDetailsModel{

  final String city;
  final String phoneNumber;
  final DateTime dob;
  final String placeOfBirth;
  final Gender gender;
  final String nationality;
  final String numberPlate;
  final String dl;
  final String carDocs;
  final String carImage; 

  PersonalDetailsModel({
    required this.city,required this.phoneNumber,
    required this.dob, required this.placeOfBirth,
    required this.gender, required this.nationality,
    required this.numberPlate, required this.dl,
    required this.carDocs , required this.carImage
    });

  PersonalDetailsModel.fromJson(Map<String,dynamic> data):
    city = data['city'],
    phoneNumber = data['phoneNumber'],
    dob = (data['dob'] as Timestamp).toDate(),
    placeOfBirth = data['placeOfBirth'],
    gender = data['gender'] == 0? Gender.MALE:Gender.FEMALE,
    nationality = data['nationality'],
    numberPlate = data['numberPlate'],
    dl = data['dl'],
    carDocs = data['carDocs'],
    carImage = data['carImage']
    ;

  Map<String,dynamic> toJson()
  =>{
    'city': city,
    'phoneNumber': phoneNumber,
    'dob' : Timestamp.fromDate(dob),
    'placeOfBirth' : placeOfBirth,
    'gender' : gender.index,
    'nationality': nationality,
    'numberPlate' : numberPlate,
    'dl': dl,
    'carDocs': carDocs,
    'carImage': carDocs
  };
}