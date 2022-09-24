import 'package:flutter/material.dart';
import 'package:massnew/Api/api.dart';
import 'package:massnew/Models/MarketingLogin.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:massnew/Screens/ForgetPassword.dart';
import 'MarketingTabScreen.dart';
import 'package:url_launcher/url_launcher.dart';

class MarketingLoginPage extends StatefulWidget {
  MarketingLoginPage({Key key}) : super(key: key);

  @override
  _MarketingLoginPageState createState() => _MarketingLoginPageState();
}

class _MarketingLoginPageState extends State<MarketingLoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  GlobalKey<ScaffoldState> key = GlobalKey();
  bool spin = false;
  bool check = false;
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
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(

                          value: check,
                          onChanged: (value) => showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Disclaimer Policy'),
                              content: !check?const Text('MASSCO HSE collects location data to enable Client Registration even when the app is closed or not in use'):
                                           const Text('Are You Sure!! You cant login while you dont accept our policy'),
                                // Are You agree to capture your location data for our managerial purpose
                                //
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'Cancel'),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () => {
                                      setState(() {
                                        check = value;
                                      }),
                                    Navigator.pop(context, 'OK')
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          ),

                          // onChanged: (value) {
                          //   setState(() {
                          //     check = value;
                          //   });
                          // }

                          ),
                      GestureDetector(
                        child: new RichText(
                          text: new TextSpan(
                            children: [
                            new TextSpan(
                              text: 'I accept the ',
                              style: new TextStyle(color: Colors.black),
                            ),
                            new TextSpan(
                              text: 'terms & conditions',
                              style: new TextStyle(color: Colors.blue),
                            ),
                          ],),
                        ),
                        onTap: () async {
                          const url = 'https://www.masshseconsultant.com/privacy_policy.php';
                          if (await canLaunch(url)) launch(url);
                        },
                      )

                    ],
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
                        if (email.text.isNotEmpty && pass.text.isNotEmpty && check) {
                          setState(() {
                            spin = true;
                          });
                          MarketingLoginModel l = await marketingLoginApi(
                              uname: email.text, pass: pass.text);
                          if (l != null) {
                            var pref = await SharedPreferences.getInstance();
                            pref.setString(
                              'm_email',
                              l.data.marketingLogin.username ?? '',
                            );
                            pref.setString(
                              'tid',
                              l.data.marketingLogin.id ?? '',
                            );
                            setState(() {
                              spin = false;
                            });
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      MarketingNavigationBar(),
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

                          if(!check){
                            key.currentState.showSnackBar(
                              SnackBar(
                                backgroundColor: Color(0xff06673a),
                                content: Text(
                                  'You Must Agree terms and conditions',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                          }else{
                            key.currentState.showSnackBar(SnackBar(
                              content: Text(
                                'Fill all fields',
                                textAlign: TextAlign.center,
                              ),
                              backgroundColor: Color(0xff06673a),
                            ));
                          }

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
          ],
        ),
      ),
    );
  }
}
