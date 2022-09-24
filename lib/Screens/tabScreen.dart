import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:massnew/Screens/AboutUs.dart';
import 'package:massnew/Screens/TermsAndConditions.dart';
import 'package:massnew/Screens/profileScreen.dart';
import 'package:massnew/Screens/reseachPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'CartPage.dart';
import 'FirstPage.dart';
import 'ProjectDrawer.dart';
import 'certificateScreen.dart';
import 'courseScreen.dart';
import 'homeScreen.dart';

class NavBar extends StatefulWidget {
  NavBar({this.count});
  int count;
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int selectedIndex = 0;
  GlobalKey<ScaffoldState> key = GlobalKey();
  List pages = [
    HomeScreen(),
    CourseScreen(),
    CertificateScreen(),
    ProfileScreen(),
  ];
  @override
  void initState() {
    if (widget.count != null) {
      selectedIndex = widget.count;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      drawer: Drawer(
        child: Container(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              SafeArea(
                  child: Container(
                      decoration:
                          BoxDecoration(color: Colors.white, boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 2.0,
                        ),
                      ]),
                      height: 40)),
              ListTile(
                title: Text(
                  'HOME',
                  style: TextStyle(
                    color: Colors.green[900],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: CircleAvatar(
                  child: Icon(Icons.home, color: Colors.white70),
                  backgroundColor: Colors.blue[900],
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NavBar(),
                      ));
                },
              ),
              ListTile(
                title: Text(
                  'Course',
                  style: TextStyle(
                      color: Colors.green[900], fontWeight: FontWeight.bold),
                ),
                leading: CircleAvatar(
                  child: Icon(
                    Icons.border_all,
                    color: Colors.white70,
                  ),
                  backgroundColor: Color(0xFF30AD23),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NavBar(
                        count: 1,
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                title: Text(
                  'Certificate',
                  style: TextStyle(
                      color: Colors.green[900], fontWeight: FontWeight.bold),
                ),
                leading: CircleAvatar(
                  child: Icon(
                    Icons.view_array,
                    color: Colors.white70,
                  ),
                  backgroundColor: Colors.green[900],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NavBar(
                        count: 2,
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                title: Text('Project',
                    style: TextStyle(
                        color: Colors.green[900], fontWeight: FontWeight.bold)),
                leading: CircleAvatar(
                  child: Icon(
                    Icons.view_carousel,
                    color: Colors.white70,
                  ),
                  backgroundColor: Color(0xFFEF9B0F),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProjectDrawer(),
                    ),
                  );
                },
              ),
              // ListTile(
              //   title: Text(
              //     'Exam',
              //     style: TextStyle(
              //         color: Colors.green[900], fontWeight: FontWeight.bold),
              //   ),
              //   leading: CircleAvatar(
              //     child: Icon(
              //       Icons.tablet,
              //       color: Colors.white70,
              //     ),
              //     backgroundColor: Colors.purple,
              //   ),
              //   onTap: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => EXAMVIEW(),
              //       ),
              //     );
              //   },
              // ),

              ListTile(
                title: Text(
                  'Research',
                  style: TextStyle(
                      color: Colors.green[900], fontWeight: FontWeight.bold),
                ),
                leading: CircleAvatar(
                  child: Icon(
                    Icons.preview_outlined,
                    color: Colors.white70,
                  ),
                  backgroundColor: Color(0xFF67AD90),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResearchPage(),
                    ),
                  );
                },
              ),
              Divider(
                height: 5.0,
                color: Colors.grey,
              ),
              SizedBox(
                height: 30,
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TermsAndConditions(),
                      ));
                },
                title: Text(
                  'Terms And Conditions',
                  style: TextStyle(color: Colors.green[900], fontSize: 15),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AboutUs(),
                      ));
                },
                title: Text(
                  'About Us',
                  style: TextStyle(color: Colors.green[900], fontSize: 15),
                ),
              ),
              ListTile(
                title: Text(
                  'Logout',
                  style: TextStyle(
                      color: Colors.green[900], fontWeight: FontWeight.bold),
                ),
                leading: CircleAvatar(
                  child: Icon(
                    Icons.lightbulb_outline,
                    color: Colors.purple,
                  ),
                  backgroundColor: Colors.purple[100],
                ),
                onTap: () async {
                  var pref = await SharedPreferences.getInstance();
                  pref.clear();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FirstPage(),
                      ),
                      (route) => false);
                },
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        elevation: 0.0,
        leading: InkWell(
          onTap: () {
            key.currentState.openDrawer();
          },
          child: Icon(
            Icons.menu,
            color: Colors.black,
          ),
        ),
        title: Image.asset("assets/images/massco.png"),
        centerTitle: true,
        actions: [
          SizedBox(
            width: 40,
          ),
          // SizedBox(width: 40, child: Image.asset("assets/images/search.png")),
          SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartPage(),
                  ));
            },
            child: Icon(
              FontAwesomeIcons.cartPlus,
              color: Colors.black,
              size: 22,
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        backgroundColor: Colors.white,
        selectedLabelStyle: TextStyle(
          fontSize: 12,
          color: Colors.grey,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 12,
          color: Colors.grey,
        ),
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/home.png',
              height: 30,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/corse.png',
              height: 30,
            ),
            label: 'Course',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/certificate.png',
              height: 30,
            ),
            label: 'Certificate',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/profile.png',
              height: 30,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
