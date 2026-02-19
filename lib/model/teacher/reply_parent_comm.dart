import 'dart:convert';

import 'package:flutter/material.dart';

ReplyParentComModel replyParentComModelFromJson(String str) =>
    ReplyParentComModel.fromJson(json.decode(str));

String replyParentComModelToJson(ReplyParentComModel data) =>
    json.encode(data.toJson());

class ReplyParentComModel {
  int? status;
  String? message;
  List<ReplyParent>? data;

  ReplyParentComModel({
    this.status,
    this.message,
    this.data,
  });

  factory ReplyParentComModel.fromJson(Map<String, dynamic> json) =>
      ReplyParentComModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<ReplyParent>.from(
                json["data"]!.map((x) => ReplyParent.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ReplyParent {
  int? parentCommId;
  String? studentName;
  String? studentImage;
  String? enrollmentNo;
  String? mobile;
  int? standardId;
  int? divisionId;
  String? email;
  String? standardName;
  String? divisionName;
  String? message;
  String? parentCommDate;
  TextEditingController? reply;
  String? replyBy;
  DateTime? replyOn;

  ReplyParent({
    this.parentCommId,
    this.studentName,
    this.studentImage,
    this.enrollmentNo,
    this.mobile,
    this.standardId,
    this.divisionId,
    this.email,
    this.standardName,
    this.divisionName,
    this.message,
    this.parentCommDate,
    this.reply,
    this.replyBy,
    this.replyOn,
  });

  factory ReplyParent.fromJson(Map<String, dynamic> json) => ReplyParent(
        parentCommId: json["parent_comm_id"],
        studentName: json["student_name"],
        studentImage: json["student_image"],
        enrollmentNo: json["enrollment_no"],
        mobile: json["mobile"],
        standardId: json["standard_id"],
        divisionId: json["division_id"],
        email: json["email"],
        standardName: json["standard_name"],
        divisionName: json["division_name"],
        message: json["message"],
        parentCommDate: json["parent_comm_date"],
        reply: TextEditingController(text: json["reply"]),
        replyBy: json["reply_by"],
        replyOn:
            json["reply_on"] == null ? null : DateTime.parse(json["reply_on"]),
      );

  Map<String, dynamic> toJson() => {
        "parent_comm_id": parentCommId,
        "student_name": studentName,
        "student_image": studentImage,
        "enrollment_no": enrollmentNo,
        "mobile": mobile,
        "standard_id": standardId,
        "division_id": divisionId,
        "email": email,
        "standard_name": standardName,
        "division_name": divisionName,
        "message": message,
        "parent_comm_date": parentCommDate,
        "reply": reply!.text,
        "reply_by": replyBy,
        "reply_on": replyOn?.toIso8601String(),
      };
}
