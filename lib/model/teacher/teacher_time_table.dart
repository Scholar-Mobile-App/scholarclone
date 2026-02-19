import 'dart:convert';

TeacherTimeTable teacherTimeTableFromJson(String str) =>
    TeacherTimeTable.fromJson(json.decode(str));

String teacherTimeTableToJson(TeacherTimeTable data) =>
    json.encode(data.toJson());

class TeacherTimeTable {
  int? statusCode;
  String? message;
  List<TTimeTable>? data;

  TeacherTimeTable({
    this.statusCode,
    this.message,
    this.data,
  });

  factory TeacherTimeTable.fromJson(Map<String, dynamic> json) =>
      TeacherTimeTable(
        statusCode: json["status_code"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<TTimeTable>.from(
                json["data"]!.map((x) => TTimeTable.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class TTimeTable {
  String? weekDay;
  String? lectures;
  String? periodname;

  TTimeTable({
    this.weekDay,
    this.lectures,
    this.periodname,
  });

  factory TTimeTable.fromJson(Map<String, dynamic> json) => TTimeTable(
        weekDay: json["week_day"],
        lectures: json["lectures"],
        periodname: json["periodname"],
      );

  Map<String, dynamic> toJson() => {
        "week_day": weekDay,
        "lectures": lectures,
        "periodname": periodname,
      };
}
