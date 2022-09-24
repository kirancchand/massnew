// To parse this JSON data, do
//
//     final studentCertificate = studentCertificateFromJson(jsonString);

import 'dart:convert';

StudentCertificate studentCertificateFromJson(String str) =>
    StudentCertificate.fromJson(json.decode(str));

String studentCertificateToJson(StudentCertificate data) =>
    json.encode(data.toJson());

class StudentCertificate {
  StudentCertificate({
    this.data,
  });

  Data data;

  factory StudentCertificate.fromJson(Map<String, dynamic> json) =>
      StudentCertificate(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.success,
    this.studentCertificateView,
    this.studentIdcardView,
  });

  String success;
  List<StudentCertificateView> studentCertificateView;
  List<StudentIdcardView> studentIdcardView;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        success: json["success"],
        studentCertificateView: List<StudentCertificateView>.from(
            json["student_certificate_view"]
                .map((x) => StudentCertificateView.fromJson(x))),
        studentIdcardView: List<StudentIdcardView>.from(
            json["Student_idcard_view"]
                .map((x) => StudentIdcardView.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "student_certificate_view":
            List<dynamic>.from(studentCertificateView.map((x) => x.toJson())),
        "Student_idcard_view":
            List<dynamic>.from(studentIdcardView.map((x) => x.toJson())),
      };
}

class StudentCertificateView {
  StudentCertificateView({
    this.certId,
    this.stRegno,
    this.stPasport,
    this.stName,
    this.certSrNo,
    this.stCertName,
    this.certFile,
    this.cInsDate,
  });

  String certId;
  String stRegno;
  String stPasport;
  String stName;
  String certSrNo;
  String stCertName;
  String certFile;
  DateTime cInsDate;

  factory StudentCertificateView.fromJson(Map<String, dynamic> json) =>
      StudentCertificateView(
        certId: json["cert_id"],
        stRegno: json["st_regno"],
        stPasport: json["st_pasport"],
        stName: json["st_name"],
        certSrNo: json["cert_sr_no"],
        stCertName: json["st_cert_name"],
        certFile: json["cert_file"],
        cInsDate: DateTime.parse(json["c_ins_date"]),
      );

  Map<String, dynamic> toJson() => {
        "cert_id": certId,
        "st_regno": stRegno,
        "st_pasport": stPasport,
        "st_name": stName,
        "cert_sr_no": certSrNo,
        "st_cert_name": stCertName,
        "cert_file": certFile,
        "c_ins_date":
            "${cInsDate.year.toString().padLeft(4, '0')}-${cInsDate.month.toString().padLeft(2, '0')}-${cInsDate.day.toString().padLeft(2, '0')}",
      };
}

class StudentIdcardView {
  StudentIdcardView({
    this.cardId,
    this.stIdRegno,
    this.stIdPasport,
    this.stIdName,
    this.stIdCertName,
    this.certIdFile,
    this.cIdInsDate,
  });

  String cardId;
  String stIdRegno;
  String stIdPasport;
  String stIdName;
  String stIdCertName;
  String certIdFile;
  DateTime cIdInsDate;

  factory StudentIdcardView.fromJson(Map<String, dynamic> json) =>
      StudentIdcardView(
        cardId: json["card_id"],
        stIdRegno: json["st_id_regno"],
        stIdPasport: json["st_id_pasport"],
        stIdName: json["st_id_name"],
        stIdCertName: json["st_id_cert_name"],
        certIdFile: json["cert_id_file"],
        cIdInsDate: DateTime.parse(json["c_id_ins_date"]),
      );

  Map<String, dynamic> toJson() => {
        "card_id": cardId,
        "st_id_regno": stIdRegno,
        "st_id_pasport": stIdPasport,
        "st_id_name": stIdName,
        "st_id_cert_name": stIdCertName,
        "cert_id_file": certIdFile,
        "c_id_ins_date":
            "${cIdInsDate.year.toString().padLeft(4, '0')}-${cIdInsDate.month.toString().padLeft(2, '0')}-${cIdInsDate.day.toString().padLeft(2, '0')}",
      };
}
