import 'dart:convert';

ExamModel examModelFromJson(String str) => ExamModel.fromJson(json.decode(str));

String examModelToJson(ExamModel data) => json.encode(data.toJson());

class ExamModel {
  int? status;
  String? message;
  List<Exam>? data;

  ExamModel({
    this.status,
    this.message,
    this.data,
  });

  factory ExamModel.fromJson(Map<String, dynamic> json) => ExamModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Exam>.from(json["data"]!.map((x) => Exam.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Exam {
  int? id;
  int? syear;
  int? subInstituteId;
  int? termId;
  String? medium;
  int? examId;
  int? standardId;
  String? appDispStatus;
  int? subjectId;
  String? title;
  int? points;
  int? conPoint;
  String? marksType;
  String? reportCardStatus;
  int? sortOrder;
  DateTime? examDate;
  DateTime? createdAt;
  DateTime? updatedAt;

  Exam({
    this.id,
    this.syear,
    this.subInstituteId,
    this.termId,
    this.medium,
    this.examId,
    this.standardId,
    this.appDispStatus,
    this.subjectId,
    this.title,
    this.points,
    this.conPoint,
    this.marksType,
    this.reportCardStatus,
    this.sortOrder,
    this.examDate,
    this.createdAt,
    this.updatedAt,
  });

  factory Exam.fromJson(Map<String, dynamic> json) => Exam(
        id: json["id"],
        syear: json["syear"],
        subInstituteId: json["sub_institute_id"],
        termId: json["term_id"],
        medium: json["medium"],
        examId: json["exam_id"],
        standardId: json["standard_id"],
        appDispStatus: json["app_disp_status"],
        subjectId: json["subject_id"],
        title: json["title"],
        points: json["points"],
        conPoint: json["con_point"],
        marksType: json["marks_type"],
        reportCardStatus: json["report_card_status"],
        sortOrder: json["sort_order"],
        examDate: json["exam_date"] == null
            ? null
            : DateTime.parse(json["exam_date"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "syear": syear,
        "sub_institute_id": subInstituteId,
        "term_id": termId,
        "medium": medium,
        "exam_id": examId,
        "standard_id": standardId,
        "app_disp_status": appDispStatus,
        "subject_id": subjectId,
        "title": title,
        "points": points,
        "con_point": conPoint,
        "marks_type": marksType,
        "report_card_status": reportCardStatus,
        "sort_order": sortOrder,
        "exam_date":
            "${examDate!.year.toString().padLeft(4, '0')}-${examDate!.month.toString().padLeft(2, '0')}-${examDate!.day.toString().padLeft(2, '0')}",
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
