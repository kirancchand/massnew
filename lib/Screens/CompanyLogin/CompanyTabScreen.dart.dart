import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:massnew/Screens/CompanyLogin/CompanyHomePage.dart';
import 'CompanyCertificateScreen.dart';
import 'CompanyProfileScreen.dart';

class CompanyNavigationBar extends StatefulWidget {
  CompanyNavigationBar({this.count});
  int count;
  @override
  _CompanyNavigationBarState createState() => _CompanyNavigationBarState();
}

class _CompanyNavigationBarState extends State<CompanyNavigationBar> {
  int selectedIndex = 0;
  GlobalKey<ScaffoldState> key = GlobalKey();
  List pages = [
    CompanyHomePage(),
    CompanyCertificateScreen(),
    CompanyProfileScreen(),
  ];
  void initState() {
    if (widget.count != null) {
      selectedIndex = widget.count;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Text(''),
        title: Image.asset(
          'assets/images/massco.png',
        ),
        actions: [
          Icon(
            Icons.search,
            color: Colors.white,
            size: 28,
          ),
          SizedBox(
            width: 30,
          ),
          Icon(
            FontAwesomeIcons.bell,
            color: Colors.white,
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        backgroundColor: Colors.white,
        unselectedLabelStyle: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 16, color: Colors.grey),
        selectedLabelStyle: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 16, color: Colors.grey),
        selectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/home.png',
              height: 35,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/certificate.png',
              height: 35,
            ),
            label: 'Certificate',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/profile.png',
              height: 35,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
