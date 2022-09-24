import 'package:flutter/material.dart';
import 'package:massnew/Api/api.dart';
import 'package:massnew/Models/BannerModel.dart';

import '../homeScreen.dart';
import 'CompanyAppointment.dart';

class CompanyHomePage extends StatefulWidget {
  CompanyHomePage({Key key}) : super(key: key);

  @override
  _CompanyHomePageState createState() => _CompanyHomePageState();
}

class _CompanyHomePageState extends State<CompanyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              FutureBuilder<HomeBannerModel>(
                future: bannerApi(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        height: 210,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/homeimage.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Landing(
                          slides: snapshot.data.data.sliderApi,
                        ),
                      ),
                    );
                  } else
                    return Container(
                      height: 190,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                },
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 40,
                width: 200,
                decoration: BoxDecoration(
                  color: Color(0xff026a37),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.push(
                        (context),
                        MaterialPageRoute(
                          builder: (context) => AppointmentPage(),
                        ));
                  },
                  child: Text(
                    'Appointment',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              // Container(
              //   margin: EdgeInsets.symmetric(horizontal: 20),
              //   child: ListView.builder(
              //     itemCount: 3,
              //     shrinkWrap: true,
              //     physics: BouncingScrollPhysics(),
              //     itemBuilder: (BuildContext context, int index) {
              //       return Row(
              //         children: [
              //           Expanded(
              //             flex: 2,
              //             child: Container(
              //               padding: EdgeInsets.symmetric(vertical: 10),
              //               child: CircleAvatar(
              //                 radius: 25,
              //                 backgroundColor: Colors.amber,
              //                 // backgroundImage: AssetImage(
              //                 //   'assets/images/pro.jpg',
              //                 // ),
              //               ),
              //             ),
              //           ),
              //           Expanded(
              //             flex: 7,
              //             child: Container(
              //               child: Column(
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 children: [
              //                   Text(
              //                     'Authorised Gas Tester (AGT)',
              //                     style: TextStyle(
              //                       fontSize: 13,
              //                       color: Colors.grey,
              //                     ),
              //                   ),
              //                   SizedBox(
              //                     height: 10,
              //                   ),
              //                   Row(
              //                     mainAxisAlignment:
              //                         MainAxisAlignment.spaceBetween,
              //                     children: [
              //                       Text(
              //                         'successfull',
              //                         style: TextStyle(
              //                           color: Colors.lightGreenAccent,
              //                         ),
              //                       ),
              //                       Container(
              //                         height: 25,
              //                         decoration: BoxDecoration(
              //                           color: Color(0xff026a37),
              //                           borderRadius: BorderRadius.circular(5),
              //                         ),
              //                         child: MaterialButton(
              //                           onPressed: () {},
              //                           child: Text(
              //                             'View Certificate',
              //                             style: TextStyle(
              //                               fontSize: 13,
              //                               color: Colors.white,
              //                             ),
              //                           ),
              //                         ),
              //                       ),
              //                     ],
              //                   ),
              //                 ],
              //               ),
              //             ),
              //           ),
              //         ],
              //       );
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
