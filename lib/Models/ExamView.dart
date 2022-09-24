// To parse this JSON data, do
//
//     final examViewClass = examViewClassFromJson(jsonString);

import 'dart:convert';

ExamViewClass examViewClassFromJson(String str) =>
    ExamViewClass.fromJson(json.decode(str));

String examViewClassToJson(ExamViewClass data) => json.encode(data.toJson());

class ExamViewClass {
  ExamViewClass({
    this.data,
  });

  Data data;

  factory ExamViewClass.fromJson(Map<String, dynamic> json) => ExamViewClass(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.success,
    this.examView,
  });

  String success;
  ExamView examView;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        success: json["success"],
        examView: ExamView.fromJson(json["exam_view"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "exam_view": examView.toJson(),
      };
}

class ExamView {
  ExamView({
    this.regno,
    this.qpcode,
    this.examtime,
    this.xamename,
    this.cours,
    this.courscode,
    this.questions,
  });

  String regno;
  String qpcode;
  String examtime;
  String xamename;
  String cours;
  String courscode;
  List<Question> questions;

  factory ExamView.fromJson(Map<String, dynamic> json) => ExamView(
        regno: json["regno"],
        qpcode: json["qpcode"],
        examtime: json["examtime"],
        xamename: json["xamename"],
        cours: json["cours"],
        courscode: json["courscode"],
        questions: List<Question>.from(
            json["questions"].map((x) => Question.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "regno": regno,
        "qpcode": qpcode,
        "examtime": examtime,
        "xamename": xamename,
        "cours": cours,
        "courscode": courscode,
        "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
      };
}

class Question {
  Question({
    this.questionsId,
    this.questionsXam,
    this.questionsQcode,
    this.questionsCourse,
    this.questionsQuestion,
    this.optionA,
    this.optionB,
    this.optionC,
    this.optionD,
    this.questionsAnswer,
    this.questionsStatus,
    this.questionsDate,
  });

  String questionsId;
  String questionsXam;
  String questionsQcode;
  String questionsCourse;
  String questionsQuestion;
  String optionA;
  String optionB;
  String optionC;
  String optionD;
  String questionsAnswer;
  String questionsStatus;
  DateTime questionsDate;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        questionsId: json["questions_id"],
        questionsXam: json["questions_xam"],
        questionsQcode: json["questions_qcode"],
        questionsCourse: json["questions_course"],
        questionsQuestion: json["questions_question"],
        optionA: json["Option_A"],
        optionB: json["Option_B"],
        optionC: json["Option_C"],
        optionD: json["Option_D"],
        questionsAnswer: json["questions_answer"],
        questionsStatus: json["questions_status"],
        questionsDate: DateTime.parse(json["questions_date"]),
      );

  Map<String, dynamic> toJson() => {
        "questions_id": questionsId,
        "questions_xam": questionsXam,
        "questions_qcode": questionsQcode,
        "questions_course": questionsCourse,
        "questions_question": questionsQuestion,
        "Option_A": optionA,
        "Option_B": optionB,
        "Option_C": optionC,
        "Option_D": optionD,
        "questions_answer": questionsAnswer,
        "questions_status": questionsStatus,
        "questions_date":
            "${questionsDate.year.toString().padLeft(4, '0')}-${questionsDate.month.toString().padLeft(2, '0')}-${questionsDate.day.toString().padLeft(2, '0')}",
      };
}
