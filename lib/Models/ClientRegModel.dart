// To parse this JSON data, do
//
//     final clientRegModel = clientRegModelFromJson(jsonString);

import 'dart:convert';

ClientRegModel clientRegModelFromJson(String str) =>
    ClientRegModel.fromJson(json.decode(str));

String clientRegModelToJson(ClientRegModel data) => json.encode(data.toJson());

class ClientRegModel {
  ClientRegModel({
    this.data,
  });

  Data data;

  factory ClientRegModel.fromJson(Map<String, dynamic> json) => ClientRegModel(
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
