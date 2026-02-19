import 'dart:convert';

VisitorModel visitorModelFromJson(String str) =>
    VisitorModel.fromJson(json.decode(str));

String visitorModelToJson(VisitorModel data) => json.encode(data.toJson());

class VisitorModel {
  int? status;
  String? message;
  List<Visitor>? data;

  VisitorModel({
    this.status,
    this.message,
    this.data,
  });

  factory VisitorModel.fromJson(Map<String, dynamic> json) => VisitorModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Visitor>.from(json["data"]!.map((x) => Visitor.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Visitor {
  int? id;
  String? appointmentType;
  int? visitorType;
  String? name;
  String? contact;
  String? email;
  String? comingFrom;
  int? toMeet;
  String? relation;
  String? purpose;
  String? visitorIdcard;
  String? photo;
  String? fileSize;
  String? fileType;
  DateTime? meetDate;
  String? inTime;
  String? outTime;
  int? subInstituteId;
  dynamic exitMsgSent;
  DateTime? createdAt;
  dynamic updatedAt;
  String? staffName;
  String? visitorTypeName;
  String? visitorPhoto;

  Visitor({
    this.id,
    this.appointmentType,
    this.visitorType,
    this.name,
    this.contact,
    this.email,
    this.comingFrom,
    this.toMeet,
    this.relation,
    this.purpose,
    this.visitorIdcard,
    this.photo,
    this.fileSize,
    this.fileType,
    this.meetDate,
    this.inTime,
    this.outTime,
    this.subInstituteId,
    this.exitMsgSent,
    this.createdAt,
    this.updatedAt,
    this.staffName,
    this.visitorTypeName,
    this.visitorPhoto,
  });

  factory Visitor.fromJson(Map<String, dynamic> json) => Visitor(
        id: json["id"],
        appointmentType: json["appointment_type"],
        visitorType: json["visitor_type"],
        name: json["name"],
        contact: json["contact"],
        email: json["email"],
        comingFrom: json["coming_from"],
        toMeet: json["to_meet"],
        relation: json["relation"],
        purpose: json["purpose"],
        visitorIdcard: json["visitor_idcard"],
        photo: json["photo"],
        fileSize: json["file_size"],
        fileType: json["file_type"],
        meetDate: json["meet_date"] == null
            ? null
            : DateTime.parse(json["meet_date"]),
        inTime: json["in_time"],
        outTime: json["out_time"],
        subInstituteId: json["sub_institute_id"],
        exitMsgSent: json["exit_msg_sent"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
        staffName: json["staff_name"],
        visitorTypeName: json["visitor_type_name"],
        visitorPhoto: json["visitor_photo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "appointment_type": appointmentType,
        "visitor_type": visitorType,
        "name": name,
        "contact": contact,
        "email": email,
        "coming_from": comingFrom,
        "to_meet": toMeet,
        "relation": relation,
        "purpose": purpose,
        "visitor_idcard": visitorIdcard,
        "photo": photo,
        "file_size": fileSize,
        "file_type": fileType,
        "meet_date":
            "${meetDate!.year.toString().padLeft(4, '0')}-${meetDate!.month.toString().padLeft(2, '0')}-${meetDate!.day.toString().padLeft(2, '0')}",
        "in_time": inTime,
        "out_time": outTime,
        "sub_institute_id": subInstituteId,
        "exit_msg_sent": exitMsgSent,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt,
        "staff_name": staffName,
        "visitor_type_name": visitorTypeName,
        "visitor_photo": visitorPhoto,
      };
}
