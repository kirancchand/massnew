import 'package:countdown_flutter/countdown_flutter.dart';
import 'package:flutter/material.dart';
import 'package:massnew/Api/api.dart';
import 'package:massnew/Models/ExamSubmitModel.dart';
import 'package:massnew/Models/ExamView.dart';
import 'package:massnew/Screens/tabScreen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class EXAMVIEW extends StatefulWidget {
  EXAMVIEW({this.coursecode, this.coursename, this.examname, this.qpcode});
  String qpcode;
  String coursecode;
  String examname;
  String coursename;

  @override
  _EXAMVIEWState createState() => _EXAMVIEWState();
}

class _EXAMVIEWState extends State<EXAMVIEW> {
  List<QandAns> listofqueandans = [];
  List<Map<String, String>> m;
  // var m;
  var x;
  String getAnswer(int index) {
    String option;
    for (var item in listofqueandans) {
      if (item.index == index) {
        option = item.ans;
        break;
      }
    }
    return option;
  }

  Color getColor(int index, String option) {
    if (listofqueandans.map((e) => e.index).toList().contains(index)) {
      QandAns ans;
      for (var item in listofqueandans) {
        if (item.index == index) {
          ans = item;
          break;
        }
      }
      if (ans.ans == option) {
        return Color(0xff026a37);
      } else {
        return Colors.white;
      }
    } else {
      return Colors.white;
    }
  }

  addQandAns({int index1, String questionid, String answer}) {
    x = listofqueandans.map((e) => e.index).toList();
    var i = x.indexOf(index1);
    setState(() {
      if (i == -1) {
        listofqueandans.add(
          QandAns(
            index: index1,
            qid: questionid,
            ans: answer,
          ),
        );
      } else {
        listofqueandans[i] = QandAns(
          index: index1,
          qid: questionid,
          ans: answer,
        );
      }
    });
    print(x.length);
  }

  List<Map<String, String>> convert() {
    return listofqueandans.map((e) => e.toMap()).toList();
  }

  int hr = 0;
  int min = 0;
  int sec = 0;
  bool spin = false;

  // CountdownController timecontroller = CountdownController();
  GlobalKey<ScaffoldState> key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: ModalProgressHUD(
        inAsyncCall: spin,
        child: FutureBuilder<ExamViewClass>(
          future: examViewApi(
            qpcode: widget.qpcode,
            examname: widget.examname,
            coursecode: widget.coursecode,
            coursename: widget.coursename,
          ),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              hr = int.parse(snapshot.data.data.examView.examtime[0] +
                  snapshot.data.data.examView.examtime[1]);
              min = int.parse(snapshot.data.data.examView.examtime[3] +
                  snapshot.data.data.examView.examtime[4]);
              sec = int.parse(snapshot.data.data.examView.examtime[6] +
                  snapshot.data.data.examView.examtime[7]);
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(15)),
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Text(
                          //   snapshot.data.data.examView.courscode ?? '',
                          //   style: TextStyle(
                          //     color: Colors.white,
                          //     fontSize: 15,
                          //   ),
                          // ),
                          Text(
                            snapshot.data.data.examView.cours ?? '',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                          Container(
                            child: Countdown(
                              builder: (BuildContext ctx, Duration remaining) {
                                var time = remaining.toString();
                                String t = time[0] +
                                    time[1] +
                                    time[2] +
                                    time[3] +
                                    time[4] +
                                    time[5] +
                                    time[6];
                                return Text(
                                  t,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                );
                              },
                              duration: Duration(
                                  hours: hr, minutes: min, seconds: sec),
                              // Duration(seconds: 10),
                              onFinish: () async {
                                var mx = convert();
                                print(mx);
                                setState(() {
                                  spin = true;
                                });
                                ExamSubmitModel x = await submitAnswer(
                                    answers: mx,
                                    qcode: snapshot.data.data.examView.qpcode ??
                                        '',
                                    qcourse: snapshot.data.data.examView
                                            .questions[0].questionsCourse ??
                                        "",
                                    examregno:
                                        snapshot.data.data.examView.regno ??
                                            '');
                                setState(() {
                                  spin = false;
                                });

                                if (x.data.success == "200") {
                                  key.currentState.showSnackBar(
                                    SnackBar(
                                      content:
                                          Text(x.data.checkAnswerpaper ?? ''),
                                    ),
                                  );
                                } else {
                                  key.currentState.showSnackBar(
                                    SnackBar(
                                      content:
                                          Text(x.data.checkAnswerpaper ?? ""),
                                    ),
                                  );
                                }
                                await Future.delayed(Duration(seconds: 2));
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NavBar(),
                                  ),
                                );
                              },
                            ),
                          ),
                          // Text(
                          //   '3 hrs',
                          //   style: TextStyle(
                          //     fontWeight: FontWeight.bold,
                          //     color: Colors.white,
                          //     fontSize: 16,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ListView.builder(
                        itemCount: snapshot.data.data.examView.questions.length,
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          Question data =
                              snapshot.data.data.examView.questions[index];
                          return Container(
                            margin: EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                            child: Material(
                              color: Colors.grey[400],
                              borderRadius: BorderRadius.circular(20),
                              elevation: 10,
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 20),
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 15),
                                      child: Text(
                                        data.questionsQuestion ?? "",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    OptionWidget(
                                      option: data.optionA,
                                      color: getColor(index, 'Option_A'),
                                      onTap: () {
                                        addQandAns(
                                          index1: index,
                                          questionid: data.questionsId,
                                          answer: 'Option_A',
                                        );
                                      },
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    OptionWidget(
                                      option: data.optionB,
                                      color: getColor(index, 'Option_B'),
                                      onTap: () {
                                        addQandAns(
                                          index1: index,
                                          questionid: data.questionsId,
                                          answer: 'Option_B',
                                        );
                                      },
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    OptionWidget(
                                      option: data.optionC,
                                      color: getColor(index, 'Option_C'),
                                      onTap: () {
                                        addQandAns(
                                          index1: index,
                                          questionid: data.questionsId,
                                          answer: 'Option_C',
                                        );
                                      },
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    OptionWidget(
                                      option: data.optionD,
                                      color: getColor(index, 'Option_D'),
                                      onTap: () {
                                        addQandAns(
                                          index1: index,
                                          questionid: data.questionsId,
                                          answer: 'Option_D',
                                        );
                                      },
                                    ),
                                    // Container(
                                    //   decoration: BoxDecoration(
                                    //     color: Color(0xff026a37),
                                    //     shape: BoxShape.circle,
                                    //   ),
                                    //   child: IconButton(
                                    //     color: Colors.transparent,
                                    //     onPressed: () {
                                    //       index++;
                                    //     },
                                    //     icon: Icon(
                                    //       Icons.arrow_forward_ios_outlined,
                                    //       color: Colors.black,
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        var mx = convert();
                        print(mx);
                        ExamSubmitModel x = await submitAnswer(
                            answers: mx,
                            qcode: snapshot.data.data.examView.qpcode ?? '',
                            qcourse: snapshot.data.data.examView.questions[0]
                                    .questionsCourse ??
                                "",
                            examregno: snapshot.data.data.examView.regno ?? '');

                        if (x.data.success == "100") {
                          key.currentState.showSnackBar(SnackBar(
                              content: Text(x.data.checkAnswerpaper ?? '')));
                        } else {
                          key.currentState.showSnackBar(SnackBar(
                              content: Text(x.data.checkAnswerpaper ?? "")));
                        }
                        await Future.delayed(Duration(seconds: 2));
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NavBar(),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 50),
                        width: MediaQuery.of(context).size.width - 30,
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                        decoration: BoxDecoration(
                          color: Color(0xff026a37),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Text(
                            "Submit",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}

class OptionWidget extends StatelessWidget {
  OptionWidget({this.option, this.onTap, this.color});

  String option;
  Color color;
  Function onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        width: MediaQuery.of(context).size.width - 30,
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Text(
            option ?? "",
            style: TextStyle(
              fontSize: 16,
              color: color == Colors.white ? Colors.black : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class QandAns {
  int index;
  String qid;
  String ans;
  QandAns({this.index, this.qid, this.ans});
  Map<String, String> toMap() => {
        "questions_id": qid,
        "questions_answer": ans,
      };
}
