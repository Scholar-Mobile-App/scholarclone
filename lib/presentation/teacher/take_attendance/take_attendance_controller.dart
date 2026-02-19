import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/api_client.dart';
import 'package:scholar_clone/core/utils/cs.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/core/utils/enum.dart';
import 'package:scholar_clone/model/student/home_data_model.dart';

class TakeAttendanceController extends GetxController {
  @override
  void onInit() {
    var list = userInfo["standard_division"].split(",");
    var div = userInfo["standard_division_title"].split(",");
    for (int i = 0; i < list.length; i++) {
      if (list[i] != "") {
        log('Triz-->${div[i].replaceAll("||", "-")}');
        divName.add(div[i].replaceAll("||", "-"));
      }
    }
    super.onInit();
  }

  RxList<String> divName = <String>[].obs;
  RxList<StudentModel> studentList = <StudentModel>[].obs;

  Rx<DateTime> selectedDate = DateTime.now().obs;

  Map<String, dynamic> resJson = <String, dynamic>{};

  RxInt val = (-1).obs;

  RxBool isUpdate = false.obs;

  Content data = Get.arguments[0];
  Map<String, dynamic> userInfo = Get.arguments[1];

  RxString stdDiv = "".obs;
  RxString attendanceStutas = "".obs;

  Future<void> callServiceAllocate(stdDiv) async {
    var string = stdDiv;
    var ans = string.split("||");
    Map<String, dynamic> body = <String, dynamic>{
      CS.token: userInfo[CS.token],
      "standard_id": ans[0].trim(),
      "division_id": ans[1].trim(),
      CS.teacher_id: userInfo[CS.teacher_id],
      CS.syear: userInfo[CS.syear] ?? syear,
      CS.type: "API",
      CS.sub_institute_id: userInfo[CS.sub_institute_id],
    };

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context,
        body: body,
        apiUrl: "https://erp.triz.co.in/allStudentListAPI",
        isShowProgressDialog: false,
      );
    } else {
      CU.showNoInternetDialog(Get.context!, callServiceAllocate);
      return;
    }

    if (resJson[CS.status].toString() == StatusCode.Success) {
      resJson[CS.data].forEach((s) {
        studentList.add(StudentModel.fromJson(s));
      });
    } else if (resJson[CS.status].toString() == StatusCode.Error) {
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
      CS.teacher_id: userInfo[CS.teacher_id],
      CS.user_profile_id: userInfo[CS.user_profile_id],
      CS.standard_division: userInfo[CS.standard_division],
      for (int i = 0; i < studentList.length; i++)
        "student[${studentList[i].studentId}]": studentList[i].attendance,
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
    this.studentId,
    this.studentName,
    this.enrollmentNo,
    this.rollNo,
    this.attendance,
  });

  final int? studentId;
  final String? studentName;
  final String? enrollmentNo;
  final int? rollNo;
  String? attendance;

  factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
        studentId: json["id"],
        studentName: json["student_name"],
        enrollmentNo: json["enrollment_no"],
        rollNo: json["roll_no"],
        attendance: "",
      );
}
