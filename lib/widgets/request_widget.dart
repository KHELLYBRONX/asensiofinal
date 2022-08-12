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

class RequestWidget extends StatelessWidget {
  const RequestWidget({Key? key}) : super(key: key);

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
                    var data = Utils.filterRides(
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
                                  leading: Icon(Icons.fire_truck),
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
                                              title: Text('Confirm Ride?'),
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
                                                TextButton(
                                                    onPressed: () async {
                                                      await RealtimeDatabaseService
                                                          .instance
                                                          .acceptRide(
                                                              data[index]);
                                                      Provider.of<MarkersProvider>(
                                                              context,
                                                              listen: false)
                                                          .addMarker = Provider
                                                              .of<LocationProvider>(
                                                                  context,
                                                                  listen: false)
                                                          .getLatLng!;
                                                      Provider.of<MarkersProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .addMarker =
                                                          data[index].location;
                                                      Provider.of<MarkersProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .addMarker =
                                                          data[index].des;
                                                      Navigator.pop(context);

                                                      //From driver to pickup
                                                      // var res = await RouteService
                                                      //     .instance
                                                      //     .getPolyCoordinates(
                                                      //         Provider.of<LocationProvider>(
                                                      //                 context,
                                                      //                 listen:
                                                      //                     false)
                                                      //             .getLatLng!,
                                                      //         data[index]
                                                      //             .location);
                                                      //from pickup to destination
                                                      var res1 = await RouteService
                                                          .instance
                                                          .getPolyCoordinates(
                                                              data[index]
                                                                  .location,
                                                              data[index].des);
                                                      // Provider.of<PolyLinesProvider>(
                                                      //         context,
                                                      //         listen: false)
                                                      //     .addPolyLine(res);
                                                      Provider.of<PolyLinesProvider>(
                                                              context,
                                                              listen: false)
                                                          .addPolyLine(
                                                        res1,
                                                      );
                                                    },
                                                    child:
                                                        const Text('ACCEPT')),
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
                    print(data);
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
