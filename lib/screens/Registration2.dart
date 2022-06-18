import 'package:asensiofinal/models/gender.dart';
import 'package:asensiofinal/models/personal_details_model.dart';
import 'package:asensiofinal/provider/signup_provider.dart';
import 'package:asensiofinal/screens/cardetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:provider/provider.dart';

class Registration2 extends StatefulWidget {
  const Registration2({Key? key}) : super(key: key);

  @override
  _Registration2State createState() => _Registration2State();
}

class _Registration2State extends State<Registration2> {
  final formKey = GlobalKey();
  String name = "";

  late TextEditingController _dobController;
  late TextEditingController _placeController;
  Gender _currentGender = Gender.MALE;
  late DateTime _dob;

  @override
  void initState() {
    _dobController = TextEditingController(text: '1/1/1999');
    _dob = DateTime(1999);
    _placeController = TextEditingController(text: '');
  }

  final cityValidator =
      ValidationBuilder().minLength(2, 'Enter a valid city').build();

  String? validateForm() {
    return cityValidator(_placeController.text.trim());
  }

  Future _onTap() async {
    var res = validateForm();
    if (res != null) {
      return ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(res)));
    }
    Provider.of<SignUpProvider>(context, listen: false).setField =
        PersonalDetailsModel.fromJson({
      'dob': Timestamp.fromDate(_dob),
      'placeOfBirth': _placeController.text,
      'gender': _currentGender.index
    });
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => cardetails()));
  }

  void onGenderChanged(Gender? gender) {
    if (gender != null) {
      setState(() {
        _currentGender = gender;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    // final GlobalKey<ScaffoldState> _ScaffoldKey = GlobalKey<ScaffoldState>();
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height * 0.04,
              ),
              Text(
                "Enter Personal  ",
                style: TextStyle(fontSize: 30, color: Colors.blue[600]),
              ),
              Text(
                "Details!!",
                style: TextStyle(fontSize: 30, color: Colors.blue[600]),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      enabled: false,
                      controller: _dobController,
                      decoration: const InputDecoration(
                        labelText: "Date of birth ",
                      ),
                    ),
                  ),
                  TextButton(
                      onPressed: () async {
                        var res = await showDatePicker(
                            context: context,
                            initialDate: DateTime(1999),
                            firstDate: DateTime(1920),
                            lastDate: DateTime.now());
                        if (res != null) {
                          _dobController.text =
                              '${res.day}/${res.month}/${res.year}';
                          _dob = res;
                        }
                      },
                      child: const Text('Change date'))
                ],
              ),
              SizedBox(
                height: height * 0.05,
              ),
              TextFormField(
                controller: _placeController,
                decoration: const InputDecoration(
                  labelText: "Place of birth",
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<Gender>(
                        value: Gender.MALE,
                        title: const Text('MALE'),
                        groupValue: _currentGender,
                        onChanged: onGenderChanged),
                  ),
                  Expanded(
                    child: RadioListTile<Gender>(
                        value: Gender.FEMALE,
                        title: const Text('FEMALE'),
                        groupValue: _currentGender,
                        onChanged: onGenderChanged),
                  ),
                ],
              ),
              GestureDetector(
                onTap: _onTap,
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
