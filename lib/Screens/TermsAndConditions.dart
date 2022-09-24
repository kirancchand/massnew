import 'package:flutter/material.dart';

class TermsAndConditions extends StatefulWidget {
  TermsAndConditions({Key key}) : super(key: key);

  @override
  _TermsAndConditionsState createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
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
      body: SingleChildScrollView(
        child: Container(
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
                  'Terms And Conditions',
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
                  'We have given you the information about company, courses we offer, branded images, links to other websites for your reference. If you continue to browse and use this website you are agreeing to comply with and be bound by the following terms and conditions of use, which together with our privacy policy govern MASSCO HSE Consultant relationship with you in relation to this website.\n\nIntellectual Properties rights:\nAll logos, brands, labels, names, numerals, shapes or any combinations thereof, appearing in this site, except as otherwise noted, are properties either owned, or used under license, by MASSCO HSE Consultant limited and/or its associates entity who feature on this website.\n\nLinks to / from other Web Sites:\nThis Web site contains links to other Web Sites. These links are provided solely as a convenience to you. Wherever such link/s lead to sites which do not belong to MASSCO HSE Consultant and / or its associate entities, we are not responsible for the content of linked sites and do not make any representations regarding the correctness or accuracy of the content on such Web Sites. If you decide to access such linked Web Sites, you do so at your own risk.\n\nThe content of the pages of this website is for your general information and use only. It is subject to change without notice.\n\nUnauthorised use of this website may give rise to a claim for damages and/or be a criminal offence.',
                  style: TextStyle(
                    fontSize: 17,
                    fontStyle: FontStyle.italic,
                  ),
                ),
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
