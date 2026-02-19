import 'dart:convert';

TeacherFetchDataModel teacherFetchDataModelFromJson(String str) =>
    TeacherFetchDataModel.fromJson(json.decode(str));

String teacherFetchDataModelToJson(TeacherFetchDataModel data) =>
    json.encode(data.toJson());

class TeacherFetchDataModel {
  String? status;
  String? message;
  List<TeacherFetchData>? data;

  TeacherFetchDataModel({
    this.status,
    this.message,
    this.data,
  });

  factory TeacherFetchDataModel.fromJson(Map<String, dynamic> json) =>
      TeacherFetchDataModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<TeacherFetchData>.from(
                json["data"]!.map((x) => TeacherFetchData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class TeacherFetchData {
  int? id;
  int? syear;
  DateTime? schoolDate;
  String? title;
  String? description;
  String? eventType;
  String? standard;
  int? subInstituteId;
  DateTime? createdAt;
  dynamic updatedAt;

  TeacherFetchData({
    this.id,
    this.syear,
    this.schoolDate,
    this.title,
    this.description,
    this.eventType,
    this.standard,
    this.subInstituteId,
    this.createdAt,
    this.updatedAt,
  });

  factory TeacherFetchData.fromJson(Map<String, dynamic> json) =>
      TeacherFetchData(
        id: json["id"],
        syear: json["syear"],
        schoolDate: json["school_date"] == null
            ? null
            : DateTime.parse(json["school_date"]),
        title: json["title"],
        description: json["description"],
        eventType: json["event_type"],
        standard: json["standard"],
        subInstituteId: json["sub_institute_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "syear": syear,
        "school_date":
            "${schoolDate!.year.toString().padLeft(4, '0')}-${schoolDate!.month.toString().padLeft(2, '0')}-${schoolDate!.day.toString().padLeft(2, '0')}",
        "title": title,
        "description": description,
        "event_type": eventType,
        "standard": standard,
        "sub_institute_id": subInstituteId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt,
      };
}
