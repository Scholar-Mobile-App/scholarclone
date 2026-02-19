import 'dart:convert';

TeacherTaskModel teacherTaskModelFromJson(String str) =>
    TeacherTaskModel.fromJson(json.decode(str));

String teacherTaskModelToJson(TeacherTaskModel data) =>
    json.encode(data.toJson());

class TeacherTaskModel {
  int? status;
  String? message;
  List<Task>? data;

  TeacherTaskModel({
    this.status,
    this.message,
    this.data,
  });

  factory TeacherTaskModel.fromJson(Map<String, dynamic> json) =>
      TeacherTaskModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Task>.from(json["data"]!.map((x) => Task.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Task {
  int? id;
  String? taskTitle;
  String? taskDescription;
  String? taskAttachment;
  dynamic fileSize;
  dynamic fileType;
  DateTime? taskDate;
  String? status;
  int? taskAllocated;
  int? taskAllocatedTo;
  DateTime? createdOn;
  int? createdBy;
  String? createdIpAddress;
  int? syear;
  dynamic markingPeriodId;
  int? subInstituteId;
  String? approvedBy;
  DateTime? approvedOn;
  dynamic reply;
  String? allocator;
  String? allocatedTo;

  Task({
    this.id,
    this.taskTitle,
    this.taskDescription,
    this.taskAttachment,
    this.fileSize,
    this.fileType,
    this.taskDate,
    this.status,
    this.taskAllocated,
    this.taskAllocatedTo,
    this.createdOn,
    this.createdBy,
    this.createdIpAddress,
    this.syear,
    this.markingPeriodId,
    this.subInstituteId,
    this.approvedBy,
    this.approvedOn,
    this.reply,
    this.allocator,
    this.allocatedTo,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json["ID"],
        taskTitle: json["TASK_TITLE"],
        taskDescription: json["TASK_DESCRIPTION"],
        taskAttachment: json["TASK_ATTACHMENT"],
        fileSize: json["FILE_SIZE"],
        fileType: json["FILE_TYPE"],
        taskDate: json["TASK_DATE"] == null
            ? null
            : DateTime.parse(json["TASK_DATE"]),
        status: json["STATUS"],
        taskAllocated: json["TASK_ALLOCATED"],
        taskAllocatedTo: json["TASK_ALLOCATED_TO"],
        createdOn: json["CREATED_ON"] == null
            ? null
            : DateTime.parse(json["CREATED_ON"]),
        createdBy: json["CREATED_BY"],
        createdIpAddress: json["CREATED_IP_ADDRESS"],
        syear: json["SYEAR"],
        markingPeriodId: json["MARKING_PERIOD_ID"],
        subInstituteId: json["sub_institute_id"],
        approvedBy: json["approved_by"],
        approvedOn: json["approved_on"] == null
            ? null
            : DateTime.parse(json["approved_on"]),
        reply: json["reply"],
        allocator: json["ALLOCATOR"],
        allocatedTo: json["ALLOCATED_TO"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "TASK_TITLE": taskTitle,
        "TASK_DESCRIPTION": taskDescription,
        "TASK_ATTACHMENT": taskAttachment,
        "FILE_SIZE": fileSize,
        "FILE_TYPE": fileType,
        "TASK_DATE":
            "${taskDate!.year.toString().padLeft(4, '0')}-${taskDate!.month.toString().padLeft(2, '0')}-${taskDate!.day.toString().padLeft(2, '0')}",
        "STATUS": status,
        "TASK_ALLOCATED": taskAllocated,
        "TASK_ALLOCATED_TO": taskAllocatedTo,
        "CREATED_ON": createdOn?.toIso8601String(),
        "CREATED_BY": createdBy,
        "CREATED_IP_ADDRESS": createdIpAddress,
        "SYEAR": syear,
        "MARKING_PERIOD_ID": markingPeriodId,
        "sub_institute_id": subInstituteId,
        "approved_by": approvedBy,
        "approved_on": approvedOn?.toIso8601String(),
        "reply": reply,
        "ALLOCATOR": allocator,
        "ALLOCATED_TO": allocatedTo,
      };
}
