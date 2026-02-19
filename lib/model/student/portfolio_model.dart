import 'dart:convert';

PortfolioModel portfolioModelFromJson(String str) =>
    PortfolioModel.fromJson(json.decode(str));

String portfolioModelToJson(PortfolioModel data) => json.encode(data.toJson());

class PortfolioModel {
  int? status;
  String? message;
  List<Portfolio>? data;

  PortfolioModel({
    this.status,
    this.message,
    this.data,
  });

  factory PortfolioModel.fromJson(Map<String, dynamic> json) => PortfolioModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Portfolio>.from(
                json["data"]!.map((x) => Portfolio.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Portfolio {
  int? id;
  int? userId;
  int? subInstituteId;
  int? syear;
  int? userProfileId;
  String? title;
  String? description;
  String? fileName;
  String? type;
  dynamic feedback;
  dynamic feedbackBy;
  String? createdAt;
  String? teacherName;

  Portfolio({
    this.id,
    this.userId,
    this.subInstituteId,
    this.syear,
    this.userProfileId,
    this.title,
    this.description,
    this.fileName,
    this.type,
    this.feedback,
    this.feedbackBy,
    this.createdAt,
    this.teacherName,
  });

  factory Portfolio.fromJson(Map<String, dynamic> json) => Portfolio(
        id: json["id"],
        userId: json["user_id"],
        subInstituteId: json["sub_institute_id"],
        syear: json["syear"],
        userProfileId: json["user_profile_id"],
        title: json["title"],
        description: json["description"],
        fileName: json["file_name"],
        type: json["type"],
        feedback: json["feedback"],
        feedbackBy: json["feedback_by"],
        createdAt: json["created_at"],
        teacherName: json["teacher_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "sub_institute_id": subInstituteId,
        "syear": syear,
        "user_profile_id": userProfileId,
        "title": title,
        "description": description,
        "file_name": fileName,
        "type": type,
        "feedback": feedback,
        "feedback_by": feedbackBy,
        "created_at": createdAt,
        "teacher_name": teacherName,
      };
}
