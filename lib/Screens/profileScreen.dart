import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:massnew/Api/api.dart';
import 'package:massnew/Models/MyCourseViewModel.dart';
import 'package:massnew/Models/StudentCertificate.dart';
import 'package:massnew/Models/profileModel.dart';
import 'package:massnew/Screens/EditProfile.dart';
import 'package:massnew/Screens/Pdf.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen();

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<ProfileClass>(
        future: profileApi(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Data1 data = snapshot.data.data;
            print(snapshot.data.data.studentProfileView.picture);
            return Container(
              child: Column(
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
                        Container(
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(
                              'https://www.masshseconsultant.com/admin/uploads/' +
                                      snapshot.data.data.studentProfileView
                                          .picture ??
                                  '',
                            ),
                          ),
                        ),
                        Text(
                          data.studentProfileView.firstName +
                              data.studentProfileView.lastName,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          data.studentProfileView.studentCivilId,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    EditProfilePage(data: snapshot.data),
                              ),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  'Edit profile',
                                  style: TextStyle(
                                    color: Colors.greenAccent,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Student Id Cards',
                      style: TextStyle(
                          color: Color(0xff026a37),
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Divider(),
                  Expanded(
                    child: FutureBuilder<StudentCertificate>(
                      future: studentCertificates(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return (snapshot.data.data.studentIdcardView.length ==
                                  0)
                              ? Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Text('No Certificates avaialable'),
                                )
                              : ListView.builder(
                                  itemCount: snapshot
                                          .data.data.studentIdcardView.length ??
                                      0,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    StudentIdcardView id = snapshot
                                        .data.data.studentIdcardView[index];
                                    return Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 10),
                                      decoration: BoxDecoration(
                                        color: Colors.teal[50],
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      margin: EdgeInsets.symmetric(
                                          vertical: 6, horizontal: 12),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                      id.stIdCertName ?? '')),
                                              Text(
                                                  id.cIdInsDate.day.toString() +
                                                      " - " +
                                                      id.cIdInsDate.month
                                                          .toString() +
                                                      " - " +
                                                      id.cIdInsDate.year
                                                          .toString()),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                height: 30,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 15),
                                                decoration: BoxDecoration(
                                                  color: Color(0xff026a37),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: MaterialButton(
                                                  onPressed: () {
                                                    (id.certIdFile.isNotEmpty)
                                                        ? Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      PDFScreen(
                                                                link:
                                                                    id.certIdFile ??
                                                                        '',
                                                              ),
                                                            ),
                                                          )
                                                        : Fluttertoast
                                                            .showToast(
                                                            msg:
                                                                "pdf not exist",
                                                          );
                                                  },
                                                  child: Text(
                                                    'View IdCard',
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                        } else
                          return Container(
                            child: Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Color(0xff026a37),
                                ),
                              ),
                            ),
                          );
                      },
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xff026a37)),
              ),
            );
          }
        },
      ),
    );
  }
}
