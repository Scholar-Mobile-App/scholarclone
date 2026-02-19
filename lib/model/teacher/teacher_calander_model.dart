import 'dart:convert';

TeacherCalanderModel teacherCalanderModelFromJson(String str) =>
    TeacherCalanderModel.fromJson(json.decode(str));

String teacherCalanderModelToJson(TeacherCalanderModel data) =>
    json.encode(data.toJson());

class TeacherCalanderModel {
  int? status;
  String? message;
  List<TeacherCalander>? data;

  TeacherCalanderModel({
    this.status,
    this.message,
    this.data,
  });

  factory TeacherCalanderModel.fromJson(Map<String, dynamic> json) =>
      TeacherCalanderModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<TeacherCalander>.from(
                json["data"]!.map((x) => TeacherCalander.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class TeacherCalander {
  int? stdId;
  String? stdName;
  int? gradeId;

  TeacherCalander({
    this.stdId,
    this.stdName,
    this.gradeId,
  });

  factory TeacherCalander.fromJson(Map<String, dynamic> json) =>
      TeacherCalander(
        stdId: json["std_id"],
        stdName: json["std_name"],
        gradeId: json["grade_id"],
      );

  Map<String, dynamic> toJson() => {
        "std_id": stdId,
        "std_name": stdName,
        "grade_id": gradeId,
      };
}
