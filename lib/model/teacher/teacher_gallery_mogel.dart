import 'dart:convert';

TeacherGalleryModel teacherGalleryModelFromJson(String str) =>
    TeacherGalleryModel.fromJson(json.decode(str));

String teacherGalleryModelToJson(TeacherGalleryModel data) =>
    json.encode(data.toJson());

class TeacherGalleryModel {
  String? status;
  String? message;
  Map<String, List<TeacherGallery>>? data;

  TeacherGalleryModel({
    this.status,
    this.message,
    this.data,
  });

  factory TeacherGalleryModel.fromJson(Map<String, dynamic> json) =>
      TeacherGalleryModel(
        status: json["status"].toString(),
        message: json["message"],
        data: Map.from(json["data"]!).map((k, v) =>
            MapEntry<String, List<TeacherGallery>>(
                k,
                List<TeacherGallery>.from(
                    v.map((x) => TeacherGallery.fromJson(x))))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": Map.from(data!).map((k, v) => MapEntry<String, dynamic>(
            k, List<dynamic>.from(v.map((x) => x.toJson())))),
      };
}

class TeacherGallery {
  int? id;
  int? syear;
  int? standardId;
  String? albumTitle;
  String? title;
  String? type;
  String? ai;
  String? fileName;
  DateTime? date;
  int? subInstituteId;
  DateTime? createdAt;
  DateTime? updatedAt;

  TeacherGallery({
    this.id,
    this.syear,
    this.standardId,
    this.albumTitle,
    this.title,
    this.type,
    this.ai,
    this.fileName,
    this.date,
    this.subInstituteId,
    this.createdAt,
    this.updatedAt,
  });

  factory TeacherGallery.fromJson(Map<String, dynamic> json) => TeacherGallery(
        id: json["id"],
        syear: json["syear"],
        standardId: json["standard_id"],
        albumTitle: json["album_title"],
        title: json["title"],
        type: json["type"],
        ai: json["ai"],
        fileName: json["file_name"],
        date: json["date_"] == null ? null : DateTime.parse(json["date_"]),
        subInstituteId: json["sub_institute_id"],
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
        "standard_id": standardId,
        "album_title": albumTitle,
        "title": title,
        "type": type,
        "ai": ai,
        "file_name": fileName,
        "date_":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "sub_institute_id": subInstituteId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
