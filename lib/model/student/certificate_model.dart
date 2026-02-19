import 'dart:convert';

CertificateListModel certificateListModelFromJson(String str) =>
    CertificateListModel.fromJson(json.decode(str));

String certificateListModelToJson(CertificateListModel data) =>
    json.encode(data.toJson());

class CertificateListModel {
  int? statusCode;
  String? message;
  List<Certificate>? data;

  CertificateListModel({
    this.statusCode,
    this.message,
    this.data,
  });

  factory CertificateListModel.fromJson(Map<String, dynamic> json) =>
      CertificateListModel(
        statusCode: json["status_code"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Certificate>.from(
                json["data"]!.map((x) => Certificate.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Certificate {
  int? id;
  String? certificateType;
  int? syear;
  String? studentId;
  String? subInstituteId;
  String? certificateNumber;
  String? certificateHtml;
  DateTime? createdAt;
  DateTime? updatedAt;

  Certificate({
    this.id,
    this.certificateType,
    this.syear,
    this.studentId,
    this.subInstituteId,
    this.certificateNumber,
    this.certificateHtml,
    this.createdAt,
    this.updatedAt,
  });

  factory Certificate.fromJson(Map<String, dynamic> json) => Certificate(
        id: json["id"],
        certificateType: json["certificate_type"],
        syear: json["syear"],
        studentId: json["student_id"],
        subInstituteId: json["sub_institute_id"],
        certificateNumber: json["certificate_number"],
        certificateHtml: json["certificate_html"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "certificate_type": certificateType,
        "syear": syear,
        "student_id": studentId,
        "sub_institute_id": subInstituteId,
        "certificate_number": certificateNumber,
        "certificate_html": certificateHtml,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
