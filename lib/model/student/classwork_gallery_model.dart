class ClassworkGalleryModel {
  final DateTime? fromDate;
  final DateTime? toDate;
  final List<ClassworkGallery>? sentData;

  ClassworkGalleryModel({
    this.fromDate,
    this.toDate,
    this.sentData,
  });

  factory ClassworkGalleryModel.fromJson(Map<String, dynamic> json) =>
      ClassworkGalleryModel(
        fromDate: json["from_date"] == null
            ? null
            : DateTime.parse(json["from_date"]),
        toDate:
            json["to_date"] == null ? null : DateTime.parse(json["to_date"]),
        sentData: json["sentData"] == null
            ? []
            : List<ClassworkGallery>.from(
                json["sentData"]!.map((x) => ClassworkGallery.fromJson(x))),
      );
}

class ClassworkGallery {
  final int? id;
  final String? title;
  final String? filePath;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;

  ClassworkGallery({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.title,
    this.filePath,
  });

  factory ClassworkGallery.fromJson(Map<String, dynamic> json) =>
      ClassworkGallery(
        id: json["id"],
        title: json["title"],
        filePath: json["file_path"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"] == null
            ? null
            : DateTime.parse(json["deleted_at"]),
      );
}
