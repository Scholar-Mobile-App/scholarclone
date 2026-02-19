import 'dart:convert';

AboutUsModel aboutUsModelFromJson(String str) =>
    AboutUsModel.fromJson(json.decode(str));

String aboutUsModelToJson(AboutUsModel data) => json.encode(data.toJson());

class AboutUsModel {
  int? status;
  String? message;
  List<AboutUs>? data;

  AboutUsModel({
    this.status,
    this.message,
    this.data,
  });

  factory AboutUsModel.fromJson(Map<String, dynamic> json) => AboutUsModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<AboutUs>.from(json["data"]!.map((x) => AboutUs.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class AboutUs {
  String? title;
  String? description;

  AboutUs({
    this.title,
    this.description,
  });

  factory AboutUs.fromJson(Map<String, dynamic> json) => AboutUs(
        title: json["title"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
      };
}
