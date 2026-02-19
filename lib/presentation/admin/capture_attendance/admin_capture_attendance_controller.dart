import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/model/student/home_data_model.dart';
import 'package:flutter/material.dart';
import 'package:scholar_clone/core/utils/api_client.dart';
import 'package:scholar_clone/core/utils/cs.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/core/utils/enum.dart';
import 'package:scholar_clone/model/admin/get_admin_standard_model.dart';
import 'package:scholar_clone/model/teacher/assign_homework/section_model.dart';

import '../../../model/admin/get_admin_student_list_model.dart';
import 'package:dio/dio.dart' as dio;

class AdminCaptureAttendanceController extends GetxController {
  Content data = Get.arguments[0];
  Map<String, dynamic> userInfo = Get.arguments[1];
  bool isAdmin = Get.arguments[2];

  Map<String, dynamic> resJson = <String, dynamic>{};

  SectionModel? sectionModel;
  GetAdminStandardModel? standardModel;
  GetAdminDivisionModel? divisionModel;
  GetAdminStudentListModel? studentModel;

  RxList<String> sectionName = <String>[].obs;
  RxList<String> stdName = <String>[].obs;
  RxList<String> divName = <String>[].obs;
  RxList<String> stdDivName = <String>[].obs;
  RxList<StudentModel> studentList = <StudentModel>[].obs;

  RxString selectStandard = "".obs;
  RxString selectDivision = "".obs;
  RxString selectSection = "".obs;
  RxString selectStdDiv = "".obs;

  RxInt stdId = 0.obs;
  RxInt divId = 0.obs;
  RxInt sectionID = 0.obs;
  RxInt mediaIndex = 0.obs;
  RxInt val = (-1).obs;

  RxString attendanceStutas = "".obs;

  RxBool isUpdate = false.obs;

  Rx<DateTime> selectedDate = DateTime.now().obs;

  RxList<String> images = <String>[].obs;

  @override
  void onInit() {
    if (isAdmin) {
      callServiceSection();
    } else {
      var list = userInfo["standard_division"].split(",");
      var div = userInfo["standard_division_title"].split(",");

      for (int i = 0; i < list.length; i++) {
        if (list[i] != "") {
          stdDivName.add(div[i].replaceAll("||", "-"));
        }
      }
    }
    super.onInit();
  }

  Future<void> callServiceSection() async {
    Map<String, dynamic> body = <String, dynamic>{
      CS.token: userInfo[CS.token],
      CS.sub_institute_id: userInfo[CS.sub_institute_id],
    };

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context!,
        body: body,
        apiUrl: "https://erp.triz.co.in/get_adminAcademicSection",
        isShowProgressDialog: false,
      );
    } else {
      CU.showNoInternetDialog(Get.context!, callServiceSection);
      return;
    }

    SectionModel model = SectionModel.fromJson(resJson);

    sectionModel = model;
    for (var i = 0; i < model.data!.length; i++) {
      sectionName.add(model.data![i].shortName!);
    }
  }

  Future<void> callServiceStandared(sectionID) async {
    Map<String, dynamic> adminBody = <String, dynamic>{
      CS.token: userInfo[CS.token],
      CS.sub_institute_id: userInfo[CS.sub_institute_id],
      "grade_id": sectionID
    };

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context,
        body: adminBody,
        apiUrl: "https://erp.triz.co.in/get_adminStandard",
        isShowProgressDialog: false,
      );
    } else {
      CU.showNoInternetDialog(Get.context!, callServiceStandared);
      return;
    }

    if (resJson[CS.status].toString() == StatusCode.Success) {
      GetAdminStandardModel model = GetAdminStandardModel.fromJson(resJson);
      standardModel = model;
      for (int i = 0; i < model.data!.length; i++) {
        stdName.add(model.data![i].name!);
      }
    } else if (resJson[CS.status].toString() == StatusCode.Error) {
      showDialog(
        builder: (context) => CU.showDiloag(context, resJson[CS.message]),
        barrierDismissible: true,
        context: Get.context!,
      );
    }
  }

  Future<void> callServiceDivision(standardId) async {
    Map<String, dynamic> body = <String, dynamic>{
      CS.token: userInfo[CS.token],
      "standard_id": standardId,
      CS.sub_institute_id: userInfo[CS.sub_institute_id],
    };

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context,
        body: body,
        apiUrl: "https://erp.triz.co.in/get_adminDivision",
        isShowProgressDialog: false,
      );
    } else {
      CU.showNoInternetDialog(Get.context!, callServiceStandared);
      return;
    }

    if (resJson[CS.status].toString() == StatusCode.Success) {
      GetAdminDivisionModel model = GetAdminDivisionModel.fromJson(resJson);
      divisionModel = model;
      for (int i = 0; i < model.data!.length; i++) {
        divName.add(model.data![i].name!);
      }
    } else if (resJson[CS.status].toString() == StatusCode.Error) {
      showDialog(
        builder: (context) => CU.showDiloag(context, resJson[CS.message]),
        barrierDismissible: false,
        context: Get.context!,
      );
    }
  }

  Future<void> callServiceImageVideoSubmit() async {
    dio.FormData formData = dio.FormData.fromMap({
      CS.syear: userInfo[CS.syear] ?? syear,
      CS.user_id: isAdmin ? userInfo[CS.user_id] : userInfo[CS.teacher_id],
      CS.sub_institute_id: userInfo[CS.sub_institute_id],
      "date": selectedDate.value,
      "standard_id": isAdmin ? stdId.value : selectStdDiv.split("||")[0].trim(),
      "division_id": isAdmin ? divId.value : selectStdDiv.split("||")[1].trim(),
      CS.token: userInfo["token"],
    });

    for (int i = 0; i < images.length; i++) {
      formData.files.addAll(
        [MapEntry("image[$i]", await dio.MultipartFile.fromFile(images[i]))],
      );
    }

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context!,
        body: formData,
        isFormData: false,
        apiUrl: "https://erp.triz.co.in/add_studentCaptureAttendanceAPI",
        isShowProgressDialog: false,
      );
    } else {
      CU.showNoInternetDialog(Get.context!, callServiceImageVideoSubmit);
      return;
    }

    if (resJson[CS.status].toString() == StatusCode.Success) {
      Fluttertoast.showToast(
        msg: resJson[CS.message],
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      Future.delayed(const Duration(milliseconds: 500), () {
        callgetStudentAttendance();
      });
    } else if (resJson[CS.status_code].toString() == StatusCode.Error ||
        resJson[CS.status].toString() == StatusCode.Authentication) {
      showDialog(
        builder: (context) => CU.showDiloag(context, resJson[CS.message]),
        barrierDismissible: false,
        context: Get.context!,
      );
    }
  }

  Future<void> callgetStudentAttendance() async {
    dio.FormData formData = dio.FormData.fromMap({
      CS.syear: userInfo[CS.syear] ?? syear,
      CS.sub_institute_id: userInfo[CS.sub_institute_id],
      "json_data":
          '[{"student_id": "97382","student_name": "EVAAN RAJESH RAFALIYA","enrollment_no": "9979176562","roll_no": 1,"attendance_code": "P","attendance_date": "2022-08-06","standard_id": "39","division_id": "9"},{"student_id": "100231","student_name": "komal H vala","enrollment_no": "664","roll_no": 1,"attendance_code": "P","attendance_date": "2022-08-06","standard_id": "39","division_id": "9"},{"student_id": "100235","student_name": "hemanshu b trivedi","enrollment_no": "668","roll_no": 5,"attendance_code": "A","attendance_date": "2022-08-06","standard_id": "39","division_id": "9"}]',
      CS.token: userInfo["token"],
    });

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context!,
        body: formData,
        isFormData: false,
        apiUrl: "https://erp.triz.co.in/get_attendanceDataAPI",
        isShowProgressDialog: false,
      );
    } else {
      CU.showNoInternetDialog(Get.context!, callgetStudentAttendance);
      return;
    }

    if (resJson[CS.status].toString() == StatusCode.Success) {
      resJson['data'].forEach((s) {
        studentList.add(StudentModel.fromJson(s));
      });
    } else if (resJson[CS.status_code].toString() == StatusCode.Error ||
        resJson[CS.status].toString() == StatusCode.Authentication) {
      showDialog(
        builder: (context) => CU.showDiloag(context, resJson[CS.message]),
        barrierDismissible: false,
        context: Get.context!,
      );
    }
  }

  Future<void> callServiceSubmit() async {
    Map<String, dynamic> body = <String, dynamic>{
      CS.syear: userInfo[CS.syear] ?? syear,
      CS.token: userInfo[CS.token],
      CS.sub_institute_id: userInfo[CS.sub_institute_id],
      CS.teacher_id: isAdmin ? userInfo[CS.user_id] : userInfo[CS.teacher_id],
      CS.user_profile_id: userInfo[CS.user_profile_id],
      CS.standard_division:
          isAdmin ? "$stdId||$divId" : userInfo[CS.standard_division],
      for (int i = 0; i < studentList.length; i++)
        "student[${studentList[i].standardId}]": studentList[i].attendance,
      "date": selectedDate.value,
      "type": "API"
    };

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context!,
        body: body,
        apiUrl: "https://erp.triz.co.in/student/save_student_attendance",
        isShowProgressDialog: false,
      );
    } else {
      CU.showNoInternetDialog(Get.context!, callServiceSubmit);
      return;
    }

    if (resJson[CS.status].toString() == StatusCode.Success) {
      Fluttertoast.showToast(
        msg: resJson[CS.message],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      Get.back();
    } else if (resJson[CS.status_code].toString() == StatusCode.Error ||
        resJson[CS.status].toString() == StatusCode.Authentication) {
      showDialog(
        builder: (context) => CU.showDiloag(context, resJson[CS.message]),
        barrierDismissible: false,
        context: Get.context!,
      );
    }
  }
}

class StudentModel {
  StudentModel({
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
    this.attendance,
  });

  final int? id;
  final String? studentName;
  final String? enrollmentNo;
  final int? rollNo;
  final DateTime? dob;
  final String? address;
  final String? mobile;
  final String? email;
  final String? studentImage;
  final int? standardId;
  final int? divisionId;
  final String? standardName;
  final String? divisionName;
  String? attendance;

  factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
        id: json['student_id'] == null
            ? json["id"]
            : int.parse(json['student_id']),
        studentName: json["student_name"],
        enrollmentNo: json["enrollment_no"],
        rollNo: json["roll_no"],
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        address: json["address"],
        mobile: json["mobile"],
        email: json["email"],
        studentImage: json["student_image"],
        standardId: int.parse(json["standard_id"].toString()),
        divisionId: int.parse(json["division_id"].toString()),
        standardName: json["standard_name"],
        divisionName: json["division_name"],
        attendance: json["attendance_code"] ?? "",
      );
}
