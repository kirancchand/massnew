// To parse this JSON data, do
//
//     final homeBannerModel = homeBannerModelFromJson(jsonString);

import 'dart:convert';

HomeBannerModel homeBannerModelFromJson(String str) =>
    HomeBannerModel.fromJson(json.decode(str));

String homeBannerModelToJson(HomeBannerModel data) =>
    json.encode(data.toJson());

class HomeBannerModel {
  HomeBannerModel({
    this.data,
  });

  Data data;

  factory HomeBannerModel.fromJson(Map<String, dynamic> json) =>
      HomeBannerModel(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.success,
    this.sliderApi,
  });

  String success;
  List<SliderApi> sliderApi;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        success: json["success"],
        sliderApi: List<SliderApi>.from(
            json["slider api"].map((x) => SliderApi.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "slider api": List<dynamic>.from(sliderApi.map((x) => x.toJson())),
      };
}

class SliderApi {
  SliderApi({
    this.sliderId,
    this.sliderName,
    this.slidePriority,
    this.slideImage,
  });

  String sliderId;
  String sliderName;
  String slidePriority;
  String slideImage;

  factory SliderApi.fromJson(Map<String, dynamic> json) => SliderApi(
        sliderId: json["slider_id"],
        sliderName: json["slider_name"],
        slidePriority: json["slide_priority"],
        slideImage: json["slide_image"],
      );

  Map<String, dynamic> toJson() => {
        "slider_id": sliderId,
        "slider_name": sliderName,
        "slide_priority": slidePriority,
        "slide_image": slideImage,
      };
}
