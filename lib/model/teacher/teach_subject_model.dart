import 'dart:convert';

TeachSubjectModel teachSubjectModelFromJson(String str) =>
    TeachSubjectModel.fromJson(json.decode(str));

String teachSubjectModelToJson(TeachSubjectModel data) =>
    json.encode(data.toJson());

class TeachSubjectModel {
  int? status;
  String? message;
  Map<String, TeachSubject>? data;

  TeachSubjectModel({
    this.status,
    this.message,
    this.data,
  });

  factory TeachSubjectModel.fromJson(Map<String, dynamic> json) =>
      TeachSubjectModel(
        status: json["status"],
        message: json["message"],
        data: Map.from(json["data"]!).map((k, v) =>
            MapEntry<String, TeachSubject>(k, TeachSubject.fromJson(v))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": Map.from(data!)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
      };
}

class TeachSubject {
  int? chapterId;
  int? syear;
  int? standardId;
  int? subjectId;
  String? chapterName;
  dynamic chapterDesc;
  int? availability;
  int? showHide;
  int? sortOrder;
  String? addContent;
  List<TopicDatum>? topicData;

  TeachSubject({
    this.chapterId,
    this.syear,
    this.standardId,
    this.subjectId,
    this.chapterName,
    this.chapterDesc,
    this.availability,
    this.showHide,
    this.sortOrder,
    this.addContent,
    this.topicData,
  });

  factory TeachSubject.fromJson(Map<String, dynamic> json) => TeachSubject(
        chapterId: json["chapter_id"],
        syear: json["syear"],
        standardId: json["standard_id"],
        subjectId: json["subject_id"],
        chapterName: json["chapter_name"],
        chapterDesc: json["chapter_desc"],
        availability: json["availability"],
        showHide: json["show_hide"],
        sortOrder: json["sort_order"],
        addContent: json["add_content"],
        topicData: json["topicData"] == null
            ? []
            : List<TopicDatum>.from(
                json["topicData"]!.map((x) => TopicDatum.fromJson(x))),
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
        "add_content": addContent,
        "topicData": topicData == null
            ? []
            : List<dynamic>.from(topicData!.map((x) => x.toJson())),
      };
}

class TopicDatum {
  int? subInstituteId;
  int? chapterId;
  String? name;
  int? syear;
  DateTime? createdAt;
  List<ContentDatum>? contentData;

  TopicDatum({
    this.subInstituteId,
    this.chapterId,
    this.name,
    this.syear,
    this.createdAt,
    this.contentData,
  });

  factory TopicDatum.fromJson(Map<String, dynamic> json) => TopicDatum(
        subInstituteId: json["sub_institute_id"],
        chapterId: json["chapter_id"],
        name: json["name"],
        syear: json["syear"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        contentData: json["contentData"] == null
            ? []
            : List<ContentDatum>.from(
                json["contentData"]!.map((x) => ContentDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "sub_institute_id": subInstituteId,
        "chapter_id": chapterId,
        "name": name,
        "syear": syear,
        "created_at": createdAt?.toIso8601String(),
        "contentData": contentData == null
            ? []
            : List<dynamic>.from(contentData!.map((x) => x.toJson())),
      };
}

class ContentDatum {
  int? id;
  int? gradeId;
  int? standardId;
  int? subjectId;
  int? chapterId;
  dynamic topicId;
  dynamic subTopicId;
  dynamic loMasterIds;
  dynamic loIndicatorIds;
  dynamic loCategoryId;
  String? title;
  dynamic description;
  String? fileFolder;
  String? filename;
  String? fileType;
  String? fileSize;
  String? url;
  dynamic sortOrder;
  int? showHide;
  String? metaTags;
  String? contentCategory;
  int? syear;
  int? subInstituteId;
  dynamic restrictDate;
  String? preGradeTopic;
  String? postGradeTopic;
  String? crossCurriculumGradeTopic;
  String? basicAdvance;
  DateTime? createdAt;
  int? createdBy;
  String? fullPath;

  ContentDatum({
    this.id,
    this.gradeId,
    this.standardId,
    this.subjectId,
    this.chapterId,
    this.topicId,
    this.subTopicId,
    this.loMasterIds,
    this.loIndicatorIds,
    this.loCategoryId,
    this.title,
    this.description,
    this.fileFolder,
    this.filename,
    this.fileType,
    this.fileSize,
    this.url,
    this.sortOrder,
    this.showHide,
    this.metaTags,
    this.contentCategory,
    this.syear,
    this.subInstituteId,
    this.restrictDate,
    this.preGradeTopic,
    this.postGradeTopic,
    this.crossCurriculumGradeTopic,
    this.basicAdvance,
    this.createdAt,
    this.createdBy,
    this.fullPath,
  });

  factory ContentDatum.fromJson(Map<String, dynamic> json) => ContentDatum(
        id: json["id"],
        gradeId: json["grade_id"],
        standardId: json["standard_id"],
        subjectId: json["subject_id"],
        chapterId: json["chapter_id"],
        topicId: json["topic_id"],
        subTopicId: json["sub_topic_id"],
        loMasterIds: json["lo_master_ids"],
        loIndicatorIds: json["lo_indicator_ids"],
        loCategoryId: json["lo_category_id"],
        title: json["title"],
        description: json["description"],
        fileFolder: json["file_folder"],
        filename: json["filename"],
        fileType: json["file_type"],
        fileSize: json["file_size"],
        url: json["url"],
        sortOrder: json["sort_order"],
        showHide: json["show_hide"],
        metaTags: json["meta_tags"],
        contentCategory: json["content_category"],
        syear: json["syear"],
        subInstituteId: json["sub_institute_id"],
        restrictDate: json["restrict_date"],
        preGradeTopic: json["pre_grade_topic"],
        postGradeTopic: json["post_grade_topic"],
        crossCurriculumGradeTopic: json["cross_curriculum_grade_topic"],
        basicAdvance: json["basic_advance"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        createdBy: json["created_by"],
        fullPath: json["full_path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "grade_id": gradeId,
        "standard_id": standardId,
        "subject_id": subjectId,
        "chapter_id": chapterId,
        "topic_id": topicId,
        "sub_topic_id": subTopicId,
        "lo_master_ids": loMasterIds,
        "lo_indicator_ids": loIndicatorIds,
        "lo_category_id": loCategoryId,
        "title": title,
        "description": description,
        "file_folder": fileFolder,
        "filename": filename,
        "file_type": fileType,
        "file_size": fileSize,
        "url": url,
        "sort_order": sortOrder,
        "show_hide": showHide,
        "meta_tags": metaTags,
        "content_category": contentCategory,
        "syear": syear,
        "sub_institute_id": subInstituteId,
        "restrict_date": restrictDate,
        "pre_grade_topic": preGradeTopic,
        "post_grade_topic": postGradeTopic,
        "cross_curriculum_grade_topic": crossCurriculumGradeTopic,
        "basic_advance": basicAdvance,
        "created_at": createdAt?.toIso8601String(),
        "created_by": createdBy,
        "full_path": fullPath,
      };
}
