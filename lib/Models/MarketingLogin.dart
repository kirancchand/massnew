// To parse this JSON data, do
//
//     final marketingLoginModel = marketingLoginModelFromJson(jsonString);

import 'dart:convert';

MarketingLoginModel marketingLoginModelFromJson(String str) =>
    MarketingLoginModel.fromJson(json.decode(str));

String marketingLoginModelToJson(MarketingLoginModel data) =>
    json.encode(data.toJson());

class MarketingLoginModel {
  MarketingLoginModel({
    this.data,
  });

  Data data;

  factory MarketingLoginModel.fromJson(Map<String, dynamic> json) =>
      MarketingLoginModel(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.success,
    this.marketingLogin,
  });

  String success;
  MarketingLogin marketingLogin;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        success: json["success"],
        marketingLogin: json["success"] == "100"
            ? []
            : MarketingLogin.fromJson(json["Marketing_login"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "Marketing_login": marketingLogin.toJson(),
      };
}

class MarketingLogin {
  MarketingLogin({
    this.id,
    this.username,
    this.type,
    this.validate,
  });

  String id;
  String username;
  String type;
  bool validate;

  factory MarketingLogin.fromJson(Map<String, dynamic> json) => MarketingLogin(
        id: json["id"],
        username: json["username"],
        type: json["type"],
        validate: json["validate"],
      );

  Map<String, dynamic> toJson() => {
        "id": id ?? '',
        "username": username ?? '',
        "type": type ?? "",
        "validate": validate ?? '',
      };
}
