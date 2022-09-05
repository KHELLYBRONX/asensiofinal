import 'package:asensiofinal/models/ride.dart';
import 'package:asensiofinal/provider/marker_provider.dart';
import 'package:asensiofinal/provider/polylines_provider.dart';
import 'package:asensiofinal/utils/utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../services/realtime_db_service.dart';

class HistoryTab extends StatelessWidget {
  const HistoryTab({Key? key}) : super(key: key);

  void onEndRide(Ride data, BuildContext context) {
    if (data.status == 'ended') return;
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: const Text('End Ride?'),
              content: const Text('Are you sure you want to end this ride'),
              actions: [
                TextButton(
                    onPressed: () async {
                      await RealtimeDatabaseService.instance.endRide(data);
                      Provider.of<PolyLinesProvider>(context, listen: false)
                          .empty();
                      Provider.of<MarkersProvider>(context, listen: false)
                          .empty();
                      Navigator.pop(context);
                    },
                    child: const Text('ACCEPT')),
                TextButton(
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                    child: const Text('CANCEL')),
              ],
            ));
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
              title: const Text('My Ride History',
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
                    var data = Utils.filterHistoryRides(
                        snapshot.data?.value as Map<dynamic, dynamic>);
                    if (data.isEmpty) {
                      return SizedBox(
                        height: devSize.height,
                        child: Center(
                          child: Column(
                            children: [
                              Lottie.asset('assets/animations/no_rides.json'),
                              const Text(
                                  'You have no ongoing or completed rides rides')
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
                                  onTap: () => onEndRide(data[index], context),
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
