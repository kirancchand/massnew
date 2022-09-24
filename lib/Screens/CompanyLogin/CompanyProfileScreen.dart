import 'package:flutter/material.dart';
import 'package:massnew/Api/api.dart';
import 'package:massnew/Models/companyProfileModek.dart';
import 'package:massnew/Screens/FirstPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CompanyProfileScreen extends StatefulWidget {
  CompanyProfileScreen({Key key}) : super(key: key);

  @override
  _CompanyProfileScreenState createState() => _CompanyProfileScreenState();
}

class _CompanyProfileScreenState extends State<CompanyProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<CompanyProfileClass>(
        future: companyProfileApi(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data.data.companyProfileView[0].companyInfoName);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(color: Color(0xff026a37)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      // Container(
                      //   child: CircleAvatar(
                      //     radius: 40,
                      //     backgroundImage: AssetImage(
                      //       'assets/images/pro.jpg',
                      //     ),
                      //   ),
                      // ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          snapshot.data.data.companyProfileView[0]
                                  .companyInfoName ??
                              '',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Text(
                        snapshot.data.data.companyProfileView[0]
                                .companyInfoRegno ??
                            '',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Mail Id  :  ",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            snapshot.data.data.companyProfileView[0]
                                    .companyInfoMail ??
                                '',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Phno  :  ",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            snapshot.data.data.companyProfileView[0]
                                    .companyInfoPhon ??
                                '',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.end,
                      //   children: [
                      //     Container(
                      //       margin: EdgeInsets.symmetric(horizontal: 10),
                      //       child: Text(
                      //         'Edit profile',
                      //         style: TextStyle(
                      //           color: Colors.greenAccent,
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Center(
                  child: Container(
                    height: 40,
                    width: 200,
                    decoration: BoxDecoration(
                      color: Color(0xff026a37),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: MaterialButton(
                      onPressed: () async {
                        var pref = await SharedPreferences.getInstance();
                        pref.clear();
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FirstPage(),
                            ),
                            (route) => false);
                      },
                      child: Text(
                        'Log Out',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                // Container(
                //   margin: EdgeInsets.symmetric(horizontal: 20),
                //   child: Text(
                //     'Certificates',
                //     style: TextStyle(
                //         color: Color(0xff026a37),
                //         fontSize: 18,
                //         fontWeight: FontWeight.bold),
                //   ),
                // ),
                // SizedBox(
                //   height: 20,
                // ),
                // Container(
                //   margin: EdgeInsets.symmetric(horizontal: 20),
                //   child: ListView.builder(
                //     itemCount: 3,
                //     shrinkWrap: true,
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
                //                           borderRadius:
                //                               BorderRadius.circular(5),
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
            );
          } else
            return Container();
        },
      ),
    );
  }
}
