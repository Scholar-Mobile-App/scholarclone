import 'dart:convert';

StudentDisciplineModel studentDisciplineModelFromJson(String str) =>
    StudentDisciplineModel.fromJson(json.decode(str));

String studentDisciplineModelToJson(StudentDisciplineModel data) =>
    json.encode(data.toJson());

class StudentDisciplineModel {
  int? status;
  String? message;
  List<Discipline>? data;

  StudentDisciplineModel({
    this.status,
    this.message,
    this.data,
  });

  factory StudentDisciplineModel.fromJson(Map<String, dynamic> json) =>
      StudentDisciplineModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Discipline>.from(
                json["data"]!.map((x) => Discipline.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Discipline {
  String? discipline;
  String? message;
  DateTime? disciplineDate;

  Discipline({
    this.discipline,
    this.message,
    this.disciplineDate,
  });

  factory Discipline.fromJson(Map<String, dynamic> json) => Discipline(
        discipline: json["discipline"],
        message: json["message"],
        disciplineDate: json["discipline_date"] == null
            ? null
            : DateTime.parse(json["discipline_date"]),
      );

  Map<String, dynamic> toJson() => {
        "discipline": discipline,
        "message": message,
        "discipline_date":
            "${disciplineDate!.year.toString().padLeft(4, '0')}-${disciplineDate!.month.toString().padLeft(2, '0')}-${disciplineDate!.day.toString().padLeft(2, '0')}",
      };
}
