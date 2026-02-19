import 'dart:convert';

LeaveModel leaveModelFromJson(String str) =>
    LeaveModel.fromJson(json.decode(str));

String leaveModelToJson(LeaveModel data) => json.encode(data.toJson());

class LeaveModel {
  int? status;
  String? message;
  List<Leave>? data;

  LeaveModel({
    this.status,
    this.message,
    this.data,
  });

  factory LeaveModel.fromJson(Map<String, dynamic> json) => LeaveModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Leave>.from(json["data"]!.map((x) => Leave.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Leave {
  String? title;
  String? message;
  String? files;
  DateTime? applyDate;
  DateTime? fromDate;
  DateTime? toDate;
  String? status;
  String? reply;
  DateTime? replyOn;

  Leave({
    this.title,
    this.message,
    this.files,
    this.applyDate,
    this.fromDate,
    this.toDate,
    this.status,
    this.reply,
    this.replyOn,
  });

  factory Leave.fromJson(Map<String, dynamic> json) => Leave(
        title: json["title"] ?? "",
        message: json["message"] ?? "",
        files: json["files"],
        applyDate: json["apply_date"] == null
            ? null
            : DateTime.parse(json["apply_date"]),
        fromDate: json["from_date"] == null
            ? null
            : DateTime.parse(json["from_date"]),
        toDate:
            json["to_date"] == null ? null : DateTime.parse(json["to_date"]),
        status: json["status"] ?? "",
        reply: json["reply"] ?? "",
        replyOn:
            json["reply_on"] == null ? null : DateTime.parse(json["reply_on"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "message": message,
        "files": files,
        "apply_date": applyDate?.toIso8601String(),
        "from_date": fromDate?.toIso8601String(),
        "to_date": toDate?.toIso8601String(),
        "status": status,
        "reply": reply,
        "reply_on": replyOn?.toIso8601String(),
      };
}
