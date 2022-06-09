import 'package:asensiofinal/Animation/fade_animation.dart';
import 'package:asensiofinal/screens/Registration.dart';
import 'package:asensiofinal/screens/Signup.dart';
import 'package:asensiofinal/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';

class SignUpPage extends StatefulWidget {

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late TextEditingController _emailController;

  late TextEditingController _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController(text: '');
    _passwordController = TextEditingController(text: '');
    
  }


  Future _onNextTapped()async{
    final emailValidator = ValidationBuilder().email('Invalid Email').build();
    final passwordValidator = ValidationBuilder().minLength(6,'Minimum length of password should be 6').build();
    //validate Form
    var msg = emailValidator(_emailController.text);
    if(msg != null)return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    var msg1 = passwordValidator(_passwordController.text);
     if(msg1 != null)return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg1)));
    //if form is not valid show snackbar
    //register user

    //else navigate to next screen 
     Navigator.push(context, MaterialPageRoute(builder: (_)=>Registration1()));
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
	              decoration: BoxDecoration(
	                image: DecorationImage(
	                  image: AssetImage('assets/images/background.png'),
	                  fit: BoxFit.fill
	                )
	              ),
	              child: Stack(
	                children: <Widget>[
	                  Positioned(
	                    left: 30,
	                    width: 80,
	                    height: 200,
	                    child: FadeAnimation(1, Container(
	                      decoration: BoxDecoration(
	                        image: DecorationImage(
	                          image: AssetImage('assets/images/light-1.png')
	                        )
	                      ),
	                    )),
	                  ),
	                  Positioned(
	                    left: 140,
	                    width: 80,
	                    height: 150,
	                    child: FadeAnimation(1.3, Container(
	                      decoration: BoxDecoration(
	                        image: DecorationImage(
	                          image: AssetImage('assets/images/light-2.png')
	                        )
	                      ),
	                    )),
	                  ),
	                  Positioned(
	                    right: 40,
	                    top: 40,
	                    width: 80,
	                    height: 150,
	                    child: FadeAnimation(1.5, Container(
	                      decoration: BoxDecoration(
	                        image: DecorationImage(
	                          image: AssetImage('assets/images/clock.png')
	                        )
	                      ),
	                    )),
	                  ),
	                  Positioned(
	                    child: FadeAnimation(1.6, Container(
	                      margin: EdgeInsets.only(top: 50),
	                      child: Center(
	                        child: Text("Ride with truckngo ", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),),
	                      ),
	                    )),
	                  )
	                ],
	              ),
	            ),
	            Padding(
	              padding: EdgeInsets.all(30.0),
	              child: Column(
	                children: <Widget>[
	                  FadeAnimation(1.8, Container(
	                    padding: EdgeInsets.all(5),
	                    decoration: BoxDecoration(
	                      color: Colors.white,
	                      borderRadius: BorderRadius.circular(10),
	                      boxShadow: [
	                        BoxShadow(
	                          color: Color.fromRGBO(143, 148, 251, .2),
	                          blurRadius: 20.0,
	                          offset: Offset(0, 10)
	                        )
	                      ]
	                    ),
	                    child: Column(
	                      children: <Widget>[
	                        Container(
	                          padding: EdgeInsets.all(8.0),
	                          decoration: BoxDecoration(
	                            border: Border(bottom: BorderSide(color: Colors.grey))
	                          ),
	                          child: TextField(
                              keyboardType: TextInputType.emailAddress,
                              controller: _emailController,
	                            decoration: InputDecoration(
	                              border: InputBorder.none,
	                              hintText: "Email",
	                              hintStyle: TextStyle(color: Colors.grey[400])
	                            ),
	                          ),
	                        ),
	                        Container(
	                          padding: EdgeInsets.all(8.0),
	                          child: TextField(
                              controller: 
                              _passwordController,
	                            decoration: InputDecoration(
	                              border: InputBorder.none,
	                              hintText: "Password",
	                              hintStyle: TextStyle(color: Colors.grey[400])
	                            ),
	                          ),
	                        )
	                      ],
	                    ),
	                  )),
	                  SizedBox(height: 30,),
	                  FadeAnimation(2, GestureDetector(
                      onTap: 
                      _onNextTapped,
                                          child: Container(
                                            height: 50,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              gradient: LinearGradient(
                                                colors: [
                                                  Color.fromRGBO(143, 148, 251, 1),
                                                  Color.fromRGBO(143, 148, 251, .6),
                                                ]
                                              )
                                            ),
                                            child: Center(
                                              child: Text("NEXT", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                                            ),
                                          ),
                                        )),
	                  SizedBox(height: 20,),
	                  GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: FadeAnimation(1.5, Text("I Have an account? Sign IN", style: TextStyle(color: Color.fromRGBO(143, 148, 251, 1)),))),
	                  SizedBox(height: 30,),
	                  FadeAnimation(1.5, Text("Wants to request a trip? Get Passenger App", style: TextStyle(color: Color.fromRGBO(143, 148, 251, 1)),)),
	                ],
	              ),
	            )
	          ],
	        ),
	      ),
      )
    );
  }
}