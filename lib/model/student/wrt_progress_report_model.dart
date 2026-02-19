import 'dart:convert';

WrtProgressReportModel wrtProgressReportModelFromJson(String str) =>
    WrtProgressReportModel.fromJson(json.decode(str));

String wrtProgressReportModelToJson(WrtProgressReportModel data) =>
    json.encode(data.toJson());

class WrtProgressReportModel {
  int? status;
  String? message;
  WrtProgress? data;

  WrtProgressReportModel({
    this.status,
    this.message,
    this.data,
  });

  factory WrtProgressReportModel.fromJson(Map<String, dynamic> json) =>
      WrtProgressReportModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : WrtProgress.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class WrtProgress {
  String? studentId;
  String? subInstituteId;
  String? syear;
  String? title;
  String? fileName;

  WrtProgress({
    this.studentId,
    this.subInstituteId,
    this.syear,
    this.title,
    this.fileName,
  });

  factory WrtProgress.fromJson(Map<String, dynamic> json) => WrtProgress(
        studentId: json["student_id"],
        subInstituteId: json["sub_institute_id"],
        syear: json["syear"],
        title: json["title"],
        fileName: json["file_name"],
      );

  Map<String, dynamic> toJson() => {
        "student_id": studentId,
        "sub_institute_id": subInstituteId,
        "syear": syear,
        "title": title,
        "file_name": fileName,
      };
}
