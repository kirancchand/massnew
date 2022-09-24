import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:massnew/Api/api.dart';
import 'package:massnew/Models/StudentCertificate.dart';
import 'package:massnew/Screens/Pdf.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class CertificateScreen extends StatefulWidget {
  @override
  _CertificateScreenState createState() => _CertificateScreenState();
}

class _CertificateScreenState extends State<CertificateScreen> {
  GlobalKey<ScaffoldState> key = GlobalKey();
  bool spin = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      body: FutureBuilder<StudentCertificate>(
        future: studentCertificates(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ModalProgressHUD(
              inAsyncCall: spin,
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Certificates',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 19,
                          color: Color(0xff026a37),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      (snapshot.data.data.studentCertificateView.length == 0)
                          ? Container(
                              child: Text('No Certificates avaialable'),
                            )
                          : Container(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height - 210,
                              child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                itemCount: snapshot
                                    .data.data.studentCertificateView.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: () {
                                      (snapshot
                                              .data
                                              .data
                                              .studentCertificateView[index]
                                              .certFile
                                              .isNotEmpty)
                                          ? Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => PDFScreen(
                                                  link: snapshot
                                                          .data
                                                          .data
                                                          .studentCertificateView[
                                                              index]
                                                          .certFile ??
                                                      '',
                                                ),
                                              ),
                                            )
                                          : Fluttertoast.showToast(
                                              msg: "pdf not exist",
                                            );
                                    },
                                    child: Container(
                                      height: 140,
                                      width: double.infinity,
                                      margin: EdgeInsets.symmetric(vertical: 3),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 15),
                                      decoration: BoxDecoration(
                                        color: Colors.greenAccent,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            snapshot
                                                    .data
                                                    .data
                                                    .studentCertificateView[
                                                        index]
                                                    .stRegno ??
                                                '',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            snapshot
                                                    .data
                                                    .data
                                                    .studentCertificateView[
                                                        index]
                                                    .stName ??
                                                "",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            snapshot
                                                    .data
                                                    .data
                                                    .studentCertificateView[
                                                        index]
                                                    .stCertName ??
                                                '',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            );
          } else
            return Container(
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xff026a37)),
                ),
              ),
            );
        },
      ),
    );
  }
}
