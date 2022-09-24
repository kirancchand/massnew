// // To parse this JSON data, do
//
//     final registrationClass = registrationClassFromJson(jsonString);

import 'dart:convert';

RegistrationClass registrationClassFromJson(String str) =>
    RegistrationClass.fromJson(json.decode(str));

String registrationClassToJson(RegistrationClass data) =>
    json.encode(data.toJson());

class RegistrationClass {
  RegistrationClass({
    this.data,
  });

  Data data;

  factory RegistrationClass.fromJson(Map<String, dynamic> json) =>
      RegistrationClass(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.success,
    this.registeration,
  });

  String success;
  String registeration;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        success: json["success"],
        registeration: json["Registeration"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "Registeration": registeration,
      };
}
