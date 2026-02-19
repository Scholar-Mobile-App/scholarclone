import 'dart:convert';

ExamScheduleModel examScheduleModelFromJson(String str) =>
    ExamScheduleModel.fromJson(json.decode(str));

String examScheduleModelToJson(ExamScheduleModel data) =>
    json.encode(data.toJson());

class ExamScheduleModel {
  int? status;
  String? message;
  List<ExamSchedule>? data;

  ExamScheduleModel({
    this.status,
    this.message,
    this.data,
  });

  factory ExamScheduleModel.fromJson(Map<String, dynamic> json) =>
      ExamScheduleModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<ExamSchedule>.from(
                json["data"]!.map((x) => ExamSchedule.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ExamSchedule {
  String? title;
  DateTime? date;
  String? fileName;

  ExamSchedule({
    this.title,
    this.date,
    this.fileName,
  });

  factory ExamSchedule.fromJson(Map<String, dynamic> json) => ExamSchedule(
        title: json["title"],
        date: json["date_"] == null ? null : DateTime.parse(json["date_"]),
        fileName: json["file_name"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "date_": date,
        "file_name": fileName,
      };
}
