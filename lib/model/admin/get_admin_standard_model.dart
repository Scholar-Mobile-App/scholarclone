import 'dart:convert';

GetAdminStandardModel getAdminStandardModelFromJson(String str) =>
    GetAdminStandardModel.fromJson(json.decode(str));

String getAdminStandardModelToJson(GetAdminStandardModel data) =>
    json.encode(data.toJson());

class GetAdminStandardModel {
  int? status;
  List<AdminStandard>? data;

  GetAdminStandardModel({
    this.status,
    this.data,
  });

  factory GetAdminStandardModel.fromJson(Map<String, dynamic> json) =>
      GetAdminStandardModel(
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

GetAdminDivisionModel getAdminDivisionModelFromJson(String str) =>
    GetAdminDivisionModel.fromJson(json.decode(str));

String getAdminDivisionModelToJson(GetAdminDivisionModel data) =>
    json.encode(data.toJson());

class GetAdminDivisionModel {
  int? status;
  List<AdminDivision>? data;

  GetAdminDivisionModel({
    this.status,
    this.data,
  });

  factory GetAdminDivisionModel.fromJson(Map<String, dynamic> json) =>
      GetAdminDivisionModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<AdminDivision>.from(
                json["data"]!.map((x) => AdminDivision.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class AdminDivision {
  int? id;
  String? name;

  AdminDivision({
    this.id,
    this.name,
  });

  factory AdminDivision.fromJson(Map<String, dynamic> json) => AdminDivision(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

GetAdminSubjectModel getAdminSubjectModelFromJson(String str) =>
    GetAdminSubjectModel.fromJson(json.decode(str));

String getAdminSubjectModelToJson(GetAdminSubjectModel data) =>
    json.encode(data.toJson());

class GetAdminSubjectModel {
  int? status;
  List<AdminSubject>? data;

  GetAdminSubjectModel({
    this.status,
    this.data,
  });

  factory GetAdminSubjectModel.fromJson(Map<String, dynamic> json) =>
      GetAdminSubjectModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<AdminSubject>.from(
                json["data"]!.map((x) => AdminSubject.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class AdminSubject {
  int? subjectId;
  String? subjectName;
  int? standardId;
  String? standardName;
  String? subjectImage;
  String? subjectCategory;

  AdminSubject({
    this.subjectId,
    this.subjectName,
    this.standardId,
    this.standardName,
    this.subjectImage,
    this.subjectCategory,
  });

  factory AdminSubject.fromJson(Map<String, dynamic> json) => AdminSubject(
        subjectId: json["subject_id"],
        subjectName: json["subject_name"],
        standardId: json["standard_id"],
        standardName: json["standard_name"],
        subjectImage: json["subject_image"],
        subjectCategory: json["subject_category"],
      );

  Map<String, dynamic> toJson() => {
        "subject_id": subjectId,
        "subject_name": subjectName,
        "standard_id": standardId,
        "standard_name": standardName,
        "subject_image": subjectImage,
        "subject_category": subjectCategory,
      };
}
