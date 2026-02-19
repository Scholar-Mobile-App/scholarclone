import 'dart:convert';

ParentCommunicationModel parentCommunicationModelFromJson(String str) =>
    ParentCommunicationModel.fromJson(json.decode(str));

String parentCommunicationModelToJson(ParentCommunicationModel data) =>
    json.encode(data.toJson());

class ParentCommunicationModel {
  int? statusCode;
  String? message;
  List<Communication>? data;

  ParentCommunicationModel({
    this.statusCode,
    this.message,
    this.data,
  });

  factory ParentCommunicationModel.fromJson(Map<String, dynamic> json) =>
      ParentCommunicationModel(
        statusCode: json["status_code"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Communication>.from(
                json["data"]!.map((x) => Communication.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Communication {
  String? title;
  String? message;
  DateTime? createdAt;
  String? reply;
  String? replyOn;
  String? replyBy;

  Communication({
    this.title,
    this.message,
    this.createdAt,
    this.reply,
    this.replyOn,
    this.replyBy,
  });

  factory Communication.fromJson(Map<String, dynamic> json) => Communication(
        title: json["title"],
        message: json["message"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        reply: json["reply"],
        replyOn: json["reply_on"],
        replyBy: json["reply_by"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "message": message,
        "created_at": createdAt?.toIso8601String(),
        "reply": reply,
        "reply_on": replyOn,
        "reply_by": replyBy,
      };
}
