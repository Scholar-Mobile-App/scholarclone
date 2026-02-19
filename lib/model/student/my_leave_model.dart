class MyLeaveModel {
  String? status;
  String? message;
  Data? data;

  MyLeaveModel({
    this.status,
    this.message,
    this.data,
  });

  factory MyLeaveModel.fromJson(Map<String, dynamic> json) => MyLeaveModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  LeaveSummary? leaveSummary;
  List<LeaveType>? leaveTypes;

  Data({
    this.leaveSummary,
    this.leaveTypes,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        leaveSummary: json["leave_summary"] == null
            ? null
            : LeaveSummary.fromJson(json["leave_summary"]),
        leaveTypes: json["leave_types"] == null
            ? []
            : List<LeaveType>.from(
                json["leave_types"]!.map((x) => LeaveType.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "leave_summary": leaveSummary?.toJson(),
        "leave_types": leaveTypes == null
            ? []
            : List<dynamic>.from(leaveTypes!.map((x) => x.toJson())),
      };
}

class LeaveSummary {
  String? totalLeaves;
  String? usedLeaves;
  String? remainingLeaves;

  LeaveSummary({
    this.totalLeaves,
    this.usedLeaves,
    this.remainingLeaves,
  });

  factory LeaveSummary.fromJson(Map<String, dynamic> json) => LeaveSummary(
        totalLeaves: json["total_leaves"],
        usedLeaves: json["used_leaves"],
        remainingLeaves: json["remaining_leaves"],
      );

  Map<String, dynamic> toJson() => {
        "total_leaves": totalLeaves,
        "used_leaves": usedLeaves,
        "remaining_leaves": remainingLeaves,
      };
}

class LeaveType {
  String? leaveType;
  String? used;
  String? total;

  LeaveType({
    this.leaveType,
    this.used,
    this.total,
  });

  factory LeaveType.fromJson(Map<String, dynamic> json) => LeaveType(
        leaveType: json["leave_type"],
        used: json["used"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "leave_type": leaveType,
        "used": used,
        "total": total,
      };
}
