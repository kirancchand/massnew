import 'package:flutter/material.dart';
import 'package:massnew/Models/loginModel.dart';
import 'package:massnew/Screens/registrationPage.dart';
import 'package:massnew/Screens/tabScreen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Api/api.dart';
import 'package:massnew/Screens/ForgetPassword.dart';

class LoginPage extends StatefulWidget {
  LoginPage();

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  GlobalKey<ScaffoldState> key = GlobalKey();
  bool spin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, 
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
                size: 19,
                color: Color(0xff026a37),
              ),
              Text(
                'Back',
                style: TextStyle(
                  color: Color(0xff026a37),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: spin,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 120,
                    width: double.infinity,
                    child: Image.asset(
                      'assets/images/massco.png',
                      fit: BoxFit.fitWidth,
                    ),
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
                    child: TextFormField(
                      controller: email,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        counterText: '',
                        suffixIcon: Icon(
                          Icons.message_outlined,
                          size: 20,
                          color: Color(0xff9961be),
                        ),
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                        hintText: 'Civil Id',
                        hintStyle: TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
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
                    child: TextFormField(
                      controller: pass,
                      keyboardType: TextInputType.name,
                      obscureText: true,
                      decoration: InputDecoration(
                        counterText: '',
                        suffixIcon: Icon(
                          Icons.lock_outline_sharp,
                          size: 20,
                          color: Color(0xff9961be),
                        ),
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                        hintText: 'Password',
                        hintStyle: TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // Text('Forgot Your Password?'),
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
                        if (email.text.isNotEmpty && pass.text.isNotEmpty) {
                          setState(() {
                            spin = true;
                          });
                          LoginClass l = await loginApi(
                              uname: email.text, pass: pass.text);
                          if (l != null) {
                            var pref = await SharedPreferences.getInstance();

                            pref.setString('sid', l.data.details[0].studentId);
                            pref.setString(
                                'civilid', l.data.details[0].studentCivilId);

                            setState(() {
                              spin = false;
                            });
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NavBar(),
                                ),
                                (route) => false);
                          } else {
                            setState(() {
                              spin = false;
                            });
                            key.currentState.showSnackBar(
                              SnackBar(
                                backgroundColor: Color(0xff06673a),
                                content: Text(
                                  'Please enter valid details',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                          }
                        } else {
                          key.currentState.showSnackBar(SnackBar(
                            content: Text(
                              'Fill all fields',
                              textAlign: TextAlign.center,
                            ),
                            backgroundColor: Color(0xff06673a),
                          ));
                        }
                      },
                      child: Text(
                        'LOGIN',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                    Container(
                    child: 
                    MaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ForgetPassword(),
                      ),
                    );
                  },
                  child: Text(
                        'Forget Password',
                        style: TextStyle(
                          color: Color(0xff026a37),
                        ),
                      ),
                     ),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegistrationPage(),
                    ));
              },
              child: Container(
                height: 45,
                decoration: BoxDecoration(color: Color(0xff06673a)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Do not have a student account ? ',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    Text(
                      'Create Account',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
