import 'dart:convert';

TeacherModel teacherModelFromJson(String str) =>
    TeacherModel.fromJson(json.decode(str));

String teacherModelToJson(TeacherModel data) => json.encode(data.toJson());

class TeacherModel {
  int? status;
  String? message;
  List<Teacher>? data;

  TeacherModel({
    this.status,
    this.message,
    this.data,
  });

  factory TeacherModel.fromJson(Map<String, dynamic> json) => TeacherModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Teacher>.from(json["data"]!.map((x) => Teacher.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Teacher {
  String? teacherName;
  String? image;
  String? mobile;
  String? subjectName;

  Teacher({
    this.teacherName,
    this.image,
    this.mobile,
    this.subjectName,
  });

  factory Teacher.fromJson(Map<String, dynamic> json) => Teacher(
        teacherName: json["teacher_name"],
        image: json["image"],
        mobile: json["mobile"],
        subjectName: json["subject_name"],
      );

  Map<String, dynamic> toJson() => {
        "teacher_name": teacherName,
        "image": image,
        "mobile": mobile,
        "subject_name": subjectName,
      };
}
