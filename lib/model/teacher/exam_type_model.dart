import 'dart:convert';

ExamTypeModel examTypeModelFromJson(String str) =>
    ExamTypeModel.fromJson(json.decode(str));

String examTypeModelToJson(ExamTypeModel data) => json.encode(data.toJson());

class ExamTypeModel {
  List<ExamType>? data;

  ExamTypeModel({
    this.data,
  });

  factory ExamTypeModel.fromJson(Map<String, dynamic> json) => ExamTypeModel(
        data: json["data"] == null
            ? []
            : List<ExamType>.from(
                json["data"]!.map((x) => ExamType.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ExamType {
  int? id;
  String? code;
  int? examType;
  String? examTitle;
  int? sortOrder;
  int? subInstituteId;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? totalCount;
  int? srNo;

  ExamType({
    this.id,
    this.code,
    this.examType,
    this.examTitle,
    this.sortOrder,
    this.subInstituteId,
    this.createdAt,
    this.updatedAt,
    this.totalCount,
    this.srNo,
  });

  factory ExamType.fromJson(Map<String, dynamic> json) => ExamType(
        id: json["Id"],
        code: json["Code"],
        examType: json["ExamType"],
        examTitle: json["ExamTitle"],
        sortOrder: json["SortOrder"],
        subInstituteId: json["SubInstituteId"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        totalCount: json["total_count"],
        srNo: json["SrNo"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Code": code,
        "ExamType": examType,
        "ExamTitle": examTitle,
        "SortOrder": sortOrder,
        "SubInstituteId": subInstituteId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "total_count": totalCount,
        "SrNo": srNo,
      };
}
