import 'dart:convert';

InfirmaryDetailsModel infirmaryDetailsModelFromJson(String str) =>
    InfirmaryDetailsModel.fromJson(json.decode(str));

String infirmaryDetailsModelToJson(InfirmaryDetailsModel data) =>
    json.encode(data.toJson());

class InfirmaryDetailsModel {
  int? statusCode;
  String? message;
  List<Infirmary>? data;

  InfirmaryDetailsModel({
    this.statusCode,
    this.message,
    this.data,
  });

  factory InfirmaryDetailsModel.fromJson(Map<String, dynamic> json) =>
      InfirmaryDetailsModel(
        statusCode: json["status_code"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Infirmary>.from(
                json["data"]!.map((x) => Infirmary.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Infirmary {
  int? id;
  int? studentId;
  String? doctorName;
  String? doctorContact;
  String? medicalCaseNo;
  String? date;
  String? complaint;
  String? symptoms;
  String? disease;
  String? treatments;
  String? medicalCloseDate;
  String? healthCenter;

  Infirmary({
    this.id,
    this.studentId,
    this.doctorName,
    this.doctorContact,
    this.medicalCaseNo,
    this.date,
    this.complaint,
    this.symptoms,
    this.disease,
    this.treatments,
    this.medicalCloseDate,
    this.healthCenter,
  });

  factory Infirmary.fromJson(Map<String, dynamic> json) => Infirmary(
        id: json["id"],
        studentId: json["student_id"],
        doctorName: json["doctor_name"],
        doctorContact: json["doctor_contact"],
        medicalCaseNo: json["medical_case_no"],
        date: json["date"],
        complaint: json["complaint"],
        symptoms: json["symptoms"],
        disease: json["disease"],
        treatments: json["treatments"],
        medicalCloseDate: json["medical_close_date"],
        healthCenter: json["health_center"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "student_id": studentId,
        "doctor_name": doctorName,
        "doctor_contact": doctorContact,
        "medical_case_no": medicalCaseNo,
        "date": date,
        "complaint": complaint,
        "symptoms": symptoms,
        "disease": disease,
        "treatments": treatments,
        "medical_close_date": medicalCloseDate,
        "health_center": healthCenter,
      };
}
