import 'dart:convert';

LmsSubjectModel lmsSubjectModelFromJson(String str) =>
    LmsSubjectModel.fromJson(json.decode(str));

String lmsSubjectModelToJson(LmsSubjectModel data) =>
    json.encode(data.toJson());

class LmsSubjectModel {
  int? status;
  String? message;
  List<Subject>? data;

  LmsSubjectModel({
    this.status,
    this.message,
    this.data,
  });

  factory LmsSubjectModel.fromJson(Map<String, dynamic> json) =>
      LmsSubjectModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Subject>.from(json["data"]!.map((x) => Subject.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Subject {
  int? standardId;
  int? subjectId;
  String? displayName;
  String? allowGrades;
  String? allowContent;
  String? displayImage;
  int? sortOrder;
  String? electiveSubject;
  String? subjectCategory;
  int? status;

  Subject({
    this.standardId,
    this.subjectId,
    this.displayName,
    this.allowGrades,
    this.allowContent,
    this.displayImage,
    this.sortOrder,
    this.electiveSubject,
    this.subjectCategory,
    this.status,
  });

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        standardId: json["standard_id"],
        subjectId: json["subject_id"],
        displayName: json["display_name"],
        allowGrades: json["allow_grades"],
        allowContent: json["allow_content"],
        displayImage: json["display_image"],
        sortOrder: json["sort_order"],
        electiveSubject: json["elective_subject"],
        subjectCategory: json["subject_category"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "standard_id": standardId,
        "subject_id": subjectId,
        "display_name": displayName,
        "allow_grades": allowGrades,
        "allow_content": allowContent,
        "display_image": displayImage,
        "sort_order": sortOrder,
        "elective_subject": electiveSubject,
        "subject_category": subjectCategory,
        "status": status,
      };
}
