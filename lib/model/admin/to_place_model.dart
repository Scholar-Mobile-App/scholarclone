import 'dart:convert';

ToPlaceModel toPlaceModelFromJson(String str) =>
    ToPlaceModel.fromJson(json.decode(str));

String toPlaceModelToJson(ToPlaceModel data) => json.encode(data.toJson());

class ToPlaceModel {
  List<ToPlace>? data;

  ToPlaceModel({
    this.data,
  });

  factory ToPlaceModel.fromJson(Map<String, dynamic> json) => ToPlaceModel(
        data: json["data"] == null
            ? []
            : List<ToPlace>.from(json["data"]!.map((x) => ToPlace.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ToPlace {
  int? id;
  int? subInstituteId;
  String? title;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;

  ToPlace({
    this.id,
    this.subInstituteId,
    this.title,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory ToPlace.fromJson(Map<String, dynamic> json) => ToPlace(
        id: json["id"],
        subInstituteId: json["sub_institute_id"],
        title: json["title"],
        description: json["description"],
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
        "description": description,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
