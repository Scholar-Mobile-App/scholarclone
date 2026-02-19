import 'dart:convert';

LeaveAuthorizationModel leaveAuthorizationModelFromJson(String str) =>
    LeaveAuthorizationModel.fromJson(json.decode(str));

String leaveAuthorizationModelToJson(LeaveAuthorizationModel data) =>
    json.encode(data.toJson());

class LeaveAuthorizationModel {
  List<GetEmployeeLeaveList>? getEmployeeLeaveLists;
  DateTime? fromDateFormatted;
  DateTime? toDateFormatted;
  String? getLeaveStatus;

  LeaveAuthorizationModel({
    this.getEmployeeLeaveLists,
    this.fromDateFormatted,
    this.toDateFormatted,
    this.getLeaveStatus,
  });

  factory LeaveAuthorizationModel.fromJson(Map<String, dynamic> json) =>
      LeaveAuthorizationModel(
        getEmployeeLeaveLists: json["get_employee_leave_lists"] == null
            ? []
            : List<GetEmployeeLeaveList>.from(json["get_employee_leave_lists"]!
                .map((x) => GetEmployeeLeaveList.fromJson(x))),
        fromDateFormatted: json["from_date_formatted"] == null
            ? null
            : DateTime.parse(json["from_date_formatted"]),
        toDateFormatted: json["to_date_formatted"] == null
            ? null
            : DateTime.parse(json["to_date_formatted"]),
        getLeaveStatus: json["get_leave_status"],
      );

  Map<String, dynamic> toJson() => {
        "get_employee_leave_lists": getEmployeeLeaveLists == null
            ? []
            : List<dynamic>.from(getEmployeeLeaveLists!.map((x) => x.toJson())),
        "from_date_formatted":
            "${fromDateFormatted!.year.toString().padLeft(4, '0')}-${fromDateFormatted!.month.toString().padLeft(2, '0')}-${fromDateFormatted!.day.toString().padLeft(2, '0')}",
        "to_date_formatted":
            "${toDateFormatted!.year.toString().padLeft(4, '0')}-${toDateFormatted!.month.toString().padLeft(2, '0')}-${toDateFormatted!.day.toString().padLeft(2, '0')}",
        "get_leave_status": getLeaveStatus,
      };
}

class GetEmployeeLeaveList {
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
  dynamic hodComment;
  dynamic hodCommentDate;
  dynamic hrRemarks;
  dynamic hrRemarkDate;
  dynamic approvedBy;
  String? status;
  dynamic deletedAt;
  DateTime? createdAt;
  dynamic updatedAt;
  String? employeeName;
  String? leaveType;

  GetEmployeeLeaveList({
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
    this.employeeName,
    this.leaveType,
  });

  factory GetEmployeeLeaveList.fromJson(Map<String, dynamic> json) =>
      GetEmployeeLeaveList(
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
        hodCommentDate: json["hod_comment_date"],
        hrRemarks: json["hr_remarks"],
        hrRemarkDate: json["hr_remark_date"],
        approvedBy: json["approved_by"],
        status: json["status"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
        employeeName: json["employee_name"],
        leaveType: json["leave_type"],
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
        "hod_comment_date": hodCommentDate,
        "hr_remarks": hrRemarks,
        "hr_remark_date": hrRemarkDate,
        "approved_by": approvedBy,
        "status": status,
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt,
        "employee_name": employeeName,
        "leave_type": leaveType,
      };
}
