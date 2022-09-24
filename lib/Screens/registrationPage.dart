import 'dart:io';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:massnew/Api/api.dart';
import 'package:massnew/Models/loginModel.dart';
import 'package:massnew/Models/registrationModel.dart';
import 'package:massnew/Screens/tabScreen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController fullname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController cpass = TextEditingController();
  TextEditingController internatinalId = TextEditingController();
  TextEditingController passportNo = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController qualification = TextEditingController();
  GlobalKey<ScaffoldState> key = GlobalKey();
  String dropdownValue;
  String dropdownValuephno;
  bool check = false;
  bool spin = false;
  File i;
  String fileName = '';
  String _valueChanged1 = '';
  String _valueToValidate1 = '';
  String _valueSaved1 = '';
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

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,   //new line
      key: key,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        leadingWidth: 75,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
            child:Row(
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
            )
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: spin,
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                // CircleAvatar(
                //   radius: 40,
                //   backgroundImage: AssetImage(
                //     'assets/images/iconn.png',
                //   ),
                // ),
                // SizedBox(
                //   height: 5,
                // ),
                Text(
                  'Student Sign Up',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SingleTextWidget(
                  name: 'First name / الاسم الأول',
                  type: TextInputType.name,
                  icon: Icon(
                    Icons.person_outline_sharp,
                    color: Color(0xff016936),
                  ),
                  controller: fullname,
                ),
                SizedBox(
                  height: 10,
                ),
                SingleTextWidget(
                  name: 'Last name / الاسم الأخير',
                  type: TextInputType.name,
                  icon: Icon(
                    Icons.person_outline_sharp,
                    color: Color(0xff016936),
                  ),
                  controller: lastname,
                ),
                SizedBox(
                  height: 10,
                ),
                SingleTextWidget(
                  name: 'Email address / عنوان البريد الإلكتروني',
                  type: TextInputType.emailAddress,
                  icon: Icon(
                    Icons.email_outlined,
                    color: Color(0xff016936),
                  ),
                  controller: email,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 45,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                       Flexible(
                        child: Container(
                          padding: EdgeInsets.only(left: 10),
                          height: 45,
                          width: 65,
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: dropdownValuephno,
                            icon: Icon(Icons.keyboard_arrow_down),
                            hint: Text(
                              'Code',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            ),
                            iconSize: 18,
                            elevation: 10,
                            underline: Container(),
                            style: TextStyle(color: Colors.black),
                            onChanged: (String newValue) {
                              setState(() {
                                dropdownValuephno = newValue;
                              });
                            },
                            items: <String>['+965', '+91', '+20']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),


                      Container(
                        height: 45,
                        width: MediaQuery.of(context).size.width - 110,
                        child: TextFormField(
                          controller: phone,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            counterText: '',
                            suffixIcon: Icon(
                              Icons.phone,
                              color: Color(0xff016936),
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 8),
                            hintText: 'Phone number / رقم الهاتف',
                            hintStyle: TextStyle(
                              fontSize: 13,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SingleTextWidget(
                  name: 'Enter password / كلمة المرور',
                  type: TextInputType.name,
                  icon: Icon(
                    Icons.lock_outline_sharp,
                    color: Color(0xff016936),
                  ),
                  controller: pass,
                ),
                SizedBox(
                  height: 10,
                ),
                SingleTextWidget(
                  name: 'Confirm password / تأكيد كلمة المرور',
                  type: TextInputType.name,
                  icon: Icon(
                    Icons.lock_outline_sharp,
                    color: Color(0xff016936),
                  ),
                  controller: cpass,
                ),
                SizedBox(
                  height: 10,
                ),
                SingleTextWidget(
                  name: 'International id  /  رقم الهوية المحليه ',
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
                  name: 'Passport No / رقم جواز السفر',
                  controller: passportNo,
                  type: TextInputType.name,
                  icon: Container(
                    height: 1,
                    width: 1,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
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
                    hint: Text(
                      'Gender / الجنس',
                      style: TextStyle(color: Colors.black),
                    ),
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
                      // 'Select'
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
                  child: DateTimePicker(
                    type: DateTimePickerType.date,
                    dateMask: 'd MMM, yyyy',
                    controller: dob,
                    //initialValue: _initialValue,
                    firstDate: DateTime(1800),
                    lastDate: DateTime(2200),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Date of Birth / تاريخ الميلاد',
                      hintStyle: TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                      ),
                    ),
                    // timeLabelText: "Hour",
                    // selectableDayPredicate: (date) {
                    //   if (date.weekday == 6 || date.weekday == 7) {
                    //     return false;
                    //   }
                    //   return true;
                    // },
                    onChanged: (val) => setState(() => _valueChanged1 = val),
                    validator: (val) {
                      setState(() => _valueToValidate1 = val ?? '');
                      return null;
                    },
                    onSaved: (val) => setState(() => _valueSaved1 = val ?? ''),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SingleTextWidget(
                  name: 'Qualification / المؤهل',
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
                    child: (fileName.isEmpty)
                        ? Text('Photo(Click here) / صورة (أنواع الملفات المسموح بها jpg و jpeg و png)')
                        : Text('$fileName'),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                        value: check,
                        onChanged: (value) {
                          setState(() {
                            check = value;
                          });
                        }),
                    Text('I accept the terms & conditions')
                  ],
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
                    elevation: 10,
                    onPressed: () async {
                      if (fullname.text.isNotEmpty &&
                          lastname.text.isNotEmpty &&
                          email.text.isNotEmpty &&
                          phone.text.isNotEmpty &&
                          passportNo.text.isNotEmpty &&
                          dropdownValue.isNotEmpty &&
                          dob.text.isNotEmpty &&
                          cpass.text.isNotEmpty &&
                          pass.text.isNotEmpty &&
                          internatinalId.text.isNotEmpty &&
                          qualification.text.isNotEmpty &&
                          i != null) {
                        if (pass.text == cpass.text) {
                          setState(() {
                            spin = true;
                          });
                          String phno = dropdownValuephno + phone.text;
                          print(phno);
                          RegistrationClass out = await registrationApi(
                            fname: fullname.text,
                            lname: lastname.text,
                            email: email.text,
                            phone: phno,
                            passport: passportNo.text,
                            pass: cpass.text,
                            dob: dob.text,
                            qualification: qualification.text,
                            civil: internatinalId.text,
                            gender: dropdownValue,
                            file: i,
                          );
                          setState(() {
                            spin = false;
                          });

                          key.currentState.showSnackBar(
                            SnackBar(
                              content: Text(out.data.registeration),
                              backgroundColor: Color(0xff026a37),
                            ),
                          );
                          print(out.data.registeration);
                          // key.currentState.showSnackBar(
                          //     SnackBar(content: Text(out.data.registeration)));
                          Future.delayed(Duration(seconds: 2));
                          if (out.data.success == '200') {
                            LoginClass l = await loginApi(
                                uname: internatinalId.text, pass: cpass.text);
                            // if (l.data.success == 200) {
                            var pref = await SharedPreferences.getInstance();
                            pref.setString('sid', l.data.details[0].studentId);
                            pref.setString(
                                'civilid', l.data.details[0].studentCivilId);

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NavBar(),
                              ),
                            );
                          } else {
                            key.currentState.showSnackBar(
                              SnackBar(
                                backgroundColor: Color(0xff026a37),
                                content: Text(
                                  out.data.registeration ?? '',
                                ),
                              ),
                            );
                          }
                        } else
                          key.currentState.showSnackBar(
                            SnackBar(
                              backgroundColor: Color(0xff026a37),
                              content: Text(
                                'Password and confirm password are not same',
                              ),
                            ),
                          );
                      } else {
                        key.currentState.showSnackBar(
                          SnackBar(
                            backgroundColor: Color(0xff026a37),
                            content: Text(
                              'Fill all Feilds and check for terms and condition',
                            ),
                          ),
                        );
                      }
                    },
                    child: Text(
                      'SIGNUP',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
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
