// To parse this JSON data, do
//
//     final lmsSubjectLearnModel = lmsSubjectLearnModelFromJson(jsonString);

import 'dart:convert';

LmsSubjectLearnModel lmsSubjectLearnModelFromJson(String str) =>
    LmsSubjectLearnModel.fromJson(json.decode(str));

String lmsSubjectLearnModelToJson(LmsSubjectLearnModel data) =>
    json.encode(data.toJson());

class LmsSubjectLearnModel {
  int? status;
  String? message;
  Map<String, LmsSubjects>? data;

  LmsSubjectLearnModel({
    this.status,
    this.message,
    this.data,
  });

  factory LmsSubjectLearnModel.fromJson(Map<String, dynamic> json) =>
      LmsSubjectLearnModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? {}
            : Map.from(json["data"]).map((k, v) =>
                MapEntry<String, LmsSubjects>(k, LmsSubjects.fromJson(v))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": Map.from(data!)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
      };
}

class LmsSubjects {
  int? chapterId;
  int? syear;
  int? standardId;
  int? subjectId;
  String? chapterName;
  String? chapterDesc;
  int? availability;
  int? showHide;
  int? sortOrder;
  List<TopicLmsSubject>? topicData;

  LmsSubjects({
    this.chapterId,
    this.syear,
    this.standardId,
    this.subjectId,
    this.chapterName,
    this.chapterDesc,
    this.availability,
    this.showHide,
    this.sortOrder,
    this.topicData,
  });

  factory LmsSubjects.fromJson(Map<String, dynamic> json) => LmsSubjects(
        chapterId: json["chapter_id"],
        syear: json["syear"],
        standardId: json["standard_id"],
        subjectId: json["subject_id"],
        chapterName: json["chapter_name"],
        chapterDesc: json["chapter_desc"],
        availability: json["availability"],
        showHide: json["show_hide"],
        sortOrder: json["sort_order"],
        topicData: json["topicData"] == null
            ? []
            : List<TopicLmsSubject>.from(
                json["topicData"]!.map((x) => TopicLmsSubject.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "chapter_id": chapterId,
        "syear": syear,
        "standard_id": standardId,
        "subject_id": subjectId,
        "chapter_name": chapterName,
        "chapter_desc": chapterDesc,
        "availability": availability,
        "show_hide": showHide,
        "sort_order": sortOrder,
        "topicData": topicData == null
            ? []
            : List<dynamic>.from(topicData!.map((x) => x.toJson())),
      };
}

class TopicLmsSubject {
  int? id;
  int? subInstituteId;
  int? chapterId;
  int? mainTopicId;
  String? name;
  String? description;
  int? topicShowHide;
  int? topicSortOrder;
  int? syear;
  DateTime? createdAt;
  int? createdBy;
  List<dynamic>? contentData;

  TopicLmsSubject({
    this.id,
    this.subInstituteId,
    this.chapterId,
    this.mainTopicId,
    this.name,
    this.description,
    this.topicShowHide,
    this.topicSortOrder,
    this.syear,
    this.createdAt,
    this.createdBy,
    this.contentData,
  });

  factory TopicLmsSubject.fromJson(Map<String, dynamic> json) =>
      TopicLmsSubject(
        id: json["id"],
        subInstituteId: json["sub_institute_id"],
        chapterId: json["chapter_id"],
        mainTopicId: json["main_topic_id"],
        name: json["name"],
        description: json["description"],
        topicShowHide: json["topic_show_hide"],
        topicSortOrder: json["topic_sort_order"],
        syear: json["syear"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        createdBy: json["created_by"],
        contentData: json["contentData"] == null
            ? []
            : List<dynamic>.from(json["contentData"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sub_institute_id": subInstituteId,
        "chapter_id": chapterId,
        "main_topic_id": mainTopicId,
        "name": name,
        "description": description,
        "topic_show_hide": topicShowHide,
        "topic_sort_order": topicSortOrder,
        "syear": syear,
        "created_at": createdAt?.toIso8601String(),
        "created_by": createdBy,
        "contentData": contentData == null
            ? []
            : List<dynamic>.from(contentData!.map((x) => x)),
      };
}
