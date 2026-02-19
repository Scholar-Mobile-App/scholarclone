import 'dart:convert';

HostelDetailsModel hostelDetailsModelFromJson(String str) =>
    HostelDetailsModel.fromJson(json.decode(str));

String hostelDetailsModelToJson(HostelDetailsModel data) =>
    json.encode(data.toJson());

class HostelDetailsModel {
  int? statusCode;
  String? message;
  List<HostelDetails>? data;

  HostelDetailsModel({
    this.statusCode,
    this.message,
    this.data,
  });

  factory HostelDetailsModel.fromJson(Map<String, dynamic> json) =>
      HostelDetailsModel(
        statusCode: json["status_code"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<HostelDetails>.from(
                json["data"]!.map((x) => HostelDetails.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class HostelDetails {
  int? hostelId;
  int? roomId;
  String? bedNo;
  String? lockerNo;
  String? tableNo;
  String? bedsheetNo;
  String? hostelName;
  String? description;
  String? warden;
  String? wardenContact;
  String? roomName;

  HostelDetails({
    this.hostelId,
    this.roomId,
    this.bedNo,
    this.lockerNo,
    this.tableNo,
    this.bedsheetNo,
    this.hostelName,
    this.description,
    this.warden,
    this.wardenContact,
    this.roomName,
  });

  factory HostelDetails.fromJson(Map<String, dynamic> json) => HostelDetails(
        hostelId: json["hostel_id"],
        roomId: json["room_id"],
        bedNo: json["bed_no"],
        lockerNo: json["locker_no"],
        tableNo: json["table_no"],
        bedsheetNo: json["bedsheet_no"],
        hostelName: json["hostel_name"],
        description: json["description"],
        warden: json["warden"],
        wardenContact: json["warden_contact"],
        roomName: json["room_name"],
      );

  Map<String, dynamic> toJson() => {
        "hostel_id": hostelId,
        "room_id": roomId,
        "bed_no": bedNo,
        "locker_no": lockerNo,
        "table_no": tableNo,
        "bedsheet_no": bedsheetNo,
        "hostel_name": hostelName,
        "description": description,
        "warden": warden,
        "warden_contact": wardenContact,
        "room_name": roomName,
      };
}
