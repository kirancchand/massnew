import 'package:flutter/material.dart';
import 'package:massnew/Api/api.dart';
import 'package:massnew/Models/MarketingLogin.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'MarketingStaffLogin/MarketingLogin.dart';

class ForgetPassword extends StatefulWidget {
  ForgetPassword({Key key}) : super(key: key);

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController email = TextEditingController();
  GlobalKey<ScaffoldState> key = GlobalKey();
  bool spin = false;
  String resp;

  @override
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
                        if (email.text.isNotEmpty) {
                          setState(() {
                            spin = true;
                          });
                         var resp=await forgetPasswordApi(uname: email.text);
                         if(!resp['data']['success'])
                         {
                             setState(() {
                               spin = false;
                              });
                              key.currentState.showSnackBar(SnackBar(
                                content: Text(
                                  resp['data']['data'],
                                  textAlign: TextAlign.center,
                                ),
                                backgroundColor: Color(0xff06673a),
                              ));
                             Navigator.pop(context);
                         }
                         else{
                            setState(() {
                              spin = false;
                            });
                           key.currentState.showSnackBar(SnackBar(
                                content: Text(
                                  resp['data']['data'],
                                  textAlign: TextAlign.center,
                                ),
                                backgroundColor: Color(0xff06673a),
                              ));

                         }
                        } else {
                          key.currentState.showSnackBar(SnackBar(
                            content: Text(
                              'Enter Email id',
                              textAlign: TextAlign.center,
                            ),
                            backgroundColor: Color(0xff06673a),
                          ));
                        }
                      },
                      child: Text(
                        'Reset Password',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
