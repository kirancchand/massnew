// To parse this JSON data, do
//
//     final profileClass = profileClassFromJson(jsonString);

import 'dart:convert';

ProfileClass profileClassFromJson(String str) =>
    ProfileClass.fromJson(json.decode(str));

String profileClassToJson(ProfileClass data) => json.encode(data.toJson());

class ProfileClass {
  ProfileClass({
    this.data,
  });

  Data1 data;

  factory ProfileClass.fromJson(Map<String, dynamic> json) => ProfileClass(
        data: Data1.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data1 {
  Data1({
    this.success,
    this.studentProfileView,
  });

  String success;
  StudentProfileView studentProfileView;

  factory Data1.fromJson(Map<String, dynamic> json) => Data1(
        success: json["success"],
        studentProfileView:
            StudentProfileView.fromJson(json["student_profile_view"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "student_profile_view": studentProfileView.toJson(),
      };
}

class StudentProfileView {
  StudentProfileView({
    this.studentId,
    this.studentCivilId,
    this.firstName,
    this.lastName,
    this.gender,
    this.dob,
    this.pCourse,
    this.email,
    this.phno,
    this.qualification,
    this.picture,
    this.studentReg,
    this.passNo,
    this.studentPwd,
    this.courseName,
  });

  String studentId;
  String studentCivilId;
  String firstName;
  String lastName;
  String gender;
  DateTime dob;
  String pCourse;
  String email;
  String phno;
  String qualification;
  String picture;
  String studentReg;
  String passNo;
  String studentPwd;
  String courseName;

  factory StudentProfileView.fromJson(Map<String, dynamic> json) =>
      StudentProfileView(
        studentId: json["student_id"],
        studentCivilId: json["student_civil_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        gender: json["gender"],
        dob: DateTime.parse(json["dob"]),
        pCourse: json["p_course"],
        email: json["email"],
        phno: json["phno"],
        qualification: json["qualification"],
        picture: json["picture"],
        studentReg: json["student_reg"],
        passNo: json["pass_no"],
        studentPwd: json["student_pwd"],
        courseName: json["course_name"],
      );

  Map<String, dynamic> toJson() => {
        "student_id": studentId,
        "student_civil_id": studentCivilId,
        "first_name": firstName,
        "last_name": lastName,
        "gender": gender,
        "dob":
            "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
        "p_course": pCourse,
        "email": email,
        "phno": phno,
        "qualification": qualification,
        "picture": picture,
        "student_reg": studentReg,
        "pass_no": passNo,
        "student_pwd": studentPwd,
        "course_name": courseName,
      };
}
