import 'dart:convert';

FileLocationModel fileLocationModelFromJson(String str) =>
    FileLocationModel.fromJson(json.decode(str));

String fileLocationModelToJson(FileLocationModel data) =>
    json.encode(data.toJson());

class FileLocationModel {
  List<FileName>? data;

  FileLocationModel({
    this.data,
  });

  factory FileLocationModel.fromJson(Map<String, dynamic> json) =>
      FileLocationModel(
        data: json["data"] == null
            ? []
            : List<FileName>.from(
                json["data"]!.map((x) => FileName.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class FileName {
  int? id;
  int? subInstituteId;
  String? title;
  String? description;
  String? fileCode;
  String? fileLocation;
  DateTime? createdAt;
  DateTime? updatedAt;

  FileName({
    this.id,
    this.subInstituteId,
    this.title,
    this.description,
    this.fileCode,
    this.fileLocation,
    this.createdAt,
    this.updatedAt,
  });

  factory FileName.fromJson(Map<String, dynamic> json) => FileName(
        id: json["id"],
        subInstituteId: json["sub_institute_id"],
        title: json["title"],
        description: json["description"],
        fileCode: json["file_code"],
        fileLocation: json["file_location"],
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
        "description": description,
        "file_code": fileCode,
        "file_location": fileLocation,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
