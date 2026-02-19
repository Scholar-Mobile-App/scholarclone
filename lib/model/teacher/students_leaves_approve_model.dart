import 'dart:convert';

import 'package:flutter/material.dart';

StudentLeavesApproveModel studentLeavesApproveModelFromJson(String str) =>
    StudentLeavesApproveModel.fromJson(json.decode(str));

String studentLeavesApproveModelToJson(StudentLeavesApproveModel data) =>
    json.encode(data.toJson());

class StudentLeavesApproveModel {
  int? status;
  String? message;
  List<StudentLeaves>? data;

  StudentLeavesApproveModel({
    this.status,
    this.message,
    this.data,
  });

  factory StudentLeavesApproveModel.fromJson(Map<String, dynamic> json) =>
      StudentLeavesApproveModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<StudentLeaves>.from(
                json["data"]!.map((x) => StudentLeaves.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class StudentLeaves {
  int? leaveAppId;
  String? studentName;
  String? studentImage;
  String? stdName;
  String? title;
  String? message;
  String? fileName;
  DateTime? applyDate;
  TextEditingController? reply;
  DateTime? replyOn;
  String? replyBy;
  String? status;

  StudentLeaves({
    this.leaveAppId,
    this.studentName,
    this.studentImage,
    this.stdName,
    this.title,
    this.message,
    this.fileName,
    this.applyDate,
    this.reply,
    this.replyOn,
    this.replyBy,
    this.status,
  });

  factory StudentLeaves.fromJson(Map<String, dynamic> json) => StudentLeaves(
        leaveAppId: json["leave_app_id"],
        studentName: json["student_name"],
        studentImage: json["student_image"],
        stdName: json["std_name"],
        title: json["title"],
        message: json["message"],
        fileName: json["file_name"],
        applyDate: json["apply_date"] == null
            ? null
            : DateTime.parse(json["apply_date"]),
        reply: TextEditingController(text: json["reply"]),
        replyOn:
            json["reply_on"] == null ? null : DateTime.parse(json["reply_on"]),
        replyBy: json["reply_by"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "leave_app_id": leaveAppId,
        "student_name": studentName,
        "student_image": studentImage,
        "std_name": stdName,
        "title": title,
        "message": message,
        "file_name": fileName,
        "apply_date":
            "${applyDate!.year.toString().padLeft(4, '0')}-${applyDate!.month.toString().padLeft(2, '0')}-${applyDate!.day.toString().padLeft(2, '0')}",
        "reply": reply!.text,
        "reply_on": replyOn?.toIso8601String(),
        "reply_by": replyBy,
        "status": status,
      };
}
