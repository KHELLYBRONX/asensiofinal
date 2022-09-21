import 'package:asensiofinal/constants/constants.dart';
import 'package:dio/dio.dart';

class ApiService {
  static final instance = ApiService._();
  late Dio _dio;

  ApiService._() {
    _dio = Dio();
  }

  Future sendSmsToClient(
      {required String phoneNumber,
      required String name,
      bool accepted = true}) async {
    late String res;
    if (phoneNumber.startsWith('0')) {
      res = '+233${phoneNumber.substring(1)}';
    } else {
      res = phoneNumber;
    }
    try {
      accepted
          ? _dio.post('$BASEURL/acceptResponse',
              data: {'phoneNumber': res, 'name': name})
          : _dio.post('$BASEURL/endResponse',
              data: {'phoneNumber': res, 'name': name});
    } on Exception catch (e) {
      return e;
    }
  }

  Future endRideSms({
    required String phoneNumber,
    required String name,
  }) async {
    late String res;
    if (phoneNumber.startsWith('0')) {
      res = '+233${phoneNumber.substring(1)}';
    } else {
      res = phoneNumber;
    }
    try {
      _dio.post('$BASEURL/rideEnd', data: {'phoneNumber': res, 'name': name});
    } on Exception catch (e) {
      return e;
    }
  }
}
