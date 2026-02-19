import 'dart:convert';

StudentListModel studentListModelFromJson(String str) =>
    StudentListModel.fromJson(json.decode(str));

String studentListModelToJson(StudentListModel data) =>
    json.encode(data.toJson());

class StudentListModel {
  int? status;
  String? message;
  List<Student>? data;

  StudentListModel({
    this.status,
    this.message,
    this.data,
  });

  factory StudentListModel.fromJson(Map<String, dynamic> json) =>
      StudentListModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Student>.from(json["data"]!.map((x) => Student.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Student {
  int? id;
  String? studentName;
  String? enrollmentNo;
  int? rollNo;
  String? dob;
  String? address;
  String? mobile;
  String? email;
  String? studentImage;
  int? standardId;
  int? divisionId;
  String? standardName;
  String? divisionName;
  double? points;

  Student({
    this.id,
    this.studentName,
    this.enrollmentNo,
    this.rollNo,
    this.dob,
    this.address,
    this.mobile,
    this.email,
    this.studentImage,
    this.standardId,
    this.divisionId,
    this.standardName,
    this.divisionName,
    this.points,
  });

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        id: json["id"],
        studentName: json["student_name"],
        enrollmentNo: json["enrollment_no"],
        rollNo: json["roll_no"],
        dob: json["dob"],
        address: json["address"],
        mobile: json["mobile"],
        email: json["email"],
        studentImage: json["student_image"],
        standardId: json["standard_id"],
        divisionId: json["division_id"],
        standardName: json["standard_name"],
        divisionName: json["division_name"],
        points: 0.0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "student_name": studentName,
        "enrollment_no": enrollmentNo,
        "roll_no": rollNo,
        "dob": dob,
        "address": address,
        "mobile": mobile,
        "email": email,
        "student_image": studentImage,
        "standard_id": standardId,
        "division_id": divisionId,
        "standard_name": standardName,
        "division_name": divisionName,
      };
}
