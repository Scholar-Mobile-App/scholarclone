import 'dart:convert';

SocialCollabrativeModel socialCollabrativeModelFromJson(String str) =>
    SocialCollabrativeModel.fromJson(json.decode(str));

String socialCollabrativeModelToJson(SocialCollabrativeModel data) =>
    json.encode(data.toJson());

class SocialCollabrativeModel {
  int? status;
  String? message;
  Map<String, SocialCollabrative>? data;

  SocialCollabrativeModel({
    this.status,
    this.message,
    this.data,
  });

  factory SocialCollabrativeModel.fromJson(Map<String, dynamic> json) =>
      SocialCollabrativeModel(
        status: json["status"],
        message: json["message"],
        data: Map.from(json["data"]!).map((k, v) =>
            MapEntry<String, SocialCollabrative>(
                k, SocialCollabrative.fromJson(v))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": Map.from(data!)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
      };
}

class SocialCollabrative {
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
  List<Conversation>? conversationData;

  SocialCollabrative({
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
    this.conversationData,
  });

  factory SocialCollabrative.fromJson(Map<String, dynamic> json) =>
      SocialCollabrative(
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
        conversationData: json["ConversationData"] == null
            ? []
            : List<Conversation>.from(
                json["ConversationData"]!.map((x) => Conversation.fromJson(x))),
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
        "ConversationData": conversationData == null
            ? []
            : List<dynamic>.from(conversationData!.map((x) => x.toJson())),
      };
}

class Conversation {
  int? id;
  int? doubtId;
  String? message;
  int? userId;
  int? userProfileId;
  int? syear;
  int? subInstituteId;
  DateTime? createdAt;
  String? studentName;

  Conversation({
    this.id,
    this.doubtId,
    this.message,
    this.userId,
    this.userProfileId,
    this.syear,
    this.subInstituteId,
    this.createdAt,
    this.studentName,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) => Conversation(
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
      };
}
