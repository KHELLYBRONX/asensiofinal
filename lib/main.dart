import 'package:asensiofinal/provider/location_provider.dart';
import 'package:asensiofinal/provider/signup_provider.dart';
import 'package:asensiofinal/screens/Registration.dart';
import 'package:asensiofinal/screens/home.dart';
import 'package:asensiofinal/screens/login.dart';
import 'package:asensiofinal/services/auth_service.dart';
import 'package:asensiofinal/utils/get_location.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  bool isLoggedIn = AuthService.instance.isLoggedIn;
  var location = await getLocation();
  runApp(MyApp(position: location, isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final Position? position;
  final bool isLoggedIn;
  const MyApp({Key? key, required this.isLoggedIn, required this.position})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LocationProvider>(
            create: (_) => LocationProvider(position)),
        ChangeNotifierProvider(
          create: (_) => SignUpProvider(),
        )
      ],
      child: MaterialApp(
        // home: Registration1(),
        home: isLoggedIn ? const HomeScreen() : const LoginPage(),
      ),
    );
  }
}
