import 'package:flutter/material.dart';

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
            SizedBox(
                height: devSize.height,
                child: ListView.separated(
                    itemBuilder: ((context, index) => ListTile(
                          title: const Text('Request'),
                          onTap: () {},
                        )),
                    separatorBuilder: (_, i) => const Divider(),
                    itemCount: 30))
          ],
        ));
  }
}
