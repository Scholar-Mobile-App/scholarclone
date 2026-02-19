import 'dart:convert';

List<MyLeaveHistoryModel> myLeaveHistoryModelFromJson(String str) =>
    List<MyLeaveHistoryModel>.from(
        json.decode(str).map((x) => MyLeaveHistoryModel.fromJson(x)));

String myLeaveHistoryModelToJson(List<MyLeaveHistoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MyLeaveHistoryModel {
  int? id;
  int? subInstituteId;
  int? departmentId;
  int? userId;
  int? leaveTypeId;
  String? dayType;
  String? slot;
  DateTime? fromDate;
  DateTime? toDate;
  String? comment;
  String? hodComment;
  DateTime? hodCommentDate;
  String? hrRemarks;
  DateTime? hrRemarkDate;
  String? approvedBy;
  String? status;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  MyLeaveHistoryModel({
    this.id,
    this.subInstituteId,
    this.departmentId,
    this.userId,
    this.leaveTypeId,
    this.dayType,
    this.slot,
    this.fromDate,
    this.toDate,
    this.comment,
    this.hodComment,
    this.hodCommentDate,
    this.hrRemarks,
    this.hrRemarkDate,
    this.approvedBy,
    this.status,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory MyLeaveHistoryModel.fromJson(Map<String, dynamic> json) =>
      MyLeaveHistoryModel(
        id: json["id"],
        subInstituteId: json["sub_institute_id"],
        departmentId: json["department_id"],
        userId: json["user_id"],
        leaveTypeId: json["leave_type_id"],
        dayType: json["day_type"],
        slot: json["slot"],
        fromDate: json["from_date"] == null
            ? null
            : DateTime.parse(json["from_date"]),
        toDate:
            json["to_date"] == null ? null : DateTime.parse(json["to_date"]),
        comment: json["comment"],
        hodComment: json["hod_comment"],
        hodCommentDate: json["hod_comment_date"] == null
            ? null
            : DateTime.parse(json["hod_comment_date"]),
        hrRemarks: json["hr_remarks"],
        hrRemarkDate: json["hr_remark_date"] == null
            ? null
            : DateTime.parse(json["hr_remark_date"]),
        approvedBy: json["approved_by"],
        status: json["status"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sub_institute_id": subInstituteId,
        "department_id": departmentId,
        "user_id": userId,
        "leave_type_id": leaveTypeId,
        "day_type": dayType,
        "slot": slot,
        "from_date":
            "${fromDate!.year.toString().padLeft(4, '0')}-${fromDate!.month.toString().padLeft(2, '0')}-${fromDate!.day.toString().padLeft(2, '0')}",
        "to_date":
            "${toDate!.year.toString().padLeft(4, '0')}-${toDate!.month.toString().padLeft(2, '0')}-${toDate!.day.toString().padLeft(2, '0')}",
        "comment": comment,
        "hod_comment": hodComment,
        "hod_comment_date":
            "${hodCommentDate!.year.toString().padLeft(4, '0')}-${hodCommentDate!.month.toString().padLeft(2, '0')}-${hodCommentDate!.day.toString().padLeft(2, '0')}",
        "hr_remarks": hrRemarks,
        "hr_remark_date":
            "${hrRemarkDate!.year.toString().padLeft(4, '0')}-${hrRemarkDate!.month.toString().padLeft(2, '0')}-${hrRemarkDate!.day.toString().padLeft(2, '0')}",
        "approved_by": approvedBy,
        "status": status,
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
