import 'dart:convert';

HomeworkModel homeworkModelFromJson(String str) =>
    HomeworkModel.fromJson(json.decode(str));

String homeworkModelToJson(HomeworkModel data) => json.encode(data.toJson());

class HomeworkModel {
  int? status;
  String? message;
  List<Homework>? data;

  HomeworkModel({
    this.status,
    this.message,
    this.data,
  });

  factory HomeworkModel.fromJson(Map<String, dynamic> json) => HomeworkModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Homework>.from(
                json["data"]!.map((x) => Homework.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Homework {
  int? id;
  String? title;
  String? description;
  String? date;
  String? fileName;
  String? standardName;
  String? divisionName;
  String? subjectName;
  String? studentName;
  String? enrollmentNo;
  String? mobile;
  String? type;
  String? userImage;

  Homework({
    this.id,
    this.title,
    this.description,
    this.date,
    this.fileName,
    this.standardName,
    this.divisionName,
    this.subjectName,
    this.studentName,
    this.enrollmentNo,
    this.mobile,
    this.type,
    this.userImage,
  });

  factory Homework.fromJson(Map<String, dynamic> json) => Homework(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        date: json["date"],
        fileName: json["file_name"],
        standardName: json["standard_name"],
        divisionName: json["division_name"],
        subjectName: json["subject_name"],
        studentName: json["student_name"],
        enrollmentNo: json["enrollment_no"],
        mobile: json["mobile"],
        type: json["type"],
        userImage: json["user_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "date": date,
        "file_name": fileName,
        "standard_name": standardName,
        "division_name": divisionName,
        "subject_name": subjectName,
        "student_name": studentName,
        "enrollment_no": enrollmentNo,
        "mobile": mobile,
        "type": type,
        "user_image": userImage,
      };
}
