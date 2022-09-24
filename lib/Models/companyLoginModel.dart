// To parse this JSON data, do
//
//     final companyLoginModel = companyLoginModelFromJson(jsonString);

import 'dart:convert';

CompanyLoginModel companyLoginModelFromJson(String str) =>
    CompanyLoginModel.fromJson(json.decode(str));

String companyLoginModelToJson(CompanyLoginModel data) =>
    json.encode(data.toJson());

class CompanyLoginModel {
  CompanyLoginModel({
    this.data,
  });

  Data data;

  factory CompanyLoginModel.fromJson(Map<String, dynamic> json) =>
      CompanyLoginModel(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.success,
    this.companyLogin,
  });

  String success;
  CompanyLogin companyLogin;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        success: json["success"],
        companyLogin: json["success"] == "200"
            ? CompanyLogin.fromJson(json["company_login"])
            : [],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "company_login": companyLogin.toJson(),
      };
}

class CompanyLogin {
  CompanyLogin({
    this.id,
    this.username,
    this.userreg,
    this.type,
    this.validate,
  });

  String id;
  String username;
  String userreg;
  String type;
  bool validate;

  factory CompanyLogin.fromJson(Map<String, dynamic> json) => CompanyLogin(
        id: json["id"],
        username: json["username"],
        userreg: json["userreg"],
        type: json["type"],
        validate: json["validate"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "userreg": userreg,
        "type": type,
        "validate": validate,
      };
}
