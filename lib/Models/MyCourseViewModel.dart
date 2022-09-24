// To parse this JSON data, do
//
//     final myCourseViewClass = myCourseViewClassFromJson(jsonString);

import 'dart:convert';

MyCourseViewClass myCourseViewClassFromJson(String str) =>
    MyCourseViewClass.fromJson(json.decode(str));

String myCourseViewClassToJson(MyCourseViewClass data) =>
    json.encode(data.toJson());

class MyCourseViewClass {
  MyCourseViewClass({
    this.data,
  });

  Data data;

  factory MyCourseViewClass.fromJson(Map<String, dynamic> json) =>
      MyCourseViewClass(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.success,
    this.studentCourseView,
  });

  String success;
  List<StudentCourseView> studentCourseView;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        success: json["success"],
        studentCourseView: List<StudentCourseView>.from(
            json["student_course_view"]
                .map((x) => StudentCourseView.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "student_course_view":
            List<dynamic>.from(studentCourseView.map((x) => x.toJson())),
      };
}

class StudentCourseView {
  StudentCourseView({
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
    this.checkoutsId,
    this.checkoutsUId,
    this.checkoutsCId,
    this.checkoutOrderid,
    this.checkoutsValidity,
    this.checkoutsPrice,
    this.checkoutsCoupon,
    this.checkoutsDate,
    this.checkoutsExpdate,
    this.id,
    this.categoryName,
    this.courseCat,
    this.course,
    this.priority,
    this.courseDesc,
    this.courseCode,
    this.coursePic,
    this.qpaperCourse,
    this.qpaperCode,
    this.qpaperExamName,
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
  String checkoutsId;
  String checkoutsUId;
  String checkoutsCId;
  String checkoutOrderid;
  String checkoutsValidity;
  String checkoutsPrice;
  String checkoutsCoupon;
  DateTime checkoutsDate;
  DateTime checkoutsExpdate;
  String id;
  String categoryName;
  String courseCat;
  String course;
  String priority;
  String courseDesc;
  String courseCode;
  String coursePic;
  String qpaperCourse;
  String qpaperCode;
  String qpaperExamName;

  factory StudentCourseView.fromJson(Map<String, dynamic> json) =>
      StudentCourseView(
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
        checkoutsId: json["checkouts_id"],
        checkoutsUId: json["checkouts_u_id"],
        checkoutsCId: json["checkouts_c_id"],
        checkoutOrderid: json["checkout_orderid"],
        checkoutsValidity: json["checkouts_validity"],
        checkoutsPrice: json["checkouts_price"],
        checkoutsCoupon: json["checkouts_coupon"],
        checkoutsDate: DateTime.parse(json["checkouts_date"]),
        checkoutsExpdate: DateTime.parse(json["checkouts_expdate"]),
        id: json["id"],
        categoryName: json["category_name"],
        courseCat: json["course_cat"],
        course: json["course"],
        priority: json["priority"],
        courseDesc: json["course_desc"],
        courseCode: json["course_code"],
        coursePic: json["course_pic"],
        qpaperCourse: json["qpaper_course"],
        qpaperCode: json["qpaper_code"],
        qpaperExamName: json["qpaper_exam_name"],
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
        "checkouts_id": checkoutsId,
        "checkouts_u_id": checkoutsUId,
        "checkouts_c_id": checkoutsCId,
        "checkout_orderid": checkoutOrderid,
        "checkouts_validity": checkoutsValidity,
        "checkouts_price": checkoutsPrice,
        "checkouts_coupon": checkoutsCoupon,
        "checkouts_date":
            "${checkoutsDate.year.toString().padLeft(4, '0')}-${checkoutsDate.month.toString().padLeft(2, '0')}-${checkoutsDate.day.toString().padLeft(2, '0')}",
        "checkouts_expdate":
            "${checkoutsExpdate.year.toString().padLeft(4, '0')}-${checkoutsExpdate.month.toString().padLeft(2, '0')}-${checkoutsExpdate.day.toString().padLeft(2, '0')}",
        "id": id,
        "category_name": categoryName,
        "course_cat": courseCat,
        "course": course,
        "priority": priority,
        "course_desc": courseDesc,
        "course_code": courseCode,
        "course_pic": coursePic,
        "qpaper_course": qpaperCourse,
        "qpaper_code": qpaperCode,
        "qpaper_exam_name": qpaperExamName,
      };
}
