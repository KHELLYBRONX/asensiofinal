
import 'package:asensiofinal/screens/cardetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Registration2 extends StatefulWidget {
  const Registration2({ Key? key }) : super(key: key);

  @override
  _Registration2State createState() => _Registration2State();
}


class _Registration2State extends State<Registration2> {
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
                Text("Enter Personal  ", style: TextStyle(fontSize: 30, color: Colors.blue[600]),),
                Text("Details!!",style: TextStyle(fontSize: 30, color: Colors.blue[600]),),
                SizedBox(height: height*0.05,),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Date of birth ",
                  ),
                 
                ),
                SizedBox(height: height*0.05,),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Place of birth",
                  ),

                ),
                SizedBox(height: height*0.05,),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: " Gender" ,
                  ),
                ),
                SizedBox(height: height*0.05,),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: " Nationality" ,
                  ),
                ),
                SizedBox(height: height*0.05,),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>cardetails()));
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