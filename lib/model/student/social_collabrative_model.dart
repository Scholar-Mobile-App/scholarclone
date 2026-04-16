import 'dart:convert';

SocialCollabrativeModel socialCollabrativeModelFromJson(String str) =>
    SocialCollabrativeModel.fromJson(json.decode(str));

String socialCollabrativeModelToJson(SocialCollabrativeModel data) =>
    json.encode(data.toJson());

class SocialCollabrativeModel {
  dynamic status;
  String? message;
  List<SocialCollabrative> data;

  SocialCollabrativeModel({
    this.status,
    this.message,
    this.data = const [],
  });

  factory SocialCollabrativeModel.fromJson(Map<String, dynamic> json) {
    final rawData = json["data"];
    final List<SocialCollabrative> items = [];

    if (rawData is List) {
      for (final item in rawData) {
        if (item is Map<String, dynamic>) {
          items.add(SocialCollabrative.fromJson(item));
        } else if (item is Map) {
          items.add(SocialCollabrative.fromJson(Map<String, dynamic>.from(item)));
        }
      }
    } else if (rawData is Map) {
      rawData.forEach((_, value) {
        if (value is Map<String, dynamic>) {
          items.add(SocialCollabrative.fromJson(value));
        } else if (value is Map) {
          items.add(SocialCollabrative.fromJson(Map<String, dynamic>.from(value)));
        }
      });
    }

    return SocialCollabrativeModel(
      status: json["status"],
      message: json["message"],
      data: items,
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

int? _toInt(dynamic value) {
  if (value is int) return value;
  if (value == null) return null;
  return int.tryParse(value.toString());
}

DateTime? _toDate(dynamic value) {
  if (value == null || value.toString().isEmpty) return null;
  return DateTime.tryParse(value.toString());
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
        id: _toInt(json["id"]),
        subjectId: _toInt(json["subject_id"]),
        chapterId: _toInt(json["chapter_id"]),
        topicId: _toInt(json["topic_id"]),
        title: json["title"]?.toString(),
        description: json["description"]?.toString(),
        fileName: json["file_name"]?.toString(),
        visibility: json["visibility"]?.toString(),
        subInstituteId: _toInt(json["sub_institute_id"]),
        syear: _toInt(json["syear"]),
        userId: _toInt(json["user_id"]),
        userProfileId: _toInt(json["user_profile_id"]),
        createdAt: _toDate(json["created_at"]),
        conversationData: _conversationList(json["ConversationData"]),
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

List<Conversation> _conversationList(dynamic rawData) {
  final List<Conversation> items = [];

  if (rawData is List) {
    for (final item in rawData) {
      if (item is Map<String, dynamic>) {
        items.add(Conversation.fromJson(item));
      } else if (item is Map) {
        items.add(Conversation.fromJson(Map<String, dynamic>.from(item)));
      }
    }
  } else if (rawData is Map) {
    rawData.forEach((_, value) {
      if (value is Map<String, dynamic>) {
        items.add(Conversation.fromJson(value));
      } else if (value is Map) {
        items.add(Conversation.fromJson(Map<String, dynamic>.from(value)));
      }
    });
  }

  return items;
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
        id: _toInt(json["id"]),
        doubtId: _toInt(json["doubt_id"]),
        message: json["message"]?.toString(),
        userId: _toInt(json["user_id"]),
        userProfileId: _toInt(json["user_profile_id"]),
        syear: _toInt(json["syear"]),
        subInstituteId: _toInt(json["sub_institute_id"]),
        createdAt: _toDate(json["created_at"]),
        studentName: json["student_name"]?.toString(),
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
