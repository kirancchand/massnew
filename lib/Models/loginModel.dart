// To parse this JSON data, do
//
//     final loginClass = loginClassFromJson(jsonString);

import 'dart:convert';

LoginClass loginClassFromJson(String str) =>
    LoginClass.fromJson(json.decode(str));

String loginClassToJson(LoginClass data) => json.encode(data.toJson());

class LoginClass {
  LoginClass({
    this.data,
  });

  Data data;

  factory LoginClass.fromJson(Map<String, dynamic> json) => LoginClass(
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
        details: json["success"] == "100"
            ? []
            : List<Detail>.from(json["Details"].map((x) => Detail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "Details": List<dynamic>.from(details.map((x) => x.toJson())),
      };
}

class Detail {
  Detail({
    this.studentId,
    this.studentCivilId,
    this.passNo,
    this.firstName,
    this.lastName,
    this.gender,
    this.dob,
    this.email,
    this.phno,
    this.qualification,
    this.pCourse,
    this.picture,
    this.studentReg,
    this.studentPwd,
    this.insDate,
    this.type,
  });

  String studentId;
  String studentCivilId;
  String passNo;
  String firstName;
  String lastName;
  String gender;
  String dob;
  String email;
  String phno;
  String qualification;
  String pCourse;
  String picture;
  String studentReg;
  String studentPwd;
  DateTime insDate;
  String type;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        studentId: json["student_id"],
        studentCivilId: json["student_civil_id"],
        passNo: json["pass_no"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        gender: json["gender"],
        dob: json["dob"],
        email: json["email"],
        phno: json["phno"],
        qualification: json["qualification"],
        pCourse: json["p_course"],
        picture: json["picture"],
        studentReg: json["student_reg"],
        studentPwd: json["student_pwd"],
        insDate: DateTime.parse(json["ins_date"]),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "student_id": studentId,
        "student_civil_id": studentCivilId,
        "pass_no": passNo,
        "first_name": firstName,
        "last_name": lastName,
        "gender": gender,
        "dob": dob,
        "email": email,
        "phno": phno,
        "qualification": qualification,
        "p_course": pCourse,
        "picture": picture,
        "student_reg": studentReg,
        "student_pwd": studentPwd,
        "ins_date":
            "${insDate.year.toString().padLeft(4, '0')}-${insDate.month.toString().padLeft(2, '0')}-${insDate.day.toString().padLeft(2, '0')}",
        "type": type,
      };
}
