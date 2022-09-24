import 'package:flutter/material.dart';

class AboutUs extends StatefulWidget {
  AboutUs({Key key}) : super(key: key);

  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: Image.asset(
          "assets/images/massco.png",
          height: 70,
          width: 180,
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xff90eba6),
                Color(0xff25a4b3),
              ]),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              child: Text(
                'About Us',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 50),
              height: 2,
              color: Colors.black,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Mass HSE CONSULTANT CO. Institute for Engineering Training is a Kuwaiti institute to provide consultancy and training founded in 2011 with 20 years of experience in a broad portfolio of projects. Mass Institute is one of the largest national institutes in the State of Kuwait, which is always provide the high quality of the training process dedicated to our clients. Because you are our customer, this is because you are distinguished. Mass Institute has been accredited by all government agencies in Kuwait and several ministries to provide the different engineering training, including training of occupational safety, health and environment in accordance with the technical standards in Kuwait which are in line with international standards',
                style: TextStyle(
                  fontSize: 17,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
