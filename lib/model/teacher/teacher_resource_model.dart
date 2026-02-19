import 'dart:convert';

TeacherResourceModel teacherResourceModelFromJson(String str) =>
    TeacherResourceModel.fromJson(json.decode(str));

String teacherResourceModelToJson(TeacherResourceModel data) =>
    json.encode(data.toJson());

class TeacherResourceModel {
  int? status;
  String? message;
  List<TeacherResource>? data;

  TeacherResourceModel({
    this.status,
    this.message,
    this.data,
  });

  factory TeacherResourceModel.fromJson(Map<String, dynamic> json) =>
      TeacherResourceModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<TeacherResource>.from(
                json["data"]!.map((x) => TeacherResource.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class TeacherResource {
  int? syear;
  int? subInstituteId;
  String? standardName;
  String? subjectName;
  String? chapterName;
  String? topicName;
  String? title;
  String? fileName;
  String? teacherName;

  TeacherResource({
    this.syear,
    this.subInstituteId,
    this.standardName,
    this.subjectName,
    this.chapterName,
    this.topicName,
    this.title,
    this.fileName,
    this.teacherName,
  });

  factory TeacherResource.fromJson(Map<String, dynamic> json) =>
      TeacherResource(
        syear: json["syear"],
        subInstituteId: json["sub_institute_id"],
        standardName: json["standard_name"],
        subjectName: json["subject_name"],
        chapterName: json["chapter_name"],
        topicName: json["topic_name"],
        title: json["title"],
        fileName: json["file_name"],
        teacherName: json["teacher_name"],
      );

  Map<String, dynamic> toJson() => {
        "syear": syear,
        "sub_institute_id": subInstituteId,
        "standard_name": standardName,
        "subject_name": subjectName,
        "chapter_name": chapterName,
        "topic_name": topicName,
        "title": title,
        "file_name": fileName,
        "teacher_name": teacherName,
      };
}
