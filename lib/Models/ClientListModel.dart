// To parse this JSON data, do
//
//     final clientListModel = clientListModelFromJson(jsonString);

import 'dart:convert';

ClientListModel clientListModelFromJson(String str) =>
    ClientListModel.fromJson(json.decode(str));

String clientListModelToJson(ClientListModel data) =>
    json.encode(data.toJson());

class ClientListModel {
  ClientListModel({
    this.data,
  });

  Data data;

  factory ClientListModel.fromJson(Map<String, dynamic> json) =>
      ClientListModel(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.success,
    this.clientList,
  });

  String success;
  List<ClientList> clientList;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        success: json["success"],
        clientList: List<ClientList>.from(
            json["client_list"].map((x) => ClientList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "client_list": List<dynamic>.from(clientList.map((x) => x.toJson())),
      };
}

class ClientList {
  ClientList({
    this.clientId,
    this.trainerId,
    this.clientName,
    this.clientPhone,
    this.clientMailid,
    this.clientCompany,
    this.insDate,
    this.latitude,
    this.longitude
  });

  String clientId;
  String trainerId;
  String clientName;
  String clientPhone;
  String clientMailid;
  String clientCompany;
  DateTime insDate;
  String latitude;
  String longitude;

  factory ClientList.fromJson(Map<String, dynamic> json) => ClientList(
        clientId: json["client_id"],
        trainerId: json["trainer_id"],
        clientName: json["client_name"],
        clientPhone: json["client_phone"],
        clientMailid: json["client_mailid"],
        clientCompany: json["client_company"],
        insDate: DateTime.parse(json["ins_date"]),
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "client_id": clientId,
        "trainer_id": trainerId,
        "client_name": clientName,
        "client_phone": clientPhone,
        "client_mailid": clientMailid,
        "client_company": clientCompany,
        "ins_date":"${insDate.year.toString().padLeft(4, '0')}-${insDate.month.toString().padLeft(2, '0')}-${insDate.day.toString().padLeft(2, '0')}",
        "latitude":latitude,
        "longitude":longitude
      };
}
