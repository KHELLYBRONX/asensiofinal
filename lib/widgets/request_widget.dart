import 'package:asensiofinal/models/ride.dart';
import 'package:asensiofinal/provider/location_provider.dart';
import 'package:asensiofinal/provider/marker_provider.dart';
import 'package:asensiofinal/provider/polylines_provider.dart';
import 'package:asensiofinal/services/realtime_db_service.dart';
import 'package:asensiofinal/services/route_service.dart';
import 'package:asensiofinal/utils/utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class RequestWidget extends StatefulWidget {
  const RequestWidget({Key? key}) : super(key: key);

  @override
  State<RequestWidget> createState() => _RequestWidgetState();
}

class _RequestWidgetState extends State<RequestWidget> {
  late MarkersProvider _markersProvider;
  late PolyLinesProvider _polyLinesProvider;
  late LocationProvider _locationProvider;
  late NavigatorState _navigator;

  late bool _isLoading;

  @override
  void didChangeDependencies() {
    _markersProvider = Provider.of<MarkersProvider>(context, listen: false);
    _polyLinesProvider = Provider.of<PolyLinesProvider>(context, listen: false);
    _locationProvider = Provider.of<LocationProvider>(context, listen: false);
    _navigator = Navigator.of(context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    _markersProvider = Provider.of<MarkersProvider>(context, listen: false);
    _polyLinesProvider = Provider.of<PolyLinesProvider>(context, listen: false);
    _locationProvider = Provider.of<LocationProvider>(context, listen: false);
    _navigator = Navigator.of(context);
    _isLoading = false;
  }

  @override
  void dispose() {
    _markersProvider.dispose();
    _polyLinesProvider.dispose();
    _locationProvider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final devSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            AppBar(
              backgroundColor: Colors.white,
              centerTitle: true,
              title: const Text('My Request',
                  style: TextStyle(color: Colors.black)),
            ),
            StreamBuilder<DataSnapshot>(
                stream: RealtimeDatabaseService.instance.getMyRides(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasData) {
                    var data = Utils.filterWaitingRides(
                        snapshot.data?.value as Map<dynamic, dynamic>);
                    if (data.isEmpty) {
                      return SizedBox(
                        height: devSize.height,
                        child: Center(
                          child: Column(
                            children: [
                              Lottie.asset('assets/animations/no_rides.json'),
                              const Text('You have no rides')
                            ],
                          ),
                        ),
                      );
                    }
                    return SizedBox(
                        height: devSize.height,
                        child: ListView.separated(
                            itemBuilder: ((context, index) => ListTile(
                                  leading: const Icon(Icons.fire_truck),
                                  title: Text(data[index].destinationPlaceName),
                                  subtitle:
                                      Text('status: ' + data[index].status),
                                  trailing: Text(
                                      "GHC" + data[index].price.toString()),
                                  onTap: () {
                                    //check if has accepted ride
                                    if (data[index].status == 'accepted') {
                                      return;
                                    }
                                    showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                              title:
                                                  const Text('Confirm Ride?'),
                                              content: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  _Label(
                                                      label: 'Email',
                                                      value: data[index].email),
                                                  _Label(
                                                      label: 'Destination',
                                                      value: data[index]
                                                          .destinationPlaceName),
                                                  _Label(
                                                      label: 'Current Location',
                                                      value: data[index]
                                                          .pickupPlaceName)
                                                ],
                                              ),
                                              actions: [
                                                _isLoading
                                                    ? const CircularProgressIndicator()
                                                    : TextButton(
                                                        onPressed: () async {
                                                          if (Provider.of<
                                                                      PolyLinesProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .polylines
                                                              .isNotEmpty) {
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    SnackBar(
                                                                        content:
                                                                            Row(
                                                              children: const [
                                                                Icon(
                                                                  Icons.error,
                                                                  color: Colors
                                                                      .red,
                                                                ),
                                                                Text(
                                                                    'Please complete your ongoing ride')
                                                              ],
                                                            )));
                                                            return;
                                                          }
                                                          setState(() {
                                                            _isLoading = true;
                                                          });
                                                          await RealtimeDatabaseService
                                                              .instance
                                                              .acceptRide(
                                                                  data[index]);
                                                          _markersProvider
                                                                  .addMarker =
                                                              _locationProvider
                                                                  .getLatLng!;
                                                          _markersProvider
                                                                  .addMarker =
                                                              data[index]
                                                                  .location;
                                                          _markersProvider
                                                                  .addMarker =
                                                              data[index].des;
                                                          // Navigator.pop(context);

                                                          // From driver to pickup
                                                          var res = await RouteService
                                                              .instance
                                                              .getPolyCoordinates(
                                                                  _locationProvider
                                                                      .getLatLng!,
                                                                  data[index]
                                                                      .location);
                                                          // from pickup to destination
                                                          var res1 = await RouteService
                                                              .instance
                                                              .getPolyCoordinates(
                                                                  data[index]
                                                                      .location,
                                                                  data[index]
                                                                      .des);
                                                          _polyLinesProvider
                                                              .addPolyLine(res);
                                                          _polyLinesProvider
                                                              .addPolyLine(
                                                            res1,
                                                          );
                                                          setState(() {
                                                            _isLoading = false;
                                                          });
                                                          _navigator.pop();
                                                        },
                                                        child: const Text(
                                                            'ACCEPT')),
                                                TextButton(
                                                    onPressed: () async {
                                                      Navigator.pop(context);
                                                      RealtimeDatabaseService
                                                          .instance
                                                          .cancelRide(
                                                              data[index]);
                                                    },
                                                    child:
                                                        const Text('CANCEL')),
                                              ],
                                            ));
                                  },
                                )),
                            separatorBuilder: (_, i) => const Divider(),
                            itemCount: data.length));
                  }
                  return Container();
                })
          ],
        ));
  }
}

class _Label extends StatelessWidget {
  const _Label({Key? key, required this.label, required this.value})
      : super(key: key);
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              label + ': ',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(
              value ?? '',
            ),
          )
        ],
      ),
    );
  }
}
