import 'package:flutter/material.dart';
import 'package:massnew/Api/api.dart';
import 'package:massnew/Models/MyCourseViewModel.dart';
import 'EXAMVIEW.dart';

class ExamPart extends StatefulWidget {
  ExamPart();

  @override
  _ExamPartState createState() => _ExamPartState();
}

class _ExamPartState extends State<ExamPart> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MyCourseViewClass>(
        future: myCourseViewApi(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height / 2,
                margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: snapshot.data.data.studentCourseView.length,
                    // shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: CircleAvatar(
                                radius: 27,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.data.data.studentCourseView[index]
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
                                        height: 28,
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 8),
                                        decoration: BoxDecoration(
                                          color: Color(0xff026a37),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: MaterialButton(
                                          padding: EdgeInsets.all(2),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => EXAMVIEW(
                                                  coursecode: snapshot
                                                      .data
                                                      .data
                                                      .studentCourseView[0]
                                                      .courseCode,
                                                  coursename: snapshot
                                                      .data
                                                      .data
                                                      .studentCourseView[0]
                                                      .course,
                                                  qpcode: snapshot
                                                      .data
                                                      .data
                                                      .studentCourseView[index]
                                                      .qpaperCode,
                                                  examname: snapshot
                                                          .data
                                                          .data
                                                          .studentCourseView[
                                                              index]
                                                          .qpaperExamName ??
                                                      '',
                                                ),
                                              ),
                                            );
                                          },
                                          child: Text(
                                            'Continue to Exam',
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      );
                    }),
              ),
            );
          } else
            return Container();
        });
  }
}
