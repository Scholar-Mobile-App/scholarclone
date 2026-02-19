import 'dart:convert';

List<AttendancesModel> attendancesModelFromJson(String str) =>
    List<AttendancesModel>.from(
        json.decode(str).map((x) => AttendancesModel.fromJson(x)));

String attendancesModelToJson(List<AttendancesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AttendancesModel {
  int? id;
  int? userId;
  dynamic employeeNo;
  DateTime? day;
  DateTime? punchinTime;
  DateTime? punchoutTime;
  int? inNote;
  int? outNote;
  String? timestampDiff;
  int? status;
  String? ipaddressIn;
  String? ipaddressOut;
  dynamic photoIn;
  dynamic photoOut;
  dynamic attendanceLogId;
  int? clientId;
  int? subInstituteId;
  DateTime? createdAt;
  DateTime? updatedAt;

  AttendancesModel({
    this.id,
    this.userId,
    this.employeeNo,
    this.day,
    this.punchinTime,
    this.punchoutTime,
    this.inNote,
    this.outNote,
    this.timestampDiff,
    this.status,
    this.ipaddressIn,
    this.ipaddressOut,
    this.photoIn,
    this.photoOut,
    this.attendanceLogId,
    this.clientId,
    this.subInstituteId,
    this.createdAt,
    this.updatedAt,
  });

  factory AttendancesModel.fromJson(Map<String, dynamic> json) =>
      AttendancesModel(
        id: json["id"],
        userId: json["user_id"],
        employeeNo: json["employee_no"],
        day: json["day"] == null ? null : DateTime.parse(json["day"]),
        punchinTime: json["punchin_time"] == null
            ? null
            : DateTime.parse(json["punchin_time"]),
        punchoutTime: json["punchout_time"] == null
            ? null
            : DateTime.parse(json["punchout_time"]),
        inNote: json["in_note"],
        outNote: json["out_note"],
        timestampDiff: json["timestamp_diff"],
        status: json["status"],
        ipaddressIn: json["ipaddress_in"],
        ipaddressOut: json["ipaddress_out"],
        photoIn: json["photo_in"],
        photoOut: json["photo_out"],
        attendanceLogId: json["attendance_log_id"],
        clientId: json["client_id"],
        subInstituteId: json["sub_institute_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "employee_no": employeeNo,
        "day":
            "${day!.year.toString().padLeft(4, '0')}-${day!.month.toString().padLeft(2, '0')}-${day!.day.toString().padLeft(2, '0')}",
        "punchin_time": punchinTime?.toIso8601String(),
        "punchout_time": punchoutTime?.toIso8601String(),
        "in_note": inNote,
        "out_note": outNote,
        "timestamp_diff": timestampDiff,
        "status": status,
        "ipaddress_in": ipaddressIn,
        "ipaddress_out": ipaddressOut,
        "photo_in": photoIn,
        "photo_out": photoOut,
        "attendance_log_id": attendanceLogId,
        "client_id": clientId,
        "sub_institute_id": subInstituteId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
