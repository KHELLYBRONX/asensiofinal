import 'package:asensiofinal/provider/location_provider.dart';
import 'package:asensiofinal/screens/login.dart';
import 'package:asensiofinal/utils/get_location.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var location = await getLocation();
  runApp(MyApp(
    position: location,
  ));
}

class MyApp extends StatelessWidget {
  final Position? position;
  const MyApp({Key? key, required this.position}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LocationProvider>(
            create: (_) => LocationProvider(position)),
      ],
      child: MaterialApp(
        home: LoginPage(),
      ),
    );
  }
}
