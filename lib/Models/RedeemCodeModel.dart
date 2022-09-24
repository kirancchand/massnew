// To parse this JSON data, do
//
//     final redeemCodeModel = redeemCodeModelFromJson(jsonString);

import 'dart:convert';

RedeemCodeModel redeemCodeModelFromJson(String str) =>
    RedeemCodeModel.fromJson(json.decode(str));

String redeemCodeModelToJson(RedeemCodeModel data) =>
    json.encode(data.toJson());

class RedeemCodeModel {
  RedeemCodeModel({
    this.data,
  });

  Data data;

  factory RedeemCodeModel.fromJson(Map<String, dynamic> json) =>
      RedeemCodeModel(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.success,
    this.reqcheckcode,
  });

  String success;
  String reqcheckcode;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        success: json["success"],
        reqcheckcode: json["reqcheckcode"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "reqcheckcode": reqcheckcode,
      };
}
