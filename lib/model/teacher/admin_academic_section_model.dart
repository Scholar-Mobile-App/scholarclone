import 'dart:convert';

AdminAcademicSectionModel adminAcademicSectionModelFromJson(String str) =>
    AdminAcademicSectionModel.fromJson(json.decode(str));

String adminAcademicSectionModelToJson(AdminAcademicSectionModel data) =>
    json.encode(data.toJson());

class AdminAcademicSectionModel {
  int? status;
  List<AcademicSection>? data;

  AdminAcademicSectionModel({
    this.status,
    this.data,
  });

  factory AdminAcademicSectionModel.fromJson(Map<String, dynamic> json) =>
      AdminAcademicSectionModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<AcademicSection>.from(
                json["data"]!.map((x) => AcademicSection.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class AcademicSection {
  int? id;
  int? subInstituteId;
  String? title;
  String? shortName;
  int? sortOrder;
  String? shift;
  String? medium;
  String? paymentLink;
  DateTime? createdAt;
  DateTime? updatedAt;

  AcademicSection({
    this.id,
    this.subInstituteId,
    this.title,
    this.shortName,
    this.sortOrder,
    this.shift,
    this.medium,
    this.paymentLink,
    this.createdAt,
    this.updatedAt,
  });

  factory AcademicSection.fromJson(Map<String, dynamic> json) =>
      AcademicSection(
        id: json["id"],
        subInstituteId: json["sub_institute_id"],
        title: json["title"],
        shortName: json["short_name"],
        sortOrder: json["sort_order"],
        shift: json["shift"],
        medium: json["medium"],
        paymentLink: json["payment_link"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sub_institute_id": subInstituteId,
        "title": title,
        "short_name": shortName,
        "sort_order": sortOrder,
        "shift": shift,
        "medium": medium,
        "payment_link": paymentLink,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
