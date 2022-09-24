import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:massnew/Api/api.dart';
import 'package:massnew/Models/pdfAndVideoModel.dart';
import 'package:massnew/Screens/Pdf.dart';

class StudyMaterialPdf extends StatefulWidget {
  StudyMaterialPdf({this.cid, this.desc});
  String cid;
  String desc;
  @override
  _StudyMaterialPdfState createState() => _StudyMaterialPdfState();
}

class _StudyMaterialPdfState extends State<StudyMaterialPdf> {
  @override
  Widget build(BuildContext context) {
    print(widget.cid);
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
        // actions: [
        //   SizedBox(
        //     width: 40,
        //   ),
        //   // SizedBox(width: 40, child: Image.asset("assets/images/search.png")),
        // SizedBox(
        //   width: 5,
        // ),
        // SizedBox(
        //     width: 40, child: Image.asset("assets/images/notification.png")),
        // SizedBox(
        //   width: 10,
        // ),
        // ],
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder<PdfAndVideoClass>(
        future: pdfAndVideoApi(cid: widget.cid ?? ''),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          (snapshot.data.data.viewPdfAndVideos.moduleFile
                                  .isNotEmpty)
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PDFScreen(
                                      link: snapshot.data.data.viewPdfAndVideos
                                              .moduleFile ??
                                          '',
                                    ),
                                  ))
                              : Fluttertoast.showToast(msg: "No pdf available");
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            height: 300,
                            width: 250,
                            child: Image.asset(
                              "assets/images/pdf.png",
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Description',
                              style: TextStyle(
                                  color: Color(0xff6c70e9),
                                  fontWeight: FontWeight.bold))),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        widget.desc ?? '',
                        style: TextStyle(color: Colors.grey, height: 1.7),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      // Align(
                      //   alignment: Alignment.centerLeft,
                      //   child: Text(
                      //     'Next study material',
                      //     style: TextStyle(
                      //       fontSize: 20,
                      //       color: Color(0xff6c70e9),
                      //       fontWeight: FontWeight.bold,
                      //     ),
                      //   ),
                      // ),
                      // Divider(
                      //   thickness: 2,
                      //   color: Color(0xff6c70e9),
                      // ),
                      // Container(
                      //   margin: EdgeInsets.only(top: 5),
                      //   child: SingleChildScrollView(
                      //     child: Wrap(
                      //       children: snapshot.data.data.relatedPdfAndVideos
                      //           .map((e) => PdfWidget(data: e))
                      //           .toList(),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            );
          } else
            return Container();
        },
      ),
    );
  }
}

class PdfWidget extends StatelessWidget {
  PdfWidget({
    this.data,
  });
  ViewPdfAndVideos data;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        (data.moduleFile.isEmpty)
            ? Fluttertoast.showToast(msg: "No pdf exist")
            : Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PDFScreen(
                    link: data.moduleFile ?? '',
                  ),
                ),
              );
      },
      child: Container(
        height: 260,
        width: (MediaQuery.of(context).size.width / 2) - 20,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: AssetImage('assets/images/pdf.png'),
                    fit: BoxFit.cover),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Text(data.moduleName ?? '')),
          ],
        ),
      ),
    );
  }
}
