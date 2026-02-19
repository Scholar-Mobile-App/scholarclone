import 'dart:convert';

StudentFaceAttendanceModel studentFaceAttendanceModelFromJson(String str) =>
    StudentFaceAttendanceModel.fromJson(json.decode(str));

String studentFaceAttendanceModelToJson(StudentFaceAttendanceModel data) =>
    json.encode(data.toJson());

class StudentFaceAttendanceModel {
  int? status;
  String? message;
  List<FaceAttendance>? data;

  StudentFaceAttendanceModel({
    this.status,
    this.message,
    this.data,
  });

  factory StudentFaceAttendanceModel.fromJson(Map<String, dynamic> json) =>
      StudentFaceAttendanceModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<FaceAttendance>.from(
                json["data"]!.map((x) => FaceAttendance.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class FaceAttendance {
  int? syear;
  int? subInstituteId;
  int? studentId;
  String? stuImage;

  FaceAttendance({
    this.syear,
    this.subInstituteId,
    this.studentId,
    this.stuImage,
  });

  factory FaceAttendance.fromJson(Map<String, dynamic> json) => FaceAttendance(
        syear: json["syear"],
        subInstituteId: json["sub_institute_id"],
        studentId: json["student_id"],
        stuImage: json["stu_image"],
      );

  Map<String, dynamic> toJson() => {
        "syear": syear,
        "sub_institute_id": subInstituteId,
        "student_id": studentId,
        "stu_image": stuImage,
      };
}
