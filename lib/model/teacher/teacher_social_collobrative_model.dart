import 'dart:convert';

TeacherSocialCollobrativeModel teacherSocialCollobrativeModelFromJson(
        String str) =>
    TeacherSocialCollobrativeModel.fromJson(json.decode(str));

String teacherSocialCollobrativeModelToJson(
        TeacherSocialCollobrativeModel data) =>
    json.encode(data.toJson());

class TeacherSocialCollobrativeModel {
  int? status;
  String? message;
  Map<String, SocialCollobrative>? data;

  TeacherSocialCollobrativeModel({
    this.status,
    this.message,
    this.data,
  });

  factory TeacherSocialCollobrativeModel.fromJson(Map<String, dynamic> json) =>
      TeacherSocialCollobrativeModel(
        status: json["status"],
        message: json["message"],
        data: Map.from(json["data"]!).map((k, v) =>
            MapEntry<String, SocialCollobrative>(
                k, SocialCollobrative.fromJson(v))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": Map.from(data!)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
      };
}

class SocialCollobrative {
  int? id;
  int? subjectId;
  int? chapterId;
  int? topicId;
  String? title;
  String? description;
  String? fileName;
  String? visibility;
  int? subInstituteId;
  int? syear;
  int? userId;
  int? userProfileId;
  DateTime? createdAt;
  String? studentName;
  String? image;
  int? totaldays;
  String? standardDivision;
  String? doubtDate;
  List<TeacherConversationData>? conversationData;

  SocialCollobrative({
    this.id,
    this.subjectId,
    this.chapterId,
    this.topicId,
    this.title,
    this.description,
    this.fileName,
    this.visibility,
    this.subInstituteId,
    this.syear,
    this.userId,
    this.userProfileId,
    this.createdAt,
    this.studentName,
    this.image,
    this.totaldays,
    this.standardDivision,
    this.doubtDate,
    this.conversationData,
  });

  factory SocialCollobrative.fromJson(Map<String, dynamic> json) =>
      SocialCollobrative(
        id: json["id"],
        subjectId: json["subject_id"],
        chapterId: json["chapter_id"],
        topicId: json["topic_id"],
        title: json["title"],
        description: json["description"],
        fileName: json["file_name"],
        visibility: json["visibility"],
        subInstituteId: json["sub_institute_id"],
        syear: json["syear"],
        userId: json["user_id"],
        userProfileId: json["user_profile_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        studentName: json["student_name"],
        image: json["image"],
        totaldays: json["totaldays"],
        standardDivision: json["standard_division"],
        doubtDate: json["doubt_date"],
        conversationData: json["ConversationData"] == null
            ? []
            : List<TeacherConversationData>.from(json["ConversationData"]!
                .map((x) => TeacherConversationData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "subject_id": subjectId,
        "chapter_id": chapterId,
        "topic_id": topicId,
        "title": title,
        "description": description,
        "file_name": fileName,
        "visibility": visibility,
        "sub_institute_id": subInstituteId,
        "syear": syear,
        "user_id": userId,
        "user_profile_id": userProfileId,
        "created_at": createdAt?.toIso8601String(),
        "student_name": studentName,
        "image": image,
        "totaldays": totaldays,
        "standard_division": standardDivision,
        "doubt_date": doubtDate,
        "ConversationData": conversationData == null
            ? []
            : List<dynamic>.from(conversationData!.map((x) => x.toJson())),
      };
}

class TeacherConversationData {
  int? id;
  int? doubtId;
  String? message;
  int? userId;
  int? userProfileId;
  int? syear;
  int? subInstituteId;
  DateTime? createdAt;
  String? studentName;
  String? image;
  String? commentDate;
  String? standardDivision;

  TeacherConversationData({
    this.id,
    this.doubtId,
    this.message,
    this.userId,
    this.userProfileId,
    this.syear,
    this.subInstituteId,
    this.createdAt,
    this.studentName,
    this.image,
    this.commentDate,
    this.standardDivision,
  });

  factory TeacherConversationData.fromJson(Map<String, dynamic> json) =>
      TeacherConversationData(
        id: json["id"],
        doubtId: json["doubt_id"],
        message: json["message"],
        userId: json["user_id"],
        userProfileId: json["user_profile_id"],
        syear: json["syear"],
        subInstituteId: json["sub_institute_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        studentName: json["student_name"],
        image: json["image"],
        commentDate: json["comment_date"],
        standardDivision: json["standard_division"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "doubt_id": doubtId,
        "message": message,
        "user_id": userId,
        "user_profile_id": userProfileId,
        "syear": syear,
        "sub_institute_id": subInstituteId,
        "created_at": createdAt?.toIso8601String(),
        "student_name": studentName,
        "image": image,
        "comment_date": commentDate,
        "standard_division": standardDivision,
      };
}
