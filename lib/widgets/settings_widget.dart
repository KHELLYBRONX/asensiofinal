import 'package:flutter/material.dart';

class SettingsWidget extends StatelessWidget {
  const SettingsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final devSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(children: [
        AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text('Settings', style: TextStyle(color: Colors.black)),
        ),
        ListTile(
          title: const Text('About App'),
          onTap: () {},
        ),
        const Divider(),
      ]),
    );
  }
}
