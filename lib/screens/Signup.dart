import 'package:asensiofinal/Animation/fade_animation.dart';
import 'package:asensiofinal/screens/Registration.dart';
import 'package:asensiofinal/screens/Signup.dart';
import 'package:asensiofinal/screens/login.dart';
import 'package:asensiofinal/services/auth_service.dart';
import 'package:asensiofinal/widgets/auth_btn.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late TextEditingController _emailController;

  late TextEditingController _passwordController;
  late bool _loading;
  late AuthService _authService;

  @override
  void initState() {
    _emailController = TextEditingController(text: '');
    _passwordController = TextEditingController(text: '');
    _loading = false;
    _authService = AuthService.instance;
  }

  Future _onNextTapped() async {
    final emailValidator = ValidationBuilder().email('Invalid Email').build();
    final passwordValidator = ValidationBuilder()
        .minLength(6, 'Minimum length of password should be 6')
        .build();
    //validate Form
    var msg = emailValidator(_emailController.text);
    if (msg != null)
      return ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(msg)));
    var msg1 = passwordValidator(_passwordController.text);
    if (msg1 != null)
      return ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(msg1)));
    //if form is not valid show snackbar
    //register user
    switchLoading();
    var result = await _authService.signup(
        _emailController.text, _passwordController.text);
    switchLoading();
    if (result is String) {
      return showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: const Text('Error'),
                content: Text(result),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('OK'))
                ],
              ));
    }
    //else navigate to next screen
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const Registration1()));
  }

  void switchLoading() {
    setState(() {
      _loading = !_loading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: 400,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/background.png'),
                          fit: BoxFit.fill)),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: 30,
                        width: 80,
                        height: 200,
                        child: FadeAnimation(
                            1,
                            Container(
                              decoration: const BoxDecoration(
                                  image: const DecorationImage(
                                      image: const AssetImage(
                                          'assets/images/light-1.png'))),
                            )),
                      ),
                      Positioned(
                        left: 140,
                        width: 80,
                        height: 150,
                        child: FadeAnimation(
                            1.3,
                            Container(
                              decoration: const BoxDecoration(
                                  image: const DecorationImage(
                                      image: AssetImage(
                                          'assets/images/light-2.png'))),
                            )),
                      ),
                      Positioned(
                        right: 40,
                        top: 40,
                        width: 80,
                        height: 150,
                        child: FadeAnimation(
                            1.5,
                            Container(
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/clock.png'))),
                            )),
                      ),
                      Positioned(
                        child: FadeAnimation(
                            1.6,
                            Container(
                              margin: const EdgeInsets.only(top: 50),
                              child: const Center(
                                child: const Text(
                                  "Ride with truckngo ",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    children: <Widget>[
                      FadeAnimation(
                          1.8,
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  const BoxShadow(
                                      color: const Color.fromRGBO(
                                          143, 148, 251, .2),
                                      blurRadius: 20.0,
                                      offset: const Offset(0, 10))
                                ]),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: const BoxDecoration(
                                      border: const Border(
                                          bottom:
                                              BorderSide(color: Colors.grey))),
                                  child: TextField(
                                    keyboardType: TextInputType.emailAddress,
                                    controller: _emailController,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Email",
                                        hintStyle:
                                            TextStyle(color: Colors.grey[400])),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    controller: _passwordController,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Password",
                                        hintStyle:
                                            TextStyle(color: Colors.grey[400])),
                                  ),
                                )
                              ],
                            ),
                          )),
                      const SizedBox(
                        height: 30,
                      ),
                      AuthBtn(
                          isLoading: _loading,
                          text: 'NEXT',
                          onTap: () async => await _onNextTapped()),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: FadeAnimation(
                              1.5,
                              const Text(
                                "I Have an account? Sign IN",
                                style: const TextStyle(
                                    color: Color.fromRGBO(143, 148, 251, 1)),
                              ))),
                      const SizedBox(
                        height: 30,
                      ),
                      FadeAnimation(
                          1.5,
                          const Text(
                            "Wants to request a trip? Get Passenger App",
                            style: const TextStyle(
                                color: Color.fromRGBO(143, 148, 251, 1)),
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
