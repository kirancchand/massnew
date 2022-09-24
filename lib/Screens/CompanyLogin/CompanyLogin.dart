import 'package:flutter/material.dart';
import 'package:massnew/Api/api.dart';
import 'package:massnew/Models/companyLoginModel.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'CompanyTabScreen.dart.dart';
import 'package:massnew/Screens/ForgetPassword.dart';

class CompanyLoginPage extends StatefulWidget {
  CompanyLoginPage({Key key}) : super(key: key);

  @override
  _CompanyLoginPageState createState() => _CompanyLoginPageState();
}

class _CompanyLoginPageState extends State<CompanyLoginPage> {
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
        leading: GestureDetector(
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
                        hintText: 'Email',
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
                  // SizedBox(
                  //   height: 20,
                  // ),
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
                          CompanyLoginModel c = await companyLoginApi(
                            uname: email.text,
                            pass: pass.text,
                          );
                          if (c != null) {
                            var pref = await SharedPreferences.getInstance();
                            pref.setString(
                                'c_regno', c.data.companyLogin.userreg ?? '');
                            setState(() {
                              spin = false;
                            });
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CompanyNavigationBar(),
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
                                  'check your username and password',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                          }
                        } else {
                          key.currentState.showSnackBar(
                            SnackBar(
                              backgroundColor: Color(0xff06673a),
                              content: Text('fill all feilds'),
                            ),
                          );
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
           
            // InkWell(
            //   onTap: () {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => RegistrationPage(),
            //         ));
            //   },
            //   child: Container(
            //     height: 45,
            //     decoration: BoxDecoration(color: Color(0xff06673a)),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         Text('Do not have a student account ? ',
            //             style: TextStyle(
            //               color: Colors.white,
            //             )),
            //         Text(
            //           'Create Account',
            //           style: TextStyle(
            //             fontWeight: FontWeight.bold,
            //             color: Colors.white,
            //           ),
            //         )
            //       ],
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
