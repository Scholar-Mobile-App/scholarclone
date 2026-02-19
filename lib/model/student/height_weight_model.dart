import 'dart:convert';

HeightWeightModel heightWeightModelFromJson(String str) =>
    HeightWeightModel.fromJson(json.decode(str));

String heightWeightModelToJson(HeightWeightModel data) =>
    json.encode(data.toJson());

class HeightWeightModel {
  int? statusCode;
  String? message;
  List<HeightWeight>? data;

  HeightWeightModel({
    this.statusCode,
    this.message,
    this.data,
  });

  factory HeightWeightModel.fromJson(Map<String, dynamic> json) =>
      HeightWeightModel(
        statusCode: json["status_code"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<HeightWeight>.from(
                json["data"]!.map((x) => HeightWeight.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class HeightWeight {
  int? id;
  int? studentId;
  String? doctorName;
  String? doctorContact;
  String? height;
  String? weight;
  String? date;

  HeightWeight({
    this.id,
    this.studentId,
    this.doctorName,
    this.doctorContact,
    this.height,
    this.weight,
    this.date,
  });

  factory HeightWeight.fromJson(Map<String, dynamic> json) => HeightWeight(
        id: json["id"],
        studentId: json["student_id"],
        doctorName: json["doctor_name"],
        doctorContact: json["doctor_contact"],
        height: json["height"],
        weight: json["weight"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "student_id": studentId,
        "doctor_name": doctorName,
        "doctor_contact": doctorContact,
        "height": height,
        "weight": weight,
        "date": date,
      };
}
