import 'dart:convert';

circularModelFromJson(String str) => CircularModel.fromJson(json.decode(str));

String circularModelToJson(CircularModel data) => json.encode(data.toJson());

class CircularModel {
  int? status;
  String? message;
  List<Circular>? data;

  CircularModel({
    this.status,
    this.message,
    this.data,
  });

  factory CircularModel.fromJson(Map<String, dynamic> json) => CircularModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Circular>.from(
                json["data"]!.map((x) => Circular.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Circular {
  int? id;
  String? syear;
  String? standardId;
  String? divisionId;
  String? title;
  String? message;
  String? fileName;
  String? date;
  int? subInstituteId;
  int? type;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? circularType;

  Circular({
    this.id,
    this.syear,
    this.standardId,
    this.divisionId,
    this.title,
    this.message,
    this.fileName,
    this.date,
    this.subInstituteId,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.circularType,
  });

  factory Circular.fromJson(Map<String, dynamic> json) => Circular(
        id: json["id"],
        syear: json["syear"],
        standardId: json["standard_id"],
        divisionId: json["division_id"],
        title: json["title"],
        message: json["message"],
        fileName: json["file_name"],
        date: json["date_"],
        subInstituteId: json["sub_institute_id"],
        type: json["type"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        circularType: json["circular_type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "syear": syear,
        "standard_id": standardId,
        "division_id": divisionId,
        "title": title,
        "message": message,
        "file_name": fileName,
        "date_": date,
        "sub_institute_id": subInstituteId,
        "type": type,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "circular_type": circularType,
      };
}
