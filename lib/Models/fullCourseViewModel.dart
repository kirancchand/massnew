// To parse this JSON data, do
//
//     final fullCourseViewClass = fullCourseViewClassFromJson(jsonString);

import 'dart:convert';

FullCourseViewClass fullCourseViewClassFromJson(String str) =>
    FullCourseViewClass.fromJson(json.decode(str));

String fullCourseViewClassToJson(FullCourseViewClass data) =>
    json.encode(data.toJson());

class FullCourseViewClass {
  FullCourseViewClass({
    this.data,
  });

  Data data;

  factory FullCourseViewClass.fromJson(Map<String, dynamic> json) =>
      FullCourseViewClass(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.success,
    this.details,
  });

  String success;
  List<Detail> details;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        success: json["success"],
        details:
            List<Detail>.from(json["Details"].map((x) => Detail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "Details": List<dynamic>.from(details.map((x) => x.toJson())),
      };
}

class Detail {
  Detail({
    this.id,
    this.course,
    this.courseCat,
    this.courseDesc,
    this.courseCode,
    this.coursePic,
    this.catname,
  });

  String id;
  String course;
  String courseCat;
  String courseDesc;
  String courseCode;
  String coursePic;
  String catname;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        id: json["id"],
        course: json["course"],
        courseCat: json["course_cat"],
        courseDesc: json["course_desc"],
        courseCode: json["course_code"],
        coursePic: json["course_pic"] ??
            'http://www.masshseconsultant.com/admin/uploads/11f8835ff2e8fcc9520327b0ffc3d19a.jpg',
        catname: json["catname"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "course": course,
        "course_cat": courseCat,
        "course_desc": courseDesc,
        "course_code": courseCode,
        "course_pic": coursePic,
        "catname": catname,
      };
}
