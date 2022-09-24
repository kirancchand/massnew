import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'ClientListScreen.dart';
import 'MarketingHomePage.dart';
import 'MarketingProfilePage.dart';

class MarketingNavigationBar extends StatefulWidget {
  MarketingNavigationBar({this.count});
  int count;
  @override
  _MarketingNavigationBarState createState() => _MarketingNavigationBarState();
}

class _MarketingNavigationBarState extends State<MarketingNavigationBar> {
  int selectedIndex = 0;
  GlobalKey<ScaffoldState> key = GlobalKey();
  List pages = [
    MarketingHomePage(),
    ClientListScreen(),
    MarketingProfileScreen(),
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
            label: 'Client list',
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
