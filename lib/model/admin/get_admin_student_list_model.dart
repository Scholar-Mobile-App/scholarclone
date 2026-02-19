import 'dart:convert';

GetAdminStudentListModel getAdminStudentListModelFromJson(String str) =>
    GetAdminStudentListModel.fromJson(json.decode(str));

String getAdminStudentListModelToJson(GetAdminStudentListModel data) =>
    json.encode(data.toJson());

class GetAdminStudentListModel {
  int? status;
  List<AdminStudent>? data;

  GetAdminStudentListModel({
    this.status,
    this.data,
  });

  factory GetAdminStudentListModel.fromJson(Map<String, dynamic> json) =>
      GetAdminStudentListModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<AdminStudent>.from(
                json["data"]!.map((x) => AdminStudent.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class AdminStudent {
  int? id;
  String? studentName;
  int? syear;
  String? enrollmentNo;
  int? rollNo;
  String? dob;
  String? address;
  String? mobile;
  String? email;
  String? studentImage;
  int? standardId;
  int? divisionId;
  String? academicSection;
  String? standardName;
  String? divisionName;
  String? gender;
  int? admissionYear;
  String? motherName;
  String? fatherName;

  AdminStudent({
    this.id,
    this.studentName,
    this.syear,
    this.enrollmentNo,
    this.rollNo,
    this.dob,
    this.address,
    this.mobile,
    this.email,
    this.studentImage,
    this.standardId,
    this.divisionId,
    this.academicSection,
    this.standardName,
    this.divisionName,
    this.gender,
    this.admissionYear,
    this.motherName,
    this.fatherName,
  });

  factory AdminStudent.fromJson(Map<String, dynamic> json) => AdminStudent(
        id: json["id"],
        studentName: json["student_name"],
        syear: json["syear"],
        enrollmentNo: json["enrollment_no"],
        rollNo: json["roll_no"],
        dob: json["dob"],
        address: json["address"],
        mobile: json["mobile"],
        email: json["email"],
        studentImage: json["student_image"],
        standardId: json["standard_id"],
        divisionId: json["division_id"],
        academicSection: json["academic_section"],
        standardName: json["standard_name"],
        divisionName: json["division_name"],
        gender: json["gender"],
        admissionYear: json["admission_year"],
        motherName: json["mother_name"],
        fatherName: json["father_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "student_name": studentName,
        "syear": syear,
        "enrollment_no": enrollmentNo,
        "roll_no": rollNo,
        "dob": dob,
        "address": address,
        "mobile": mobile,
        "email": email,
        "student_image": studentImage,
        "standard_id": standardId,
        "division_id": divisionId,
        "academic_section": academicSection,
        "standard_name": standardName,
        "division_name": divisionName,
        "gender": gender,
        "admission_year": admissionYear,
        "mother_name": motherName,
        "father_name": fatherName,
      };
}
