import 'package:asensiofinal/models/gender.dart';
import 'package:asensiofinal/models/personal_details_model.dart';
import 'package:asensiofinal/models/truck_type.dart';
import 'package:asensiofinal/provider/location_provider.dart';
import 'package:asensiofinal/provider/signup_provider.dart';
import 'package:asensiofinal/screens/Registration.dart';
import 'package:asensiofinal/screens/cardetails.dart';
import 'package:asensiofinal/screens/home.dart';
import 'package:asensiofinal/screens/login.dart';
import 'package:asensiofinal/services/auth_service.dart';
import 'package:asensiofinal/services/cache_service.dart';
import 'package:asensiofinal/utils/get_location.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  Hive.registerAdapter(PersonalDetailsModelAdapter());
  Hive.registerAdapter(GenderAdapter());
  Hive.registerAdapter(TruckTypeAdapter());
  bool isLoggedIn = AuthService.instance.isLoggedIn;
  PersonalDetailsModel? res;
  if (isLoggedIn) {
    res = await CacheService.instance.getUser();
  }
  var location = await getLocation();
  runApp(MyApp(
      personalDetailsModel: res, position: location, isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final Position? position;
  final PersonalDetailsModel? personalDetailsModel;
  final bool isLoggedIn;
  const MyApp(
      {Key? key,
      required this.personalDetailsModel,
      required this.isLoggedIn,
      required this.position})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LocationProvider>(
            create: (_) => LocationProvider(position)),
        ChangeNotifierProvider(
          create: (_) => SignUpProvider(personalDetailsModel),
        )
      ],
      child: MaterialApp(
        home: isLoggedIn ? const HomeScreen() : const LoginPage(),
      ),
    );
  }
}
