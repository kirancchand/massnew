import 'package:flutter/material.dart';
import 'package:massnew/Api/api.dart';
import 'package:massnew/Models/ClientListModel.dart';




class ClientListScreen extends StatefulWidget {
  ClientListScreen({Key key}) : super(key: key);

  @override
  _ClientListScreenState createState() => _ClientListScreenState();
}

class _ClientListScreenState extends State<ClientListScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, 
      body: FutureBuilder<ClientListModel>(
        future: clientListApi(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 20, top: 20),
                      child: Text(
                        'ClientList',
                        style: TextStyle(
                          color: Color(0xff016936),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height - 210,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data.data.clientList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              // height:170,
                              width:double.infinity,
                              margin: EdgeInsets.symmetric(
                                  vertical: 3, horizontal: 20),
                              padding: EdgeInsets.only(top: 20, left: 15,bottom:6),
                              decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  colors: [
                                    Color(0xff90eba6),
                                    Colors.blueAccent,
                                    Color(0xff25a4b3),
                                  ]),
                              ),
                              child:Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.data.data.clientList[index]
                                            .clientName ??
                                        '',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'phone number       :  ',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                        ),
                                      ),
                                      Text(
                                        snapshot.data.data.clientList[index]
                                                .clientPhone ??
                                            "",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                              
                                   Row(
                                    children: [
                                      
                                      Text(
                                        'Email                       :  ',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                        ),
                                      ),

                                      Flexible(
                                        child: Text(
                                        snapshot.data.data.clientList[index]
                                                .clientMailid ??
                                            '',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                        ),
                                      ),
                                      ),
                                     
                                    ],
                                  ),
                                   SizedBox(
                                    height: 7,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Company                :  ',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                        ),
                                      ),
                                       Flexible(
                                         child: Text(
                                       snapshot.data.data.clientList[index]
                                                .clientCompany ??
                                            '',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                        ),
                                      ),
                                       )
                                     
                                    ],
                                  ),
                                ]
                              )
                            );
                          },
                        ),
                      // ListView.builder(
                      //     // shrinkWrap: true,
                      //     itemCount: snapshot.data.data.clientList.length,
                      //     itemBuilder: (BuildContext context, int index) {
                      //       return Flexible(
                      //         child:Container(
                      //         height: 150,
                      //         width: double.infinity,
                      //         margin: EdgeInsets.symmetric(
                      //             vertical: 3, horizontal: 20),
                      //         padding: EdgeInsets.only(top: 20, left: 15),
                      //         // decoration: BoxDecoration(
                      //         //   color: Colors.blue,
                      //         // borderRadius: BorderRadius.circular(20),
                      //         // ),
                      //         decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(20),
                      //           gradient: LinearGradient(
                      //               begin: Alignment.topRight,
                      //               end: Alignment.bottomLeft,
                      //               colors: [
                      //                 Color(0xff90eba6),
                      //                 Colors.blueAccent,
                      //                 Color(0xff25a4b3),
                      //               ]),
                      //         ),
                      //         child: Column(
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             Text(
                      //               snapshot.data.data.clientList[index]
                      //                       .clientName ??
                      //                   '',
                      //               style: TextStyle(
                      //                 color: Colors.white,
                      //                 fontWeight: FontWeight.bold,
                      //                 fontSize: 17,
                      //               ),
                      //             ),
                      //             SizedBox(
                      //               height: 10,
                      //             ),
                      //             Row(
                      //               children: [
                      //                 Text(
                      //                   'phone number       :  ',
                      //                   style: TextStyle(
                      //                     color: Colors.white,
                      //                     fontWeight: FontWeight.w500,
                      //                     fontSize: 15,
                      //                   ),
                      //                 ),
                      //                 Text(
                      //                   snapshot.data.data.clientList[index]
                      //                           .clientPhone ??
                      //                       "",
                      //                   style: TextStyle(
                      //                     color: Colors.white,
                      //                     fontWeight: FontWeight.w500,
                      //                     fontSize: 15,
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //             SizedBox(
                      //               height: 7,
                      //             ),
                      //             Row(
                      //               children: [
                                      
                      //                 Text(
                      //                   'Email                       :  ',
                      //                   style: TextStyle(
                      //                     color: Colors.white,
                      //                     fontWeight: FontWeight.w500,
                      //                     fontSize: 15,
                      //                   ),
                      //                 ),
                      //                 Flexible(
                      //                   child: Text(
                      //                   snapshot.data.data.clientList[index]
                      //                           .clientMailid ??
                      //                       '',
                      //                   style: TextStyle(
                      //                     color: Colors.white,
                      //                     fontWeight: FontWeight.w500,
                      //                     fontSize: 15,
                      //                   ),
                      //                 ),
                      //                 ),
                                     
                      //               ],
                      //             ),
                      //             SizedBox(
                      //               height: 7,
                      //             ),
                      //             Row(
                      //               children: [
                      //                 Text(
                      //                   'Company                :  ',
                      //                   style: TextStyle(
                      //                     color: Colors.white,
                      //                     fontWeight: FontWeight.w500,
                      //                     fontSize: 15,
                      //                   ),
                      //                 ),
                      //                 Text(
                      //                   'cname',
                      //                   style: TextStyle(
                      //                     color: Colors.white,
                      //                     fontWeight: FontWeight.w500,
                      //                     fontSize: 15,
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //           ],
                      //         ),
                      //        ),
                      //       );

                      //     }),
                    )
                  ],
                ),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }






}
