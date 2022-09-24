import 'package:flutter/material.dart';
import 'package:massnew/Api/api.dart';
import 'package:massnew/Models/fullCourseViewModel.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class CourseScreen extends StatefulWidget {
  @override
  _CourseScreenState createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  GlobalKey<ScaffoldState> key = GlobalKey();
  bool spin = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      body: FutureBuilder<FullCourseViewClass>(
        future: fullCourseViewApi(),
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
                        'Course List',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 19,
                          color: Color(0xff026a37),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height - 210,
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: snapshot.data.data.details.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              height: 140,
                              width: double.infinity,
                              margin: EdgeInsets.symmetric(vertical: 3),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                // color: Colors.green[700],
                                color: Color(0xff026a37),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          snapshot.data.data.details[index]
                                                  .course ??
                                              '',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              color: Colors.white),
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          snapshot.data.data.details[index]
                                                  .catname ??
                                              '',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                              color: Colors.white),
                                        ),
                                      ),
                                      Container(
                                        height: 30,
                                        decoration: BoxDecoration(
                                          // color: Color(0xff026a37),
                                          color: Colors.brown,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: MaterialButton(
                                          onPressed: () async {
                                            setState(() {
                                              spin = true;
                                            });
                                            var s = await cartAddApi(
                                                cid: snapshot.data.data
                                                        .details[index].id ??
                                                    "");
                                            setState(() {
                                              spin = false;
                                            });
                                            key.currentState.showSnackBar(
                                                SnackBar(content: Text(s)));
                                            await Future.delayed(
                                                Duration(seconds: 1));
                                          },
                                          child: Text(
                                            'Add To Cart',
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
            ));
        },
      ),
    );
  }
}
