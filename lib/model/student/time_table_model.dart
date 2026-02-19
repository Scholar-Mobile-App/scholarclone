import 'dart:convert';

TimeTableModel timeTableModelFromJson(String str) =>
    TimeTableModel.fromJson(json.decode(str));

String timeTableModelToJson(TimeTableModel data) => json.encode(data.toJson());

class TimeTableModel {
  int? status;
  String? message;
  List<TimeTable>? data;

  TimeTableModel({
    this.status,
    this.message,
    this.data,
  });

  factory TimeTableModel.fromJson(Map<String, dynamic> json) => TimeTableModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<TimeTable>.from(
                json["data"]!.map((x) => TimeTable.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class TimeTable {
  String? weekDay;
  String? standardName;
  String? subjectName;
  String? teacherName;
  String? periodName;
  String? startTime;
  String? endTime;
  String? studentbatch;
  String? batchName;
  int? batchId;
  int? periodId;

  TimeTable({
    this.weekDay,
    this.standardName,
    this.subjectName,
    this.teacherName,
    this.periodName,
    this.startTime,
    this.endTime,
    this.studentbatch,
    this.batchName,
    this.batchId,
    this.periodId,
  });

  factory TimeTable.fromJson(Map<String, dynamic> json) => TimeTable(
        weekDay: json["week_day"],
        standardName: json["standard_name"],
        subjectName: json["subject_name"],
        teacherName: json["teacher_name"],
        periodName: json["period_name"],
        startTime: json["start_time"],
        endTime: json["end_time"],
        studentbatch: json["studentbatch"],
        batchName: json["batch_name"],
        batchId: json["batch_id"],
        periodId: json["period_id"],
      );

  Map<String, dynamic> toJson() => {
        "week_day": weekDay,
        "standard_name": standardName,
        "subject_name": subjectName,
        "teacher_name": teacherName,
        "period_name": periodName,
        "start_time": startTime,
        "end_time": endTime,
        "studentbatch": studentbatch,
        "batch_name": batchName,
        "batch_id": batchId,
        "period_id": periodId,
      };
}
