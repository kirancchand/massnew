// To parse this JSON data, do
//
//     final checkOutClass = checkOutClassFromJson(jsonString);

import 'dart:convert';

CheckOutClass checkOutClassFromJson(String str) =>
    CheckOutClass.fromJson(json.decode(str));

String checkOutClassToJson(CheckOutClass data) => json.encode(data.toJson());

class CheckOutClass {
  CheckOutClass({
    this.data,
  });

  Data data;

  factory CheckOutClass.fromJson(Map<String, dynamic> json) => CheckOutClass(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.success,
    this.data,
  });

  String success;
  String data;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        success: json["success"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data,
      };
}
