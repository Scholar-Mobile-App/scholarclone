import 'dart:convert';

TeachModel teachModelFromJson(String str) =>
    TeachModel.fromJson(json.decode(str));

String teachModelToJson(TeachModel data) => json.encode(data.toJson());

class TeachModel {
  int? status;
  String? message;
  List<Teach>? data;

  TeachModel({
    this.status,
    this.message,
    this.data,
  });

  factory TeachModel.fromJson(Map<String, dynamic> json) => TeachModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Teach>.from(json["data"]!.map((x) => Teach.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Teach {
  int? subId;
  String? subName;

  Teach({
    this.subId,
    this.subName,
  });

  factory Teach.fromJson(Map<String, dynamic> json) => Teach(
        subId: json["sub_id"],
        subName: json["sub_name"],
      );

  Map<String, dynamic> toJson() => {
        "sub_id": subId,
        "sub_name": subName,
      };
}
