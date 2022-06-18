import 'dart:io';
import 'dart:typed_data';

import 'package:asensiofinal/models/personal_details_model.dart';
import 'package:asensiofinal/provider/signup_provider.dart';
import 'package:asensiofinal/screens/success.dart';
import 'package:asensiofinal/services/cloud_firestore_service.dart';
import 'package:asensiofinal/services/picker_service.dart';
import 'package:asensiofinal/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class cardetails extends StatefulWidget {
  const cardetails({Key? key}) : super(key: key);

  @override
  _cardetailsState createState() => _cardetailsState();
}

class _cardetailsState extends State<cardetails> {
  final formKey = GlobalKey();
  String name = "";
  Uint8List? image;
  File? fileImage;
  Uint8List? document;
  File? fileDocument;
  late TextEditingController numberPlate;
  late TextEditingController driverLicense;
  late bool loading;

  @override
  void initState() {
    // TODO: implement initState
    numberPlate = TextEditingController(text: '');
    driverLicense = TextEditingController(text: '');
    loading = false;
  }

  String? validateForm() {
    if (numberPlate.text.isEmpty || numberPlate.text.length < 6) {
      return 'Enter a valid number plate';
    }
    if (driverLicense.text.isEmpty || driverLicense.text.length < 6) {
      return 'Enter a valid driver license';
    }
    if (document == null) {
      return 'upload car document';
    }
    if (image == null) {
      return 'upload car image';
    }
  }

  Future _onNext() async {
    var res = validateForm();
    if (res != null) {
      return ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(res)));
    }
    Provider.of<SignUpProvider>(context, listen: false).setField =
        PersonalDetailsModel.fromJson({
      'numberPlate': numberPlate.text,
      'dl': driverLicense.text,
    });

    setState(() {
      loading = true;
    });
    //upload image and document
    var instance = StorageService.instance;
    String carDocs = await instance.uploadCarDocs(fileDocument!);
    String carImage = await instance.uploadCarImage(fileImage!);
    Provider.of<SignUpProvider>(context, listen: false).setField =
        PersonalDetailsModel.fromJson({
      'carDocs': carDocs,
      'carImage': carImage,
    });
    var result = await CloudFirestoreService.instance.sendPersonalData(
        Provider.of<SignUpProvider>(context, listen: false).personalDetails!);
    setState(() {
      loading = false;
    });
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
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const SuccessScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final GlobalKey<ScaffoldState> _ScaffoldKey = GlobalKey<ScaffoldState>();
    final devSize = MediaQuery.of(context).size;
    return Scaffold(
      key: _ScaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: const Color(0xFFffffff),
      body: Container(
        padding: const EdgeInsets.only(left: 40, right: 40),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height * 0.04,
                ),
                Text(
                  "Enter Car  ",
                  style: TextStyle(fontSize: 30, color: Colors.blue[600]),
                ),
                Text(
                  "Details !",
                  style: TextStyle(fontSize: 30, color: Colors.blue[600]),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                TextFormField(
                  controller: numberPlate,
                  decoration: const InputDecoration(
                    labelText: "Enter number plate ",
                  ),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                TextFormField(
                  controller: driverLicense,
                  decoration: const InputDecoration(
                    labelText: "Driving license number ",
                  ),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                Center(
                  child: TextButton(
                      onPressed: () async {
                        var res = await showDialog(
                            context: context,
                            builder: (ctx) {
                              return SimpleDialog(
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(
                                            context, ImageSource.camera);
                                      },
                                      child: const Text('Camera')),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(
                                            context, ImageSource.gallery);
                                      },
                                      child: const Text('Gallery')),
                                ],
                                title: const Center(
                                  child: Text(
                                    'Choose an image source',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                              );
                            });
                        if (res != null) {
                          var result =
                              await PickerService.instance.pickImage(res);
                          if (result != null) {
                            document = result[0];
                            fileDocument = File(result[1]);
                            setState(() {});
                          }
                        }
                      },
                      child: const Text('Upload Car Documents')),
                ),

                Container(
                  height: devSize.height * .3,
                  child: document != null
                      ? Image.memory(document!)
                      : const Center(
                          child: Icon(Icons.image),
                        ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                // TextFormField(
                //   decoration: InputDecoration(
                //     labelText: "upload car picture",
                //   ),
                // ),
                Center(
                  child: TextButton(
                      onPressed: () async {
                        var res = await showDialog(
                            context: context,
                            builder: (ctx) {
                              return SimpleDialog(
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(
                                            context, ImageSource.camera);
                                      },
                                      child: const Text('Camera')),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(
                                            context, ImageSource.gallery);
                                      },
                                      child: const Text('Gallery')),
                                ],
                                title: const Center(
                                  child: Text(
                                    'Choose an image source',
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ),
                              );
                            });
                        if (res != null) {
                          var image =
                              await PickerService.instance.pickImage(res);
                          if (image != null) {
                            this.image = image[0];
                            fileImage = File(image[1]);
                            setState(() {});
                          }
                        }
                      },
                      child: const Text('Upload Car Image')),
                ),

                Container(
                  height: devSize.height * .3,
                  child: image != null
                      ? Image.memory(image!)
                      : const Center(
                          child: Icon(Icons.image),
                        ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.05,
                ),

                GestureDetector(
                  onTap: loading ? null : _onNext,
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: const LinearGradient(colors: [
                          Color.fromARGB(255, 14, 19, 128),
                          Color.fromRGBO(143, 148, 251, .6),
                        ])),
                    child: loading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : const Center(
                            child: Text(
                              "NEXT",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                  ),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
