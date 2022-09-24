// To parse this JSON data, do
//
//     final marketingProfileModel = marketingProfileModelFromJson(jsonString);

import 'dart:convert';

MarketingProfileModel marketingProfileModelFromJson(String str) =>
    MarketingProfileModel.fromJson(json.decode(str));

String marketingProfileModelToJson(MarketingProfileModel data) =>
    json.encode(data.toJson());

class MarketingProfileModel {
  MarketingProfileModel({
    this.data,
  });

  Data data;

  factory MarketingProfileModel.fromJson(Map<String, dynamic> json) =>
      MarketingProfileModel(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.success,
    this.trainerProfileView,
  });

  String success;
  List<TrainerProfileView> trainerProfileView;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        success: json["success"],
        trainerProfileView: List<TrainerProfileView>.from(
            json["trainer_profile_view"]
                .map((x) => TrainerProfileView.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "trainer_profile_view":
            List<dynamic>.from(trainerProfileView.map((x) => x.toJson())),
      };
}

class TrainerProfileView {
  TrainerProfileView({
    this.trainerId,
    this.trainerName,
    this.trainerMailid,
    this.trainerGender,
    this.trainerDob,
    this.trainerPhone,
    this.trainerPassword,
    this.trainerQualification,
    this.trainerPic,
    this.courseName,
  });

  String trainerId;
  String trainerName;
  String trainerMailid;
  String trainerGender;
  DateTime trainerDob;
  String trainerPhone;
  String trainerPassword;
  String trainerQualification;
  String trainerPic;
  String courseName;

  factory TrainerProfileView.fromJson(Map<String, dynamic> json) =>
      TrainerProfileView(
        trainerId: json["trainer_id"],
        trainerName: json["trainer_name"],
        trainerMailid: json["trainer_mailid"],
        trainerGender: json["trainer_gender"],
        trainerDob: DateTime.parse(json["trainer_dob"]),
        trainerPhone: json["trainer_phone"],
        trainerPassword: json["trainer_password"],
        trainerQualification: json["trainer_qualification"],
        trainerPic: json["trainer_pic"],
        courseName: json["course_name"],
      );

  Map<String, dynamic> toJson() => {
        "trainer_id": trainerId,
        "trainer_name": trainerName,
        "trainer_mailid": trainerMailid,
        "trainer_gender": trainerGender,
        "trainer_dob":
            "${trainerDob.year.toString().padLeft(4, '0')}-${trainerDob.month.toString().padLeft(2, '0')}-${trainerDob.day.toString().padLeft(2, '0')}",
        "trainer_phone": trainerPhone,
        "trainer_password": trainerPassword,
        "trainer_qualification": trainerQualification,
        "trainer_pic": trainerPic,
        "course_name": courseName,
      };
}
