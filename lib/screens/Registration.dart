
import 'package:asensiofinal/screens/Registration2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Registration1 extends StatefulWidget {
  const Registration1({ Key? key }) : super(key: key);
  @override
  _Registration1State createState() => _Registration1State();
}
class _Registration1State extends State<Registration1> {
  final formKey =GlobalKey();
  String name ="";
  @override
  Widget build(BuildContext context) {
    final double height =MediaQuery.of(context).size.height;
    final GlobalKey<ScaffoldState> _ScaffoldKey =GlobalKey<ScaffoldState>(); 
    return Scaffold(
      key: _ScaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Color(0xFFffffff),
      body: Container(
        padding: const EdgeInsets.only(left:40, right: 40),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height*0.04,),
                Text("Enter Personal ", style: TextStyle(fontSize: 30, color: Colors.blue[600]),),
                Text("Details !",style: TextStyle(fontSize: 30, color: Colors.blue[600]),),
                SizedBox(height: height*0.05,),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Please enter name",
                  ),
                  validator: (value)
                  {
                    if( value== null || value.isEmpty ||RegExp(r'^[a-z A-Z+$').hasMatch(value)){
                      return "Enter correct name";
                    } else{
                      return null;
                    }
                  },
          
                ),
                SizedBox(height: height*0.05,),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Please enter phone number",
                  ),
                  validator: (value)
                  {
                    if( value== null || value.isEmpty ||RegExp(r'^[+]*[(]{0-1}[0-9]{1,4}[)]{0,1}[-\s\./0-9] +$').hasMatch(value)){
                      return "please enter correct number";
                    } else{
                      return null;
                    }
                  },
          
                ),
                SizedBox(height: height*0.05,),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Enter your city ",
                  ),
                  validator: (value)
                  {
                    if( value== null || value.isEmpty ||RegExp(r'^[a-z A-Z+$').hasMatch(value)){
                      return "Enter correct city";
                    } else{
                      return null;
                    }
                  },
          
                ),
                SizedBox(height: height*0.05,),
          
                GestureDetector(
                  onTap:(){
                           Navigator.push(context, MaterialPageRoute(builder: (_)=>Registration2()));
                  },
                  child: Container(
                                                height: 50,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      Color.fromARGB(255, 14, 19, 128),
                                                      Color.fromRGBO(143, 148, 251, .6),
                                                    ]
                                                  )
                                                ),
                                                child: Center(
                                                  child: Text("NEXT", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                                                ),
                                              ),
                ),
              ],
              
            ),
          ),

        ),
      ),
           
    );
  }
}