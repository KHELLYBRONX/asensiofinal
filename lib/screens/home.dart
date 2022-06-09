import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      drawer:  Drawer(
        child: Column(children: const [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(child: Icon(Icons.person)),
            accountName: Text('Asenso Isaac'), accountEmail: Text('sdfdsf@gmail.com'))
        ],),
      ),
      body: Container(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (i){},
        items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home),
        label: 'Home'
        ),
        BottomNavigationBarItem(icon: Icon(Icons.settings),
        label: 'Settings'
        ),
      ]),
    );
  }
}