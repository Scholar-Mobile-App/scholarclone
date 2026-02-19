import 'dart:convert';

TeacherComplainModel teacherComplainModelFromJson(String str) =>
    TeacherComplainModel.fromJson(json.decode(str));

String teacherComplainModelToJson(TeacherComplainModel data) =>
    json.encode(data.toJson());

class TeacherComplainModel {
  int? status;
  String? message;
  List<Complain>? data;

  TeacherComplainModel({
    this.status,
    this.message,
    this.data,
  });

  factory TeacherComplainModel.fromJson(Map<String, dynamic> json) =>
      TeacherComplainModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Complain>.from(
                json["data"]!.map((x) => Complain.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Complain {
  int? id;
  int? subInstituteId;
  DateTime? date;
  String? title;
  String? description;
  String? attachement;
  dynamic fileSize;
  dynamic fileType;
  String? complaintBy;
  String? complaintSolution;
  String? complaintSolutionBy;
  dynamic complaintSolutionUserGroupId;
  DateTime? createdDate;
  String? createdIp;
  dynamic updatedOn;
  int? syear;
  dynamic markingPeriodId;
  String? complaintAttachment;

  Complain({
    this.id,
    this.subInstituteId,
    this.date,
    this.title,
    this.description,
    this.attachement,
    this.fileSize,
    this.fileType,
    this.complaintBy,
    this.complaintSolution,
    this.complaintSolutionBy,
    this.complaintSolutionUserGroupId,
    this.createdDate,
    this.createdIp,
    this.updatedOn,
    this.syear,
    this.markingPeriodId,
    this.complaintAttachment,
  });

  factory Complain.fromJson(Map<String, dynamic> json) => Complain(
        id: json["ID"],
        subInstituteId: json["SUB_INSTITUTE_ID"],
        date: json["DATE"] == null ? null : DateTime.parse(json["DATE"]),
        title: json["TITLE"],
        description: json["DESCRIPTION"],
        attachement: json["ATTACHEMENT"],
        fileSize: json["FILE_SIZE"],
        fileType: json["FILE_TYPE"],
        complaintBy: json["COMPLAINT_BY"],
        complaintSolution: json["COMPLAINT_SOLUTION"],
        complaintSolutionBy: json["COMPLAINT_SOLUTION_BY"],
        complaintSolutionUserGroupId: json["COMPLAINT_SOLUTION_USER_GROUP_ID"],
        createdDate: json["CREATED_DATE"] == null
            ? null
            : DateTime.parse(json["CREATED_DATE"]),
        createdIp: json["CREATED_IP"],
        updatedOn: json["UPDATED_ON"],
        syear: json["SYEAR"],
        markingPeriodId: json["MARKING_PERIOD_ID"],
        complaintAttachment: json["COMPLAINT_ATTACHMENT"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "SUB_INSTITUTE_ID": subInstituteId,
        "DATE": date?.toIso8601String(),
        "TITLE": title,
        "DESCRIPTION": description,
        "ATTACHEMENT": attachement,
        "FILE_SIZE": fileSize,
        "FILE_TYPE": fileType,
        "COMPLAINT_BY": complaintBy,
        "COMPLAINT_SOLUTION": complaintSolution,
        "COMPLAINT_SOLUTION_BY": complaintSolutionBy,
        "COMPLAINT_SOLUTION_USER_GROUP_ID": complaintSolutionUserGroupId,
        "CREATED_DATE": createdDate?.toIso8601String(),
        "CREATED_IP": createdIp,
        "UPDATED_ON": updatedOn,
        "SYEAR": syear,
        "MARKING_PERIOD_ID": markingPeriodId,
        "COMPLAINT_ATTACHMENT": complaintAttachment,
      };
}
