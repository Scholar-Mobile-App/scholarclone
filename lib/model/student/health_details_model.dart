// To parse this JSON data, do
//
//     final healthDetailsModel = healthDetailsModelFromJson(jsonString);

import 'dart:convert';

HealthDetailsModel healthDetailsModelFromJson(String str) =>
    HealthDetailsModel.fromJson(json.decode(str));

String healthDetailsModelToJson(HealthDetailsModel data) =>
    json.encode(data.toJson());

class HealthDetailsModel {
  int? status;
  String? message;
  List<Doctor>? data;

  HealthDetailsModel({
    this.status,
    this.message,
    this.data,
  });

  factory HealthDetailsModel.fromJson(Map<String, dynamic> json) =>
      HealthDetailsModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Doctor>.from(json["data"]!.map((x) => Doctor.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Doctor {
  String? doctorName;
  String? doctorContact;
  String? date;
  String? file;
  String? remarks;

  Doctor({
    this.doctorName,
    this.doctorContact,
    this.date,
    this.file,
    this.remarks,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
        doctorName: json["doctor_name"],
        doctorContact: json["doctor_contact"],
        date: json["date"],
        file: json["file"],
        remarks: json["remarks"],
      );

  Map<String, dynamic> toJson() => {
        "doctor_name": doctorName,
        "doctor_contact": doctorContact,
        "date": date,
        "file": file,
        "remarks": remarks,
      };
}
