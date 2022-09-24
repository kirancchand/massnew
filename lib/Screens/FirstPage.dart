import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:massnew/Screens/loginPage.dart';

import 'CompanyLogin/CompanyLogin.dart';
import 'MarketingStaffLogin/MarketingLogin.dart';
import 'package:url_launcher/url_launcher.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

@override
class _FirstPageState extends State<FirstPage> {
  @override
  double currentIndexPage = 0;
  // Future<void> initState() async {
  //   var pref = await SharedPreferences.getInstance();
  //   var sid = pref.getString('sid');
  //   if (sid != null) {
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => NavBar(),
  //       ),
  //     );
  //   } else {
  //     Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => FirstPage(),
  //         ));
  //   }
  // TODO: implement initState
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color(0xff90eba6),
                  Color(0xff25a4b3),
                ]),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 30,
          ),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 4,
              ),
              Container(
                height: 100,
                child: Image.asset(
                  'assets/images/massco.png',
                  fit: BoxFit.fill,
                ),
                width: double.infinity,
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                height: 45,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xff016936),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ));
                  },
                  child: Text(
                    'Student Login',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
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
                  color: Color(0xff016936),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CompanyLoginPage(),
                        ));
                  },
                  child: Text(
                    'Company Login',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              // Container(
              //   height: 45,
              //   width: double.infinity,
              //   decoration: BoxDecoration(
              //     color: Color(0xffceced0),
              //     borderRadius: BorderRadius.circular(25),
              //   ),
              //   child: MaterialButton(
              //     onPressed: () {
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) => MarketingLoginPage(),
              //         ),
              //       );
              //     },
              //     child: Text(
              //       'Marketing Login',
              //       style: TextStyle(
              //         fontSize: 16,
              //         fontWeight: FontWeight.w600,
              //         color: Colors.white,
              //       ),
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(color: Color(0xff83d3c5)),
                    height: 8,
                    width: 8,
                    transform: Matrix4.rotationZ(.8),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(color: Color(0xfffefefe)),
                    height: 8,
                    width: 8,
                    transform: Matrix4.rotationZ(.75),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(color: Color(0xff83d3c5)),
                    height: 8,
                    width: 8,
                    transform: Matrix4.rotationZ(.75),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

}
