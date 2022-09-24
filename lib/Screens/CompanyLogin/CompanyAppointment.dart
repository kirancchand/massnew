import 'dart:io';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:massnew/Api/api.dart';
import 'package:massnew/Screens/CompanyLogin/CompanyTabScreen.dart.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class AppointmentPage extends StatefulWidget {
  AppointmentPage({Key key}) : super(key: key);

  @override
  _AppointmentPageState createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  TextEditingController fullname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController detail = TextEditingController();
  TextEditingController time = TextEditingController();

  GlobalKey<ScaffoldState> key = GlobalKey();
  String dropdownValue = 'Male';
  bool check = false;
  File i;
  String fileName = '';
  String _valueChanged1 = '';
  String _valueToValidate1 = '';
  String _valueSaved1 = '';
  bool spin = false;
  @override
  // void initState() {
  //   super.initState();
  //   date = TextEditingController(text: DateTime.now().toString());
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        leadingWidth: 75,
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
      body: ModalProgressHUD(
        inAsyncCall: spin,
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                SingleTextWidgets(
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
                SingleTextWidgets(
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
                SingleTextWidgets(
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
                Container(
                  height: 55,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
                    controller: date,
                    //initialValue: _initialValue,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    // icon: Icon(Icons.event),
                    // dateLabelText: 'Date of Appointment',
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Date of Appointment',
                    ),
                    // timeLabelText: "Hour",
                    selectableDayPredicate: (date) {
                      if (date.weekday == 6 || date.weekday == 7) {
                        return false;
                      }
                      return true;
                    },
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
                Container(
                  height: 55,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  child: DateTimePicker(
                    type: DateTimePickerType.time,
                    dateMask: 'd MMM, yyyy',
                    controller: time,
                    //initialValue: _initialValue,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    // dateLabelText: 'Date',
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Time',
                    ),
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
                Container(
                  height: 85,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  child: TextFormField(
                    controller: detail,
                    maxLines: 7,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      counterText: '',
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      hintText: 'Details',
                      hintStyle: TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 30,
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
                      // print(date.text);
                      // print(time.text);
                      // if()
                      setState(() {
                        spin = true;
                      });
                      String s = await companyAppointment(
                        name: fullname.text,
                        email: email.text,
                        phno: phone.text,
                        detail: detail.text,
                        date: date.text,
                        time: time.text,
                      );
                      setState(() {
                        spin = false;
                      });
                      key.currentState.showSnackBar(
                        SnackBar(
                          content: Text(s),
                        ),
                      );
                      await Future.delayed(
                        Duration(seconds: 3),
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CompanyNavigationBar(),
                        ),
                      );
                    },
                    child: Text(
                      'Appointment',
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

class SingleTextWidgets extends StatelessWidget {
  SingleTextWidgets({this.name, this.controller, this.icon, this.type});
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
