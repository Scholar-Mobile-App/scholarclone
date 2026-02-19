import 'dart:convert';

TransportModel transportModelFromJson(String str) =>
    TransportModel.fromJson(json.decode(str));

String transportModelToJson(TransportModel data) => json.encode(data.toJson());

class TransportModel {
  int? status;
  String? message;
  List<Transport>? data;

  TransportModel({
    this.status,
    this.message,
    this.data,
  });

  factory TransportModel.fromJson(Map<String, dynamic> json) => TransportModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Transport>.from(
                json["data"]!.map((x) => Transport.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Transport {
  int? id;
  int? studentId;
  String? fromShift;
  String? fromBus;
  String? fromStopName;
  String? toShift;
  String? toBus;
  String? toStopName;
  String ? gpsLink;

  Transport({
    this.id,
    this.studentId,
    this.fromShift,
    this.fromBus,
    this.fromStopName,
    this.toShift,
    this.toBus,
    this.toStopName,
    this.gpsLink
  });

  factory Transport.fromJson(Map<String, dynamic> json) => Transport(
        id: json["id"],
        studentId: json["student_id"],
        fromShift: json["from_shift"],
        fromBus: json["from_bus"],
        fromStopName: json["from_stop_name"],
        toShift: json["to_shift"],
        toBus: json["to_bus"],
        toStopName: json["to_stop_name"],
        gpsLink: json["gps_link"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "student_id": studentId,
        "from_shift": fromShift,
        "from_bus": fromBus,
        "from_stop_name": fromStopName,
        "to_shift": toShift,
        "to_bus": toBus,
        "to_stop_name": toStopName,
        "gps_link" : gpsLink,
      };
}
