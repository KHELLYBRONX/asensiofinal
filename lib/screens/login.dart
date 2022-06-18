import 'package:asensiofinal/Animation/fade_animation.dart';
import 'package:asensiofinal/screens/Signup.dart';
import 'package:asensiofinal/screens/home.dart';
import 'package:asensiofinal/services/auth_service.dart';
import 'package:asensiofinal/widgets/auth_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_validator/form_validator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
    final AuthService _authService = AuthService.instance;

    late String? Function(String?) emailValidator; 

    late String? Function(String?) passwordValidator;
    late bool loading;
    late TextEditingController emailController;
    late TextEditingController passwordController;
    @override
    void initState(){
      loading = false;
      emailController = TextEditingController(text: '');
      passwordController = TextEditingController(text: '');
      emailValidator = ValidationBuilder().email('Invalid Email').build();
      passwordValidator = ValidationBuilder().minLength(6, 'Password length should be greater than 6').required().build();
    }

    void switchLoading(){
        loading = !loading;
        print(loading);
        setState(() {
        // print('object');
      });
    }



  String? checkFormValidity(String email,String password){
    var res = emailValidator(email);
    var res1 = passwordValidator(password);
    return res??res1;
  }

  Future _onLogIn(String email,String password,BuildContext context)async{
     var res = checkFormValidity(email, password);
     if (res != null) return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res)));
      switchLoading();
      var result = await _authService.login(email, password);
      switchLoading();
     if (result is String) {
       return showDialog(context: context, builder: 
     (_)=>AlertDialog(
      title: const Text('Error'),
      content: Text(result),
      actions: [
        TextButton(onPressed: ()=>Navigator.pop(context), child: const Text('OK'))
      ],
     ));
     }
     Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const HomeScreen()));
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
                      image: const DecorationImage(
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
                                      image: AssetImage(
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
                                child: Text(
                                  "Login",
                                  style: const TextStyle(
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
                                boxShadow: const[
                                  BoxShadow(
                                      color: const Color.fromRGBO(143, 148, 251, .2),
                                      blurRadius: 20.0,
                                      offset: Offset(0, 10))
                                ]),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          bottom:
                                              BorderSide(color: Colors.grey))),
                                  child: TextField(
                                    keyboardType: TextInputType.emailAddress,
                                    controller: emailController,
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
                                    keyboardType: TextInputType.visiblePassword,
                                    controller: passwordController,
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
                        text: 'Login',
                        isLoading: loading, onTap: ()async {
                        await _onLogIn(emailController.text,passwordController.text, context);
                        
                        },),
                       
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => SignUpPage()));
                          },
                          child: FadeAnimation(
                              1.5,
                              const Text(
                                "Don't have an account? Signup",
                                style: TextStyle(
                                    color: Color.fromRGBO(143, 148, 251, 1)),
                              ))),
                      const SizedBox(
                        height: 30,
                      ),
                      FadeAnimation(
                          1.5,
                          const Text(
                            "Forgot Password?",
                            style: TextStyle(
                                color: const Color.fromRGBO(143, 148, 251, 1)),
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
