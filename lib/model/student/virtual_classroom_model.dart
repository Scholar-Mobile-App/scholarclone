import 'dart:convert';

VirtualClassroomModel virtualClassroomModelFromJson(String str) =>
    VirtualClassroomModel.fromJson(json.decode(str));

String virtualClassroomModelToJson(VirtualClassroomModel data) =>
    json.encode(data.toJson());

class VirtualClassroomModel {
  int? status;
  String? message;
  List<VirtualClassroom>? data;

  VirtualClassroomModel({
    this.status,
    this.message,
    this.data,
  });

  factory VirtualClassroomModel.fromJson(Map<String, dynamic> json) =>
      VirtualClassroomModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<VirtualClassroom>.from(
                json["data"]!.map((x) => VirtualClassroom.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class VirtualClassroom {
  String? standardName;
  String? subjectName;
  String? chapterName;
  String? topicName;
  int? syear;
  int? subInstituteId;
  String? roomName;
  String? description;
  DateTime? eventDate;
  String? fromTime;
  String? toTime;
  String? recurring;
  String? url;
  String? password;
  String? teacherName;

  VirtualClassroom({
    this.standardName,
    this.subjectName,
    this.chapterName,
    this.topicName,
    this.syear,
    this.subInstituteId,
    this.roomName,
    this.description,
    this.eventDate,
    this.fromTime,
    this.toTime,
    this.recurring,
    this.url,
    this.password,
    this.teacherName,
  });

  factory VirtualClassroom.fromJson(Map<String, dynamic> json) =>
      VirtualClassroom(
        standardName: json["standard_name"],
        subjectName: json["subject_name"],
        chapterName: json["chapter_name"],
        topicName: json["topic_name"],
        syear: json["syear"],
        subInstituteId: json["sub_institute_id"],
        roomName: json["room_name"],
        description: json["description"],
        eventDate: json["event_date"] == null
            ? null
            : DateTime.parse(json["event_date"]),
        fromTime: json["from_time"],
        toTime: json["to_time"],
        recurring: json["recurring"],
        url: json["url"],
        password: json["password"],
        teacherName: json["teacher_name"],
      );

  Map<String, dynamic> toJson() => {
        "standard_name": standardName,
        "subject_name": subjectName,
        "chapter_name": chapterName,
        "topic_name": topicName,
        "syear": syear,
        "sub_institute_id": subInstituteId,
        "room_name": roomName,
        "description": description,
        "event_date":
            "${eventDate!.year.toString().padLeft(4, '0')}-${eventDate!.month.toString().padLeft(2, '0')}-${eventDate!.day.toString().padLeft(2, '0')}",
        "from_time": fromTime,
        "to_time": toTime,
        "recurring": recurring,
        "url": url,
        "password": password,
        "teacher_name": teacherName,
      };
}
