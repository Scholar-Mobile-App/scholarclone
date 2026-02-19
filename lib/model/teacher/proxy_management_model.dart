import 'dart:convert';

ProxyManagementModel proxyManagementModelFromJson(String str) =>
    ProxyManagementModel.fromJson(json.decode(str));

String proxyManagementModelToJson(ProxyManagementModel data) =>
    json.encode(data.toJson());

class ProxyManagementModel {
  List<Proxy>? data;
  dynamic status;
  String? message;

  ProxyManagementModel({
    this.data,
    this.status,
    this.message,
  });

  factory ProxyManagementModel.fromJson(Map<String, dynamic> json) =>
      ProxyManagementModel(
        data: json["data"] == null
            ? []
            : List<Proxy>.from(json["data"]!.map((x) => Proxy.fromJson(x))),
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "status": status,
        "message": message,
      };
}

class Proxy {
  int? id;
  int? subInstituteId;
  int? syear;
  int? timetableId;
  int? gradeId;
  int? standardId;
  int? divisionId;
  dynamic batchId;
  int? subjectId;
  int? teacherId;
  int? proxyTeacherId;
  int? periodId;
  String? weekDay;
  DateTime? proxyDate;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? standardName;
  String? divisionName;
  String? teacherName;
  String? proxyTeacherName;
  String? periodName;
  String? subName;

  Proxy({
    this.id,
    this.subInstituteId,
    this.syear,
    this.timetableId,
    this.gradeId,
    this.standardId,
    this.divisionId,
    this.batchId,
    this.subjectId,
    this.teacherId,
    this.proxyTeacherId,
    this.periodId,
    this.weekDay,
    this.proxyDate,
    this.createdAt,
    this.updatedAt,
    this.standardName,
    this.divisionName,
    this.teacherName,
    this.proxyTeacherName,
    this.periodName,
    this.subName,
  });

  factory Proxy.fromJson(Map<String, dynamic> json) => Proxy(
        id: json["id"],
        subInstituteId: json["sub_institute_id"],
        syear: json["syear"],
        timetableId: json["timetable_id"],
        gradeId: json["grade_id"],
        standardId: json["standard_id"],
        divisionId: json["division_id"],
        batchId: json["batch_id"],
        subjectId: json["subject_id"],
        teacherId: json["teacher_id"],
        proxyTeacherId: json["proxy_teacher_id"],
        periodId: json["period_id"],
        weekDay: json["week_day"],
        proxyDate: json["proxy_date"] == null
            ? null
            : DateTime.parse(json["proxy_date"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        standardName: json["standard_name"],
        divisionName: json["division_name"],
        teacherName: json["teacher_name"],
        proxyTeacherName: json["proxy_teacher_name"],
        periodName: json["period_name"],
        subName: json["sub_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sub_institute_id": subInstituteId,
        "syear": syear,
        "timetable_id": timetableId,
        "grade_id": gradeId,
        "standard_id": standardId,
        "division_id": divisionId,
        "batch_id": batchId,
        "subject_id": subjectId,
        "teacher_id": teacherId,
        "proxy_teacher_id": proxyTeacherId,
        "period_id": periodId,
        "week_day": weekDay,
        "proxy_date":
            "${proxyDate!.year.toString().padLeft(4, '0')}-${proxyDate!.month.toString().padLeft(2, '0')}-${proxyDate!.day.toString().padLeft(2, '0')}",
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "standard_name": standardName,
        "division_name": divisionName,
        "teacher_name": teacherName,
        "proxy_teacher_name": proxyTeacherName,
        "period_name": periodName,
        "sub_name": subName,
      };
}
