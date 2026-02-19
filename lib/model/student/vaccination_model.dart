import 'dart:convert';

VaccinationModel vaccinationModelFromJson(String str) =>
    VaccinationModel.fromJson(json.decode(str));

String vaccinationModelToJson(VaccinationModel data) =>
    json.encode(data.toJson());

class VaccinationModel {
  int? statusCode;
  String? message;
  List<Vaccination>? data;

  VaccinationModel({
    this.statusCode,
    this.message,
    this.data,
  });

  factory VaccinationModel.fromJson(Map<String, dynamic> json) =>
      VaccinationModel(
        statusCode: json["status_code"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Vaccination>.from(
                json["data"]!.map((x) => Vaccination.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Vaccination {
  int? id;
  int? studentId;
  String? doctorName;
  String? doctorContact;
  String? vaccinationType;
  String? note;
  String? date;

  Vaccination({
    this.id,
    this.studentId,
    this.doctorName,
    this.doctorContact,
    this.vaccinationType,
    this.note,
    this.date,
  });

  factory Vaccination.fromJson(Map<String, dynamic> json) => Vaccination(
        id: json["id"],
        studentId: json["student_id"],
        doctorName: json["doctor_name"],
        doctorContact: json["doctor_contact"],
        vaccinationType: json["vaccination_type"],
        note: json["note"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "student_id": studentId,
        "doctor_name": doctorName,
        "doctor_contact": doctorContact,
        "vaccination_type": vaccinationType,
        "note": note,
        "date": date,
      };
}
