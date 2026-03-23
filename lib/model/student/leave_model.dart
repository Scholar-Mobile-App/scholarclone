import 'dart:convert';

LeaveModel leaveModelFromJson(String str) =>
    LeaveModel.fromJson(json.decode(str));

String leaveModelToJson(LeaveModel data) => json.encode(data.toJson());

/// Helper method to parse date in format "dd-MM-yyyy HH:mm:ss"
DateTime? _parseDate(String? dateString) {
  if (dateString == null || dateString.isEmpty) return null;
  try {
    // Try parsing as ISO 8601 first
    return DateTime.parse(dateString);
  } catch (_) {
    try {
      // Try parsing as "dd-MM-yyyy HH:mm:ss"
      final parts = dateString.split(' ');
      if (parts.length == 2) {
        final dateParts = parts[0].split('-');
        final timeParts = parts[1].split(':');
        if (dateParts.length == 3 && timeParts.length >= 3) {
          return DateTime(
            int.parse(dateParts[2]), // year
            int.parse(dateParts[1]), // month
            int.parse(dateParts[0]), // day
            int.parse(timeParts[0]), // hour
            int.parse(timeParts[1]), // minute
            int.parse(timeParts[2]), // second
          );
        }
      }
      return null;
    } catch (_) {
      return null;
    }
  }
}

class LeaveModel {
  int? status;
  String? message;
  List<Leave>? data;

  LeaveModel({
    this.status,
    this.message,
    this.data,
  });

  factory LeaveModel.fromJson(Map<String, dynamic> json) => LeaveModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Leave>.from(json["data"]!.map((x) => Leave.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Leave {
  String? title;
  String? message;
  String? files;
  DateTime? applyDate;
  DateTime? fromDate;
  DateTime? toDate;
  String? status;
  String? reply;
  DateTime? replyOn;

  Leave({
    this.title,
    this.message,
    this.files,
    this.applyDate,
    this.fromDate,
    this.toDate,
    this.status,
    this.reply,
    this.replyOn,
  });

  factory Leave.fromJson(Map<String, dynamic> json) => Leave(
        title: json["title"] ?? "",
        message: json["message"] ?? "",
        files: json["files"],
        applyDate: _parseDate(json["apply_date"]),
        fromDate: _parseDate(json["from_date"]),
        toDate: _parseDate(json["to_date"]),
        status: json["status"] ?? "",
        reply: json["reply"] ?? "",
        replyOn: _parseDate(json["reply_on"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "message": message,
        "files": files,
        "apply_date": applyDate?.toIso8601String(),
        "from_date": fromDate?.toIso8601String(),
        "to_date": toDate?.toIso8601String(),
        "status": status,
        "reply": reply,
        "reply_on": replyOn?.toIso8601String(),
      };
}
