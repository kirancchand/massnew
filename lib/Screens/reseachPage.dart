import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:massnew/Api/api.dart';
import 'package:massnew/Models/MyCourseViewModel.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class ResearchPage extends StatefulWidget {
  @override
  _ResearchPageState createState() => _ResearchPageState();
}

class _ResearchPageState extends State<ResearchPage> {
  @override
  bool spin = false;
  FilePickerResult resultpdf;
  List _pdf = null;
  List<String> filename = [];
  Future getPdf() async {
    resultpdf = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: false,
      allowedExtensions: ['pdf', 'doc'],
    );
    return resultpdf.files;
  }

  GlobalKey<ScaffoldState> key = GlobalKey();
  Widget build(BuildContext context) {
    return SafeArea(
      child:Scaffold(
        resizeToAvoidBottomInset: false, 
        key: key,
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
          child:        FutureBuilder<MyCourseViewClass>(
            future: myCourseViewApi(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ModalProgressHUD(
                  inAsyncCall: spin,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Research Upload',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 25),
                        child: Divider(),
                      ),
                      SingleChildScrollView(
                        child: Container(
                          height: (MediaQuery.of(context).size.height - 160),
                          margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                          child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount:
                              snapshot.data.data.studentCourseView.length,
                              // shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(vertical: 10),
                                        child: CircleAvatar(
                                          radius: 25,
                                          // backgroundColor: Colors.red,
                                          backgroundImage: NetworkImage(
                                            'https://www.masshseconsultant.com/admin/uploads/' +
                                                snapshot
                                                    .data
                                                    .data
                                                    .studentCourseView[index]
                                                    .coursePic ??
                                                '',
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 7,
                                      child: Container(
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              snapshot
                                                  .data
                                                  .data
                                                  .studentCourseView[index]
                                                  .course ??
                                                  '',
                                              style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                              children: [
                                                Container(
                                                  height: 25,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xff026a37),
                                                    borderRadius:
                                                    BorderRadius.circular(5),
                                                  ),
                                                  child: MaterialButton(
                                                      onPressed: () async {
                                                        var d = await getPdf();
                                                        setState(() {
                                                          _pdf = d;
                                                        });

                                                        print(d);
                                                        if (_pdf != null) {
                                                          setState(() {
                                                            spin = true;
                                                          });
                                                          String message =
                                                          await uploadResearchFile(
                                                              file: _pdf,
                                                              pname: snapshot
                                                                  .data
                                                                  .data
                                                                  .studentCourseView[
                                                              index]
                                                                  .course,
                                                              pcourse: snapshot
                                                                  .data
                                                                  .data
                                                                  .studentCourseView[
                                                              index]
                                                                  .id);
                                                          print(message);
                                                          setState(() {
                                                            spin = false;
                                                          });
                                                          if (message == '100') {
                                                            key.currentState
                                                                .showSnackBar(
                                                              SnackBar(
                                                                backgroundColor:
                                                                Color(
                                                                    0xff026a37),
                                                                content: Text(
                                                                    'Successfully uploaded'),
                                                              ),
                                                            );
                                                            setState(() {
                                                              _pdf = null;
                                                            });
                                                          } else {
                                                            key.currentState
                                                                .showSnackBar(SnackBar(
                                                                backgroundColor:
                                                                Color(
                                                                    0xff026a37),
                                                                content: Text(
                                                                    'Unable to upload ')));
                                                          }
                                                        } else {
                                                          key.currentState
                                                              .showSnackBar(SnackBar(
                                                              backgroundColor:
                                                              Color(
                                                                  0xff026a37),
                                                              content: Text(
                                                                  'upload the file first')));
                                                        }
                                                      },
                                                      child: Text(
                                                        'UPLOAD',
                                                        style: TextStyle(
                                                          fontSize: 13,
                                                          color: Colors.white,
                                                        ),
                                                      )),
                                                ),
                                                // Container(
                                                //   height: 25,
                                                //   decoration: BoxDecoration(
                                                //     color: Color(0xff026a37),
                                                //     borderRadius:
                                                //         BorderRadius.circular(5),
                                                //   ),
                                                //   child: MaterialButton(
                                                //     onPressed: () async {

                                                //     },
                                                //     child: Text(
                                                //       'SUBMIT',
                                                //       style: TextStyle(
                                                //         fontSize: 13,
                                                //         color: Colors.white,
                                                //       ),
                                                //     ),
                                                //   ),
                                                // ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                        ),
                      ),
                    ],
                  ),
                );
              } else
                return Container();
            },
          ),
        )


      ),
    );

  }
}
