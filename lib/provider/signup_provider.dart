import 'package:asensiofinal/models/personal_details_model.dart';
import 'package:flutter/material.dart';

class SignUpProvider extends ChangeNotifier {
  PersonalDetailsModel? _personalDetails;

  SignUpProvider(PersonalDetailsModel? data) {
    _personalDetails = data;
  }

  PersonalDetailsModel? get personalDetails => _personalDetails;

  set setField(PersonalDetailsModel model) {
    _personalDetails ??= model;
    _personalDetails = _personalDetails?.copyWith(
        name: model.name,
        carDocs: model.carDocs,
        carImage: model.carImage,
        city: model.city,
        dl: model.dl,
        dob: model.dob,
        gender: model.gender,
        numberPlate: model.numberPlate,
        phoneNumber: model.phoneNumber,
        placeOfBirth: model.placeOfBirth);
    notifyListeners();
  }
}
