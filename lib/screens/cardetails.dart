
import 'dart:typed_data';

import 'package:asensiofinal/screens/success.dart';
import 'package:asensiofinal/services/picker_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class cardetails extends StatefulWidget {
  const cardetails({ Key? key }) : super(key: key);

  @override
  _cardetailsState createState() => _cardetailsState();
}


class _cardetailsState extends State<cardetails> {
  final formKey =GlobalKey();
  String name ="";
  Uint8List? image ; 
  Uint8List? document ; 
  @override
  Widget build(BuildContext context) {
    final double height =MediaQuery.of(context).size.height;
    final GlobalKey<ScaffoldState> _ScaffoldKey =GlobalKey<ScaffoldState>();
    final devSize = MediaQuery.of(context).size;
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
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height*0.04,),
                Text("Enter Car  ", style: TextStyle(fontSize: 30, color: Colors.blue[600]),),
                Text("Details !",style: TextStyle(fontSize: 30, color: Colors.blue[600]),),
                SizedBox(height: height*0.05,),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Enter number plate ",
                  ),
                ),
                SizedBox(height: height*0.05,),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Driving license number ",
                  ),
                ),
                SizedBox(height: height*0.05,),
                Center(
                 child: TextButton(onPressed: ()async{
                   var res = await showDialog(context: context, builder: (ctx){
                     return SimpleDialog(
                       children: [
                         TextButton(onPressed: () {Navigator.pop(context,ImageSource.camera);   },
                         child: Text('Camera')),
                         
                         TextButton(onPressed: () { Navigator.pop(context,ImageSource.gallery); },
                         child: Text('Gallery')),
                         
                       ],
                       title: Center(
                         child: Text('Choose an image source',style: TextStyle(
                            fontSize: 12
                         ),),
                       ),
                     );
                   });
                   if (res != null){
                     var result = await PickerService.instance.pickImage(res);
                     if (result != null){
                       this.document =  result;
                       setState(() {
                         
                       });
                     }
                   }
                 }, child: const Text('Upload Car Documents')),
               ),
    
               Container(
                 height: devSize.height*.3,
                 color: Colors.black38,
                 child: document != null ?Image.memory(document!):null,
               ),
                SizedBox(height: height*0.05,),
                // TextFormField(
                //   decoration: InputDecoration(
                //     labelText: "upload car picture",
                //   ),
                // ),
               Center(
                 child: TextButton(onPressed: ()async{
                   var res = await showDialog(context: context, builder: (ctx){
                     return SimpleDialog(
                       children: [
                         TextButton(onPressed: () {Navigator.pop(context,ImageSource.camera);   },
                         child: Text('Camera')),
                         
                         TextButton(onPressed: () { Navigator.pop(context,ImageSource.gallery); },
                         child: Text('Gallery')),
                         
                       ],
                       title: Center(
                         child: Text('Choose an image source',style: TextStyle(
                            fontSize: 12
                         ),),
                       ),
                     );
                   });
                   if (res != null){
                     var image = await PickerService.instance.pickImage(res);
                     if (image != null){
                       this.image =  image;
                       setState(() {
                         
                       });
                     }
                   }
                 }, child: const Text('Upload Car Image')),
               ),
    
               Container(
                 height: devSize.height*.3,
                 color: Colors.black38,
                 child: image != null ?Image.memory(image!):null,
               ),
                SizedBox(height: height*0.05,),
          
                GestureDetector(
                  onTap:(){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>SuccessScreen()));    
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
                SizedBox(height: height*0.05,),
                 
              ],
              
            ),
          ),
    
        ),
      ),
           
    );
  }
}