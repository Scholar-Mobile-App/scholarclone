import 'dart:convert';

NotificationModel notificationModelFromJson(String str) =>
    NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) =>
    json.encode(data.toJson());

class NotificationModel {
  int? status;
  String? message;
  List<Note>? data;

  NotificationModel({
    this.status,
    this.message,
    this.data,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Note>.from(json["data"]!.map((x) => Note.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Note {
  int? id;
  String? notificationType;
  int? studentId;
  int? status;
  String? notificationDescription;
  String? notificationDate;
  String? image;
  String? sideImage;
  String? colorCode;

  Note({
    this.id,
    this.notificationType,
    this.studentId,
    this.status,
    this.notificationDescription,
    this.notificationDate,
    this.image,
    this.sideImage,
    this.colorCode,
  });

  factory Note.fromJson(Map<String, dynamic> json) => Note(
        id: json["ID"],
        notificationType: json["NOTIFICATION_TYPE"] ?? "",
        studentId: json["STUDENT_ID"],
        status: json["Status"],
        notificationDescription: json["NOTIFICATION_DESCRIPTION"],
        notificationDate: json["NOTIFICATION_DATE"],
        image: json["image"],
        sideImage: json["side_image"],
        colorCode: "color_code",
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "NOTIFICATION_TYPE": notificationType,
        "STUDENT_ID": studentId,
        "Status": status,
        "NOTIFICATION_DESCRIPTION": notificationDescription,
        "NOTIFICATION_DATE": notificationDate,
        "image": image,
        "side_image": sideImage,
        "color_code": colorCode,
      };
}
