// To parse this JSON data, do
//
//     final companyCertificateClass = companyCertificateClassFromJson(jsonString);

import 'dart:convert';

CompanyCertificateClass companyCertificateClassFromJson(String str) =>
    CompanyCertificateClass.fromJson(json.decode(str));

String companyCertificateClassToJson(CompanyCertificateClass data) =>
    json.encode(data.toJson());

class CompanyCertificateClass {
  CompanyCertificateClass({
    this.data,
  });

  Data data;

  factory CompanyCertificateClass.fromJson(Map<String, dynamic> json) =>
      CompanyCertificateClass(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.success,
    this.companyCertificationView,
  });

  String success;
  List<CompanyCertificationView> companyCertificationView;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        success: json["success"],
        companyCertificationView: List<CompanyCertificationView>.from(
            json["company_certification_view"]
                .map((x) => CompanyCertificationView.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "company_certification_view":
            List<dynamic>.from(companyCertificationView.map((x) => x.toJson())),
      };
}

class CompanyCertificationView {
  CompanyCertificationView({
    this.companyId,
    this.companyRegno,
    this.companyName,
    this.companyProject,
    this.companyCerttype,
    this.companyCors,
    this.companyServ,
    this.companyLocation,
    this.companyCertificate,
    this.companyDate,
    this.id,
    this.course,
    this.courseCat,
    this.priority,
    this.courseDesc,
    this.courseCode,
    this.coursePic,
    this.serviceId,
    this.serviceName,
    this.serviceDesc,
    this.serviceImage,
  });

  String companyId;
  String companyRegno;
  String companyName;
  String companyProject;
  String companyCerttype;
  String companyCors;
  String companyServ;
  String companyLocation;
  String companyCertificate;
  DateTime companyDate;
  String id;
  String course;
  String courseCat;
  String priority;
  String courseDesc;
  String courseCode;
  String coursePic;
  String serviceId;
  String serviceName;
  String serviceDesc;
  String serviceImage;

  factory CompanyCertificationView.fromJson(Map<String, dynamic> json) =>
      CompanyCertificationView(
        companyId: json["company_id"],
        companyRegno: json["company_regno"],
        companyName: json["company_name"],
        companyProject: json["company_project"],
        companyCerttype: json["company_certtype"],
        companyCors: json["company_cors"],
        companyServ: json["company_serv"],
        companyLocation: json["company_location"],
        companyCertificate: json["company_certificate"],
        companyDate: DateTime.parse(json["company_date"]),
        id: json["id"],
        course: json["course"],
        courseCat: json["course_cat"],
        priority: json["priority"],
        courseDesc: json["course_desc"],
        courseCode: json["course_code"],
        coursePic: json["course_pic"],
        serviceId: json["service_id"],
        serviceName: json["service_name"],
        serviceDesc: json["service_desc"],
        serviceImage: json["service_image"],
      );

  Map<String, dynamic> toJson() => {
        "company_id": companyId,
        "company_regno": companyRegno,
        "company_name": companyName,
        "company_project": companyProject,
        "company_certtype": companyCerttype,
        "company_cors": companyCors,
        "company_serv": companyServ,
        "company_location": companyLocation,
        "company_certificate": companyCertificate,
        "company_date":
            "${companyDate.year.toString().padLeft(4, '0')}-${companyDate.month.toString().padLeft(2, '0')}-${companyDate.day.toString().padLeft(2, '0')}",
        "id": id,
        "course": course,
        "course_cat": courseCat,
        "priority": priority,
        "course_desc": courseDesc,
        "course_code": courseCode,
        "course_pic": coursePic,
        "service_id": serviceId,
        "service_name": serviceName,
        "service_desc": serviceDesc,
        "service_image": serviceImage,
      };
}
