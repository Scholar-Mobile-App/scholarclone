import 'dart:convert';

SectionModel sectionModelFromJson(String str) =>
    SectionModel.fromJson(json.decode(str));

String sectionModelToJson(SectionModel data) => json.encode(data.toJson());

class SectionModel {
  int? status;
  List<Section>? data;

  SectionModel({
    this.status,
    this.data,
  });

  factory SectionModel.fromJson(Map<String, dynamic> json) => SectionModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<Section>.from(json["data"]!.map((x) => Section.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Section {
  int? id;
  int? subInstituteId;
  String? title;
  String? shortName;
  int? sortOrder;
  String? shift;
  String? medium;
  String? paymentLink;
  DateTime? createdAt;
  DateTime? updatedAt;

  Section({
    this.id,
    this.subInstituteId,
    this.title,
    this.shortName,
    this.sortOrder,
    this.shift,
    this.medium,
    this.paymentLink,
    this.createdAt,
    this.updatedAt,
  });

  factory Section.fromJson(Map<String, dynamic> json) => Section(
        id: json["id"],
        subInstituteId: json["sub_institute_id"],
        title: json["title"],
        shortName: json["short_name"],
        sortOrder: json["sort_order"],
        shift: json["shift"],
        medium: json["medium"],
        paymentLink: json["payment_link"],
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
        "title": title,
        "short_name": shortName,
        "sort_order": sortOrder,
        "shift": shift,
        "medium": medium,
        "payment_link": paymentLink,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

StandardModel standardModelFromJson(String str) =>
    StandardModel.fromJson(json.decode(str));

String standardModelToJson(StandardModel data) => json.encode(data.toJson());

class StandardModel {
  int? status;
  String? message;
  List<Standard>? data;

  StandardModel({
    this.status,
    this.message,
    this.data,
  });

  factory StandardModel.fromJson(Map<String, dynamic> json) => StandardModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Standard>.from(
                json["data"]!.map((x) => Standard.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Standard {
  int? stdId;
  String? stdName;
  int? gradeId;

  Standard({
    this.stdId,
    this.stdName,
    this.gradeId,
  });

  factory Standard.fromJson(Map<String, dynamic> json) => Standard(
        stdId: json["std_id"],
        stdName: json["std_name"],
        gradeId: json["grade_id"],
      );

  Map<String, dynamic> toJson() => {
        "std_id": stdId,
        "std_name": stdName,
        "grade_id": gradeId,
      };
}

DivisionModel divisionModelFromJson(String str) =>
    DivisionModel.fromJson(json.decode(str));

String divisionModelToJson(DivisionModel data) => json.encode(data.toJson());

class DivisionModel {
  int? status;
  String? message;
  List<Division>? data;

  DivisionModel({
    this.status,
    this.message,
    this.data,
  });

  factory DivisionModel.fromJson(Map<String, dynamic> json) => DivisionModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Division>.from(
                json["data"]!.map((x) => Division.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Division {
  int? divId;
  String? divName;

  Division({
    this.divId,
    this.divName,
  });

  factory Division.fromJson(Map<String, dynamic> json) => Division(
        divId: json["div_id"],
        divName: json["div_name"],
      );

  Map<String, dynamic> toJson() => {
        "div_id": divId,
        "div_name": divName,
      };
}

TeacherSubjectModel teacherSubjectModelFromJson(String str) =>
    TeacherSubjectModel.fromJson(json.decode(str));

String teacherSubjectModelToJson(TeacherSubjectModel data) =>
    json.encode(data.toJson());

class TeacherSubjectModel {
  int? status;
  String? message;
  List<TeacherSubject>? data;

  TeacherSubjectModel({
    this.status,
    this.message,
    this.data,
  });

  factory TeacherSubjectModel.fromJson(Map<String, dynamic> json) =>
      TeacherSubjectModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<TeacherSubject>.from(
                json["data"]!.map((x) => TeacherSubject.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class TeacherSubject {
  int? subId;
  String? subName;

  TeacherSubject({
    this.subId,
    this.subName,
  });

  factory TeacherSubject.fromJson(Map<String, dynamic> json) => TeacherSubject(
        subId: json["sub_id"],
        subName: json["sub_name"],
      );

  Map<String, dynamic> toJson() => {
        "sub_id": subId,
        "sub_name": subName,
      };
}
