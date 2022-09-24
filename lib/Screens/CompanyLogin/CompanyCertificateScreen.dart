import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:massnew/Api/api.dart';
import 'package:massnew/Models/CompanyCertificateModel.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../Pdf.dart';

class CompanyCertificateScreen extends StatefulWidget {
  CompanyCertificateScreen({Key key}) : super(key: key);

  @override
  _CompanyCertificateScreenState createState() =>
      _CompanyCertificateScreenState();
}

class _CompanyCertificateScreenState extends State<CompanyCertificateScreen> {
  bool spin = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<CompanyCertificateClass>(
        future: companyCertificateApi(),
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
                      (snapshot.data.data.companyCertificationView.length == 0)
                          ? Container(
                              child: Text('No Certificates avaialable'),
                            )
                          : Container(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height - 210,
                              child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                itemCount: snapshot
                                    .data.data.companyCertificationView.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: () {
                                      (snapshot
                                              .data
                                              .data
                                              .companyCertificationView[index]
                                              .companyCertificate
                                              .isNotEmpty)
                                          ? Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => PDFScreen(
                                                  link: snapshot
                                                          .data
                                                          .data
                                                          .companyCertificationView[
                                                              index]
                                                          .companyCertificate ??
                                                      '',
                                                ),
                                              ),
                                            )
                                          : Fluttertoast.showToast(
                                              msg: "pdf not exist",
                                            );
                                    },
                                    child: Container(
                                      // height: 140,
                                      width: double.infinity,
                                      margin: EdgeInsets.symmetric(vertical: 3),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 15),
                                      decoration: BoxDecoration(
                                        color: Colors.greenAccent,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Column(
                                        children: [
                                          Text(
                                            snapshot
                                                    .data
                                                    .data
                                                    .companyCertificationView[
                                                        index]
                                                    .companyName ??
                                                '',
                                            style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            snapshot
                                                    .data
                                                    .data
                                                    .companyCertificationView[
                                                        index]
                                                    .companyRegno ??
                                                "",
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            snapshot
                                                    .data
                                                    .data
                                                    .companyCertificationView[
                                                        index]
                                                    .companyProject ??
                                                '',
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                            "Location",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 15),
                                              child: Divider(
                                                color: Colors.white,
                                                thickness: 1,
                                              )),
                                          Text(
                                            snapshot
                                                    .data
                                                    .data
                                                    .companyCertificationView[
                                                        index]
                                                    .companyLocation ??
                                                '',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 16,
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
