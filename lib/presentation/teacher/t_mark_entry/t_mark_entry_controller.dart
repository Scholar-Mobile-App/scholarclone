import 'dart:convert';

import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/api_client.dart';
import 'package:scholar_clone/core/utils/cs.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/core/utils/utility.dart';
import 'package:scholar_clone/model/student/home_data_model.dart';
import 'package:flutter/material.dart';
import 'package:scholar_clone/core/utils/enum.dart';
import 'package:scholar_clone/model/teacher/assign_homework/studen_list_model.dart';

class MarksEntryResultController extends GetxController {
  Content data = Get.arguments[0];
  Map<String, dynamic> userInfo = Get.arguments[1];

  String divisionName = Get.arguments[2];

  String examName = Get.arguments[3];
  String standardName = Get.arguments[4];
  String subjectName = Get.arguments[5];
  int divID = Get.arguments[6];
  int stdID = Get.arguments[7];
  int examID = Get.arguments[8];
  int tarmID = Get.arguments[9];

  Map<String, dynamic> resJson = <String, dynamic>{};

  RxList<Student> studentList = <Student>[].obs;

  @override
  void onInit() {
    callServiceStudentList();
    super.onInit();
  }

  Future<void> callServiceStudentList() async {
    Map<String, dynamic> body = <String, dynamic>{
      CS.type: "API",
      CS.syear: userInfo[CS.syear] ?? syear,
      CS.teacher_id: userInfo[CS.teacher_id],
      CS.sub_institute_id: userInfo[CS.sub_institute_id],
      CS.token: userInfo["token"],
      "standard_id": stdID,
      "division_id": divID,
    };

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context,
        body: body,
        apiUrl: "https://erp.triz.co.in/allStudentListAPI",
        isShowProgressDialog: false,
      );
    } else {
      CU.showNoInternetDialog(Get.context!, callServiceStudentList());
      return;
    }

    if (resJson[CS.status].toString() == StatusCode.Success) {
      resJson[CS.data].forEach((s) {
        studentList.add(Student.fromJson(s));
      });
    } else if (resJson[CS.status].toString() == StatusCode.Error) {
      showDialog(
        builder: (context) => CU.showDiloag(context, resJson[CS.message]),
        barrierDismissible: false,
        context: Get.context!,
      );
    }
  }

  Future<void> callServiceSubmit(context) async {
    Map data = {
      for (var item in studentList)
        "${item.id}": {
          "exam_id": examID,
          "points": item.points,
          "per": "${(item.points! / 20) * 100}%",
          "grade": "-",
          "comment": "-"
        }
    };

    Map<String, dynamic> body = <String, dynamic>{
      "data": jsonEncode(data),
      CS.type: "API",
      CS.sub_institute_id: userInfo[CS.sub_institute_id],
    };

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        context,
        body: body,
        apiUrl: "https://erp.triz.co.in/result/marks_entry",
        isShowProgressDialog: false,
      );
    } else {
      CU.showNoInternetDialog(context, callServiceSubmit);
      return;
    }

    if (resJson[CS.status].toString() == StatusCode.Success) {
      showToast(
        context: context,
        message: resJson[CS.message],
        color: Colors.green,
        icons: Icons.check_circle_outline,
      );
      Get.back();
    } else if (resJson[CS.status].toString() == StatusCode.Error) {
      showDialog(
        builder: (context) => CU.showDiloag(context, resJson[CS.message]),
        barrierDismissible: false,
        context: context,
      );
    }
  }
}
