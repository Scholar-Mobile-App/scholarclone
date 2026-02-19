import 'dart:convert';

AdminTeacherProfileModel adminProfileModelFromJson(String str) =>
    AdminTeacherProfileModel.fromJson(json.decode(str));

String adminProfileModelToJson(AdminTeacherProfileModel data) =>
    json.encode(data.toJson());

class AdminTeacherProfileModel {
  int? status;
  List<AdminTeacherProfile>? data;

  AdminTeacherProfileModel({
    this.status,
    this.data,
  });

  factory AdminTeacherProfileModel.fromJson(Map<String, dynamic> json) =>
      AdminTeacherProfileModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<AdminTeacherProfile>.from(
                json["data"]!.map((x) => AdminTeacherProfile.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class AdminTeacherProfile {
  int? id;
  String? userName;
  String? userFullName;
  String? firstName;
  String? middleName;
  String? lastName;
  int? subInstituteId;
  String? email;
  String? mobile;
  DateTime? birthdate;
  String? address;
  String? gender;
  String? joinYear;
  String? image;
  String? userProfileName;
  int? userProfileId;

  AdminTeacherProfile({
    this.id,
    this.userName,
    this.userFullName,
    this.firstName,
    this.middleName,
    this.lastName,
    this.subInstituteId,
    this.email,
    this.mobile,
    this.birthdate,
    this.address,
    this.gender,
    this.joinYear,
    this.image,
    this.userProfileName,
    this.userProfileId,
  });

  factory AdminTeacherProfile.fromJson(Map<String, dynamic> json) =>
      AdminTeacherProfile(
        id: json["id"],
        userName: json["user_name"],
        userFullName: json["user_full_name"],
        firstName: json["first_name"],
        middleName: json["middle_name"],
        lastName: json["last_name"],
        subInstituteId: json["sub_institute_id"],
        email: json["email"],
        mobile: json["mobile"],
        birthdate: json["birthdate"] == null
            ? null
            : DateTime.parse(json["birthdate"]),
        address: json["address"],
        gender: json["gender"],
        joinYear: json["join_year"],
        image: json["image"],
        userProfileName: json["user_profile_name"],
        userProfileId: json["user_profile_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_name": userName,
        "user_full_name": userFullName,
        "first_name": firstName,
        "middle_name": middleName,
        "last_name": lastName,
        "sub_institute_id": subInstituteId,
        "email": email,
        "mobile": mobile,
        "birthdate":
            "${birthdate!.year.toString().padLeft(4, '0')}-${birthdate!.month.toString().padLeft(2, '0')}-${birthdate!.day.toString().padLeft(2, '0')}",
        "address": address,
        "gender": gender,
        "join_year": joinYear,
        "image": image,
        "user_profile_name": userProfileName,
        "user_profile_id": userProfileId,
      };
}
