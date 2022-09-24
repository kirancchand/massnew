// To parse this JSON data, do
//
//     final pdfAndVideoClass = pdfAndVideoClassFromJson(jsonString);

import 'dart:convert';

PdfAndVideoClass pdfAndVideoClassFromJson(String str) =>
    PdfAndVideoClass.fromJson(json.decode(str));

String pdfAndVideoClassToJson(PdfAndVideoClass data) =>
    json.encode(data.toJson());

class PdfAndVideoClass {
  PdfAndVideoClass({
    this.data,
  });

  Data data;

  factory PdfAndVideoClass.fromJson(Map<String, dynamic> json) =>
      PdfAndVideoClass(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.success,
    this.viewPdfAndVideos,
    this.relatedPdfAndVideos,
  });

  String success;
  ViewPdfAndVideos viewPdfAndVideos;
  List<ViewPdfAndVideos> relatedPdfAndVideos;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        success: json["success"],
        viewPdfAndVideos:
            ViewPdfAndVideos.fromJson(json["view pdf and videos"]),
        relatedPdfAndVideos: List<ViewPdfAndVideos>.from(
            json["related pdf and videos"]
                .map((x) => ViewPdfAndVideos.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "view pdf and videos": viewPdfAndVideos.toJson(),
        "related pdf and videos":
            List<dynamic>.from(relatedPdfAndVideos.map((x) => x.toJson())),
      };
}

class ViewPdfAndVideos {
  ViewPdfAndVideos({
    this.moduleId,
    this.moduleName,
    this.moduleNo,
    this.moduleCourse,
    this.moduleFile,
    this.moduleVideo,
    this.moduleViewStatus,
    this.moduleStatus,
    this.moduleDate,
  });

  String moduleId;
  String moduleName;
  String moduleNo;
  String moduleCourse;
  String moduleFile;
  String moduleVideo;
  String moduleViewStatus;
  String moduleStatus;
  DateTime moduleDate;

  factory ViewPdfAndVideos.fromJson(Map<String, dynamic> json) =>
      ViewPdfAndVideos(
        moduleId: json["module_id"],
        moduleName: json["module_name"],
        moduleNo: json["module_no"],
        moduleCourse: json["module_course"],
        moduleFile: json["module_file"],
        moduleVideo: json["module_video"],
        moduleViewStatus: json["module_view_status"],
        moduleStatus: json["module_status"],
        moduleDate: DateTime.parse(json["module_date"]),
      );

  Map<String, dynamic> toJson() => {
        "module_id": moduleId,
        "module_name": moduleName,
        "module_no": moduleNo,
        "module_course": moduleCourse,
        "module_file": moduleFile,
        "module_video": moduleVideo,
        "module_view_status": moduleViewStatus,
        "module_status": moduleStatus,
        "module_date":
            "${moduleDate.year.toString().padLeft(4, '0')}-${moduleDate.month.toString().padLeft(2, '0')}-${moduleDate.day.toString().padLeft(2, '0')}",
      };
}
