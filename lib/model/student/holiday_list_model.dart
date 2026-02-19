import 'dart:convert';

HolidayListModel holidayListModelFromJson(String str) =>
    HolidayListModel.fromJson(json.decode(str));

String holidayListModelToJson(HolidayListModel data) =>
    json.encode(data.toJson());

class HolidayListModel {
  int? status;
  String? message;
  List<Holiday>? data;

  HolidayListModel({
    this.status,
    this.message,
    this.data,
  });

  factory HolidayListModel.fromJson(Map<String, dynamic> json) =>
      HolidayListModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Holiday>.from(json["data"]!.map((x) => Holiday.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Holiday {
  DateTime? schoolDate;
  String? title;
  String? description;
  String? eventType;

  Holiday({
    this.schoolDate,
    this.title,
    this.description,
    this.eventType,
  });

  factory Holiday.fromJson(Map<String, dynamic> json) => Holiday(
        schoolDate: json["school_date"] == null
            ? null
            : DateTime.parse(json["school_date"]),
        title: json["title"],
        description: json["description"],
        eventType: json["event_type"],
      );

  Map<String, dynamic> toJson() => {
        "school_date":
            "${schoolDate!.year.toString().padLeft(4, '0')}-${schoolDate!.month.toString().padLeft(2, '0')}-${schoolDate!.day.toString().padLeft(2, '0')}",
        "title": title,
        "description": description,
        "event_type": eventType,
      };
}
