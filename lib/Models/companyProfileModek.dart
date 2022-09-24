// To parse this JSON data, do
//
//     final companyProfileClass = companyProfileClassFromJson(jsonString);

import 'dart:convert';

CompanyProfileClass companyProfileClassFromJson(String str) =>
    CompanyProfileClass.fromJson(json.decode(str));

String companyProfileClassToJson(CompanyProfileClass data) =>
    json.encode(data.toJson());

class CompanyProfileClass {
  CompanyProfileClass({
    this.data,
  });

  Data data;

  factory CompanyProfileClass.fromJson(Map<String, dynamic> json) =>
      CompanyProfileClass(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.success,
    this.companyProfileView,
  });

  String success;
  List<CompanyProfileView> companyProfileView;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        success: json["success"],
        companyProfileView: List<CompanyProfileView>.from(
            json["company_profile_view"]
                .map((x) => CompanyProfileView.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "company_profile_view":
            List<dynamic>.from(companyProfileView.map((x) => x.toJson())),
      };
}

class CompanyProfileView {
  CompanyProfileView({
    this.companyInfoId,
    this.companyInfoRegno,
    this.companyInfoPwd,
    this.companyInfoName,
    this.companyInfoMail,
    this.companyInfoPhon,
    this.companyInfoDate,
    this.type,
  });

  String companyInfoId;
  String companyInfoRegno;
  String companyInfoPwd;
  String companyInfoName;
  String companyInfoMail;
  String companyInfoPhon;
  DateTime companyInfoDate;
  String type;

  factory CompanyProfileView.fromJson(Map<String, dynamic> json) =>
      CompanyProfileView(
        companyInfoId: json["company_info_id"],
        companyInfoRegno: json["company_info_regno"],
        companyInfoPwd: json["company_info_pwd"],
        companyInfoName: json["company_info_name"],
        companyInfoMail: json["company_info_mail"],
        companyInfoPhon: json["company_info_phon"],
        companyInfoDate: DateTime.parse(json["company_info_date"]),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "company_info_id": companyInfoId,
        "company_info_regno": companyInfoRegno,
        "company_info_pwd": companyInfoPwd,
        "company_info_name": companyInfoName,
        "company_info_mail": companyInfoMail,
        "company_info_phon": companyInfoPhon,
        "company_info_date":
            "${companyInfoDate.year.toString().padLeft(4, '0')}-${companyInfoDate.month.toString().padLeft(2, '0')}-${companyInfoDate.day.toString().padLeft(2, '0')}",
        "type": type,
      };
}
