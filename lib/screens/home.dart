import 'package:asensiofinal/provider/signup_provider.dart';
import 'package:asensiofinal/screens/login.dart';
import 'package:asensiofinal/services/auth_service.dart';
import 'package:asensiofinal/services/cache_service.dart';
import 'package:asensiofinal/widgets/map_widget.dart';
import 'package:asensiofinal/widgets/request_widget.dart';
import 'package:asensiofinal/widgets/settings_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late AuthService _authService;

  @override
  void initState() {
    _authService = AuthService.instance;
  }

  void _onChangeTab(int index) {
    if (_currentIndex == index) {
      return;
    }
    setState(() {
      _currentIndex = index;
    });
  }

  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final statusBar = MediaQuery.of(context).padding.top;
    var signUpProvider = Provider.of<SignUpProvider>(context);
    return Scaffold(
      // appBar: AppBar(),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
                currentAccountPicture:
                    const CircleAvatar(child: Icon(Icons.person)),
                accountName: Text(signUpProvider.personalDetails?.name ?? ''),
                accountEmail: Text(_authService.currentUser!.email!)),
            ListTile(
              title: const Text('Logout'),
              onTap: () async {
                await CacheService.instance.deleteUser();
                await AuthService.instance.logout();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                    (route) => false);
              },
            )
          ],
        ),
      ),
      body: Stack(
        children: [
          IndexedStack(
            index: _currentIndex,
            children: [
              MapWidget(personalDetailsModel: signUpProvider.personalDetails!),
              const RequestWidget(),
              const SettingsWidget(),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  decoration: BoxDecoration(
                      // color: Colors.red,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            // blurStyle: BlurStyle.inner,
                            offset: const Offset(2, 2),
                            spreadRadius: 2)
                      ]),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () => _onChangeTab(0),
                          icon: Icon(
                            Icons.map,
                            color: _currentIndex == 0 ? Colors.blue : null,
                          )),
                      IconButton(
                          onPressed: () => _onChangeTab(1),
                          icon: Icon(
                            Icons.car_rental,
                            color: _currentIndex == 1 ? Colors.blue : null,
                          )),
                      IconButton(
                          onPressed: () => _onChangeTab(2),
                          icon: Icon(
                            Icons.settings,
                            color: _currentIndex == 2 ? Colors.blue : null,
                          )),
                    ],
                  )),
            ),
          ),
          _currentIndex != 0
              ? const SizedBox()
              : Padding(
                  padding: EdgeInsets.only(top: statusBar + 15, left: 10),
                  child: Container(
                    child: Builder(builder: (context) {
                      return IconButton(
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                          icon: const Icon(Icons.menu));
                    }),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              // blurStyle: BlurStyle.inner,
                              offset: const Offset(2, 2),
                              spreadRadius: 2)
                        ]),
                  ),
                )
        ],
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   onTap: (i){},
      //   items: <BottomNavigationBarItem>[
      //   BottomNavigationBarItem(icon: Icon(Icons.home),
      //   label: 'Home'
      //   ),
      //   BottomNavigationBarItem(icon: Icon(Icons.settings),
      //   label: 'Settings'
      //   ),
      // ]),
    );
  }
}
