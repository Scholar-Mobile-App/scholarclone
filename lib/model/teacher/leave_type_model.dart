import 'dart:convert';

List<LeaveTypeModel> leaveTypeModelFromJson(String str) =>
    List<LeaveTypeModel>.from(
        json.decode(str).map((x) => LeaveTypeModel.fromJson(x)));

String leaveTypeModelToJson(List<LeaveTypeModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LeaveTypeModel {
  int? id;
  String? leaveTypeId;
  String? leaveType;
  int? sortOrder;
  int? status;
  int? subInstituteId;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  LeaveTypeModel({
    this.id,
    this.leaveTypeId,
    this.leaveType,
    this.sortOrder,
    this.status,
    this.subInstituteId,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory LeaveTypeModel.fromJson(Map<String, dynamic> json) => LeaveTypeModel(
        id: json["id"],
        leaveTypeId: json["leave_type_id"],
        leaveType: json["leave_type"],
        sortOrder: json["sort_order"],
        status: json["status"],
        subInstituteId: json["sub_institute_id"],
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
        "leave_type_id": leaveTypeId,
        "leave_type": leaveType,
        "sort_order": sortOrder,
        "status": status,
        "sub_institute_id": subInstituteId,
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
