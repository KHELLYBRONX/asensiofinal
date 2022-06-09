import 'dart:async';

import 'package:asensiofinal/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({ Key? key }) : super(key: key);

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  
  @override
  // ignore: must_call_super
  void initState() {
    Timer(const Duration(seconds: 2),() 
    {
      Navigator.push(context, MaterialPageRoute(builder: (_)=>HomeScreen()));
     });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Column(
       mainAxisAlignment: MainAxisAlignment.center,
       children: [
       Lottie.asset('assets/animations/success.zip'),
       Text('Enjoy good service with TrucknGo drivers app',
       textAlign: TextAlign.center,style: TextStyle(
         fontSize: 18,
         
       ),)
     ],), 
    );
  }
}