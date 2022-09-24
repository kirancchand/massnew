import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:massnew/Api/api.dart';
import 'package:massnew/Models/loginModel.dart';
import 'package:massnew/Models/profileModel.dart';
import 'package:massnew/Models/registrationModel.dart';
import 'package:massnew/Screens/tabScreen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfilePage extends StatefulWidget {
  EditProfilePage({this.data});
  ProfileClass data;
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController fullname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController cpass = TextEditingController();
  TextEditingController internatinalId = TextEditingController();
  TextEditingController passportNo = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController qualification = TextEditingController();
  GlobalKey<ScaffoldState> key = GlobalKey();
  String dropdownValue = 'Male';
  bool check = false;
  bool spin = false;
  File i;
  String fileName = '';
  @override
  Future getImage() async {
    final pickedFile =
        await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        i = File(pickedFile.path);
        fileName = i.path.split('/').last;
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  void initState() {
    fullname.text = widget.data.data.studentProfileView.firstName ?? '';
    lastname.text = widget.data.data.studentProfileView.lastName ?? '';
    email.text = widget.data.data.studentProfileView.email ?? '';
    phone.text = widget.data.data.studentProfileView.phno ?? '';
    cpass.text = widget.data.data.studentProfileView.studentPwd ?? '';
    internatinalId.text =
        widget.data.data.studentProfileView.studentCivilId ?? '';
    passportNo.text = widget.data.data.studentProfileView.passNo ?? '';
    dropdownValue = widget.data.data.studentProfileView.gender ?? '';
    dob.text = widget.data.data.studentProfileView.dob.day.toString() +
        "/" +
        widget.data.data.studentProfileView.dob.month.toString() +
        "/" +
        widget.data.data.studentProfileView.dob.year.toString();
    qualification.text =
        widget.data.data.studentProfileView.qualification ?? '';

    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Row(
            children: [
              Icon(
                Icons.arrow_back_ios_sharp,
                size: 20,
                color: Color(0xff026a37),
              ),
              Text(
                'Back',
                style: TextStyle(
                  color: Color(0xff026a37),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: ModalProgressHUD(
          inAsyncCall: spin,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),

                Text(
                  'Edit Profile',
                  style: TextStyle(
                      color: Color(0xff026a37),
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                SizedBox(
                  height: 15,
                ),
                SingleTextWidget(
                  name: 'Full Name',
                  type: TextInputType.name,
                  icon: Icon(
                    Icons.person_outline_sharp,
                    color: Color(0xff9961be),
                  ),
                  controller: fullname,
                ),
                SizedBox(
                  height: 10,
                ),
                SingleTextWidget(
                  name: 'Last Name',
                  type: TextInputType.name,
                  icon: Icon(
                    Icons.person_outline_sharp,
                    color: Color(0xff9961be),
                  ),
                  controller: lastname,
                ),
                SizedBox(
                  height: 10,
                ),
                SingleTextWidget(
                  name: 'Email',
                  type: TextInputType.emailAddress,
                  icon: Icon(
                    Icons.email_outlined,
                    color: Color(0xff9961be),
                  ),
                  controller: email,
                ),
                SizedBox(
                  height: 10,
                ),
                SingleTextWidget(
                  name: 'Phone Number',
                  type: TextInputType.number,
                  icon: Icon(
                    Icons.lock_outline_sharp,
                    color: Color(0xff9961be),
                  ),
                  controller: phone,
                ),
                SizedBox(
                  height: 10,
                ),
                SingleTextWidget(
                  name: 'Confirm Password',
                  type: TextInputType.name,
                  icon: Icon(
                    Icons.lock_outline_sharp,
                    color: Color(0xff9961be),
                  ),
                  controller: cpass,
                ),
                SizedBox(
                  height: 10,
                ),
                SingleTextWidget(
                  name: 'International id',
                  controller: internatinalId,
                  type: TextInputType.number,
                  icon: Container(
                    height: 1,
                    width: 1,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SingleTextWidget(
                  name: 'Passport No',
                  controller: passportNo,
                  type: TextInputType.number,
                  icon: Container(
                    height: 1,
                    width: 1,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                // SingleTextWidget(
                //   name: 'Gender',
                //   controller: gender,
                //   type: TextInputType.name,
                //   icon: Container(
                //     height: 1,
                //     width: 1,
                //   ),
                // ),
                Container(
                  height: 45,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    icon: Icon(Icons.keyboard_arrow_down),
                    iconSize: 23,
                    elevation: 16,
                    underline: Container(),
                    style: TextStyle(color: Colors.black),
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue = newValue;
                      });
                    },
                    items: <String>[
                      'Male',
                      'Female',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SingleTextWidget(
                  name: 'Date of Birth (dd/mm/yyyy)',
                  type: TextInputType.datetime,
                  controller: dob,
                  icon: Container(
                    height: 1,
                    width: 1,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SingleTextWidget(
                  name: 'Qualification',
                  type: TextInputType.name,
                  controller: qualification,
                  icon: Container(
                    height: 1,
                    width: 1,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    getImage();
                  },
                  child: Container(
                    height: 45,
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    alignment: Alignment.centerLeft,
                    child:
                        (fileName.isEmpty) ? Text('Photo') : Text('$fileName'),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 40,
                  width: 170,
                  decoration: BoxDecoration(
                    color: Color(0xff026a37),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: MaterialButton(
                    onPressed: () async {
                      if (fullname.text.isNotEmpty &&
                          lastname.text.isNotEmpty &&
                          email.text.isNotEmpty &&
                          phone.text.isNotEmpty &&
                          passportNo.text.isNotEmpty &&
                          dropdownValue.isNotEmpty &&
                          dob.text.isNotEmpty &&
                          cpass.text.isNotEmpty &&
                          internatinalId.text.isNotEmpty &&
                          qualification.text.isNotEmpty &&
                          i != null) {
                        setState(() {
                          spin = true;
                        });
                        RegistrationClass out = await editprofileApi(
                          fname: fullname.text,
                          lname: lastname.text,
                          email: email.text,
                          phone: phone.text,
                          passport: passportNo.text,
                          pass: cpass.text,
                          dob: dob.text,
                          qualification: qualification.text,
                          civil: internatinalId.text,
                          gender: dropdownValue,
                          file: i,
                        );
                        key.currentState.showSnackBar(
                          SnackBar(
                            content: Text('Successfully Updated'),
                          ),
                        );
                        // key.currentState.showSnackBar(
                        //     SnackBar(content: Text(out.data.registeration)));
                        Future.delayed(Duration(seconds: 2));
                        // if (out.data.registeration ==
                        //     'Registeration Successfully') {
                        LoginClass l = await loginApi(
                          uname: internatinalId.text,
                          pass: cpass.text,
                        );
                        var pref = await SharedPreferences.getInstance();
                        pref.setString('sid', l.data.details[0].studentId);
                        pref.setString(
                            'civilid', l.data.details[0].studentCivilId);
                        setState(() {
                          spin = false;
                        });
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NavBar(),
                          ),
                        );
                        // }
                        // print(out);
                      } else {
                        key.currentState.showSnackBar(
                          SnackBar(
                            content: Text(
                                'Fill all Feilds and check for terms and condition'),
                          ),
                        );
                      }
                    },
                    child: Text(
                      'UPDATE',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SingleTextWidget extends StatelessWidget {
  SingleTextWidget({this.name, this.controller, this.icon, this.type});
  String name;
  Widget icon;
  TextEditingController controller;
  TextInputType type;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        decoration: InputDecoration(
          counterText: '',
          suffixIcon: icon,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          hintText: name,
          hintStyle: TextStyle(
            fontSize: 13,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
