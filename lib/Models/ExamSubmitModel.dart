// To parse this JSON data, do
//
//     final examSubmitModel = examSubmitModelFromJson(jsonString);

import 'dart:convert';

ExamSubmitModel examSubmitModelFromJson(String str) =>
    ExamSubmitModel.fromJson(json.decode(str));

String examSubmitModelToJson(ExamSubmitModel data) =>
    json.encode(data.toJson());

class ExamSubmitModel {
  ExamSubmitModel({
    this.data,
  });

  Data data;

  factory ExamSubmitModel.fromJson(Map<String, dynamic> json) =>
      ExamSubmitModel(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.success,
    this.checkAnswerpaper,
  });

  String success;
  String checkAnswerpaper;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        success: json["success"],
        checkAnswerpaper: json["check answerpaper"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "check answerpaper": checkAnswerpaper,
      };
}
