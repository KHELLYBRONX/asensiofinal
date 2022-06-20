// ignore: file_names
import 'dart:io';
import 'dart:typed_data';
import 'package:asensiofinal/models/personal_details_model.dart';
import 'package:asensiofinal/provider/signup_provider.dart';
import 'package:asensiofinal/screens/Registration2.dart';
import 'package:asensiofinal/services/picker_service.dart';
import 'package:asensiofinal/utils/current_driver_image_util.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class Registration1 extends StatefulWidget {
  const Registration1({Key? key}) : super(key: key);
  @override
  _Registration1State createState() => _Registration1State();
}

class _Registration1State extends State<Registration1> {
  final nameValidator =
      ValidationBuilder().minLength(2, 'Invalid Email').build();
  final phoneValidator =
      ValidationBuilder().phone('Enter a valid phone number').build();
  final cityValidator =
      ValidationBuilder().minLength(2, 'Invalid Email').build();

  late TextEditingController _nameController;
  late TextEditingController _cityController;
  late TextEditingController _phoneController;
  Uint8List? userImageData;
  File? userImage;

  @override
  void initState() {
    _nameController = TextEditingController(text: '');
    _cityController = TextEditingController(text: '');
    _phoneController = TextEditingController(text: '');
  }

  Future _onNext() async {
    var msg = nameValidator(_nameController.text);
    if (msg != null) {
      return ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(msg)));
    }
    var msg1 = phoneValidator(_phoneController.text);
    if (msg1 != null) {
      return ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(msg1)));
    }

    var msg2 = cityValidator(_cityController.text);
    if (msg2 != null) {
      return ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(msg2)));
    }

    if (userImage == null) {
      return ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select an image to proceed')));
    }

    print(currentDriverImage);
    //send data to firebase
    Provider.of<SignUpProvider>(context, listen: false).setField =
        PersonalDetailsModel.fromJson({
      'name': _nameController.text,
      'phoneNumber': _phoneController.text,
      'city': _cityController.text,
    });
    //navigate to next screen
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const Registration2()));
  }

  Future _onChangeImage() async {
    var res = await showDialog(
        context: context,
        builder: (ctx) {
          return SimpleDialog(
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context, ImageSource.camera);
                  },
                  child: const Text('Camera')),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context, ImageSource.gallery);
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
      var image = await PickerService.instance.pickImage(res);
      if (image != null) {
        setState(() {
          userImageData = image[0];
          userImage = File(image[1]);
          currentDriverImage = File(image[1]);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    // final GlobalKey<ScaffoldState> _ScaffoldKey =
    return Scaffold(
      // key: _ScaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
      backgroundColor: Color(0xFFffffff),
      body: Container(
        padding: const EdgeInsets.only(left: 40, right: 40),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height * 0.04,
              ),
              Text(
                "Enter Personal ",
                style: TextStyle(fontSize: 30, color: Colors.blue[600]),
              ),
              Text(
                "Details !",
                style: TextStyle(fontSize: 30, color: Colors.blue[600]),
              ),
              SizedBox(
                height: height * 0.005,
              ),
              Center(
                  child: CircleAvatar(
                      backgroundColor: userImageData != null
                          ? null
                          : Colors.black.withOpacity(.2),
                      radius: 50,
                      backgroundImage: userImageData != null
                          ? MemoryImage(userImageData!)
                          : null,
                      child: userImageData != null
                          ? null
                          : const Icon(Icons.image))),
              Center(
                  child: TextButton(
                      onPressed: _onChangeImage,
                      child: const Text("Change Image"))),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: "Please enter name",
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: "Please enter phone number",
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              TextField(
                controller: _cityController,
                decoration: InputDecoration(
                  labelText: "Enter your city ",
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              GestureDetector(
                onTap: _onNext,
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(colors: [
                        Color.fromARGB(255, 14, 19, 128),
                        Color.fromRGBO(143, 148, 251, .6),
                      ])),
                  child: Center(
                    child: Text(
                      "NEXT",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
