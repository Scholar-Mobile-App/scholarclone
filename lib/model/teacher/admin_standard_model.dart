import 'dart:convert';

AdminStandardModel adminStandardModelFromJson(String str) =>
    AdminStandardModel.fromJson(json.decode(str));

String adminStandardModelToJson(AdminStandardModel data) =>
    json.encode(data.toJson());

class AdminStandardModel {
  int? status;
  List<AdminStandard>? data;

  AdminStandardModel({
    this.status,
    this.data,
  });

  factory AdminStandardModel.fromJson(Map<String, dynamic> json) =>
      AdminStandardModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<AdminStandard>.from(
                json["data"]!.map((x) => AdminStandard.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class AdminStandard {
  int? id;
  int? gradeId;
  String? name;
  String? shortName;
  int? sortOrder;
  String? medium;
  int? subInstituteId;
  String? courseDuration;
  dynamic nextGradeId;
  dynamic nextStandardId;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic schoolStream;
  dynamic markingPeriodId;

  AdminStandard({
    this.id,
    this.gradeId,
    this.name,
    this.shortName,
    this.sortOrder,
    this.medium,
    this.subInstituteId,
    this.courseDuration,
    this.nextGradeId,
    this.nextStandardId,
    this.createdAt,
    this.updatedAt,
    this.schoolStream,
    this.markingPeriodId,
  });

  factory AdminStandard.fromJson(Map<String, dynamic> json) => AdminStandard(
        id: json["id"],
        gradeId: json["grade_id"],
        name: json["name"],
        shortName: json["short_name"],
        sortOrder: json["sort_order"],
        medium: json["medium"],
        subInstituteId: json["sub_institute_id"],
        courseDuration: json["course_duration"],
        nextGradeId: json["next_grade_id"],
        nextStandardId: json["next_standard_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        schoolStream: json["school_stream"],
        markingPeriodId: json["marking_period_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "grade_id": gradeId,
        "name": name,
        "short_name": shortName,
        "sort_order": sortOrder,
        "medium": medium,
        "sub_institute_id": subInstituteId,
        "course_duration": courseDuration,
        "next_grade_id": nextGradeId,
        "next_standard_id": nextStandardId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "school_stream": schoolStream,
        "marking_period_id": markingPeriodId,
      };
}
