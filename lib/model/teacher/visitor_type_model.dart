import 'dart:convert';

VisitorTypeModel visitorTypeModelFromJson(String str) =>
    VisitorTypeModel.fromJson(json.decode(str));

String visitorTypeModelToJson(VisitorTypeModel data) =>
    json.encode(data.toJson());

class VisitorTypeModel {
  List<VisitorTypeDatum>? visitorTypeData;
  List<ToMeetArray>? toMeetArray;

  VisitorTypeModel({
    this.visitorTypeData,
    this.toMeetArray,
  });

  factory VisitorTypeModel.fromJson(Map<String, dynamic> json) =>
      VisitorTypeModel(
        visitorTypeData: json["visitor_type_data"] == null
            ? []
            : List<VisitorTypeDatum>.from(json["visitor_type_data"]!
                .map((x) => VisitorTypeDatum.fromJson(x))),
        toMeetArray: json["to_meet_array"] == null
            ? []
            : List<ToMeetArray>.from(
                json["to_meet_array"]!.map((x) => ToMeetArray.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "visitor_type_data": visitorTypeData == null
            ? []
            : List<dynamic>.from(visitorTypeData!.map((x) => x.toJson())),
        "to_meet_array": toMeetArray == null
            ? []
            : List<dynamic>.from(toMeetArray!.map((x) => x.toJson())),
      };
}

class ToMeetArray {
  int? id;
  String? staffName;
  String? fullName;

  ToMeetArray({
    this.id,
    this.staffName,
    this.fullName,
  });

  factory ToMeetArray.fromJson(Map<String, dynamic> json) => ToMeetArray(
        id: json["id"],
        staffName: json["staff_name"],
        fullName: json["full_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "staff_name": staffName,
        "full_name": fullName,
      };
}

class VisitorTypeDatum {
  int? id;
  String? title;
  int? status;
  int? subInstituteId;

  VisitorTypeDatum({
    this.id,
    this.title,
    this.status,
    this.subInstituteId,
  });

  factory VisitorTypeDatum.fromJson(Map<String, dynamic> json) =>
      VisitorTypeDatum(
        id: json["id"],
        title: json["title"],
        status: json["status"],
        subInstituteId: json["sub_institute_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "status": status,
        "sub_institute_id": subInstituteId,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
