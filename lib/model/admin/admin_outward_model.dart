class AdminOutwardModel {
  List<Outward>? data;
  int? status;

  AdminOutwardModel({
    this.data,
    this.status,
  });

  factory AdminOutwardModel.fromJson(Map<String, dynamic> json) =>
      AdminOutwardModel(
        data: json["data"] == null
            ? []
            : List<Outward>.from(json["data"]!.map((x) => Outward.fromJson(x))),
        status: json["status"],
      );
}

class Outward {
  int? id;
  int? subInstituteId;
  int? syear;
  String? placeId;
  String? fileLocationId;
  String? outwardNumber;
  String? title;
  String? description;
  String? attachment;
  String? attachmentSize;
  String? attachmentType;
  String? acedemicYear;
  DateTime? outwardDate;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? fileName;

  Outward({
    this.id,
    this.subInstituteId,
    this.syear,
    this.placeId,
    this.fileLocationId,
    this.outwardNumber,
    this.title,
    this.description,
    this.attachment,
    this.attachmentSize,
    this.attachmentType,
    this.acedemicYear,
    this.outwardDate,
    this.createdAt,
    this.updatedAt,
    this.fileName,
  });

  factory Outward.fromJson(Map<String, dynamic> json) => Outward(
        id: json["id"],
        subInstituteId: json["sub_institute_id"],
        syear: json["syear"],
        placeId: json["place_id"],
        fileLocationId: json["file_location_id"],
        outwardNumber: json["outward_number"] ?? json["inward_number"],
        title: json["title"],
        description: json["description"],
        attachment: json["attachment"],
        attachmentSize: json["attachment_size"],
        attachmentType: json["attachment_type"],
        acedemicYear: json["acedemic_year"],
        outwardDate: json["outward_date"] == null
            ? null
            : DateTime.parse(json["outward_date"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        fileName: json["file_name"],
      );
}
