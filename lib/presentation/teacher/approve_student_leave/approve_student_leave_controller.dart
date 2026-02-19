import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/cs.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/core/utils/enum.dart';
import 'package:scholar_clone/model/student/home_data_model.dart';
import 'package:scholar_clone/model/teacher/students_leaves_approve_model.dart';

import '../../../core/utils/api_client.dart';

class ApproveStudentLeaveController extends GetxController {
  @override
  void onInit() {
    callService();
    super.onInit();
  }

  Content data = Get.arguments[0];
  Map<String, dynamic> userInfo = Get.arguments[1];

  Map<String, dynamic> resJson = <String, dynamic>{};

  RxBool isLoading = false.obs;

  RxList<StudentLeaves> studentsLeavesList = <StudentLeaves>[].obs;

  Future<void> callService() async {
    isLoading.value = true;

    Map<String, dynamic> body = <String, dynamic>{
      CS.syear: userInfo[CS.syear] ?? syear,
      CS.sub_institute_id: userInfo[CS.sub_institute_id],
      CS.teacher_id: userInfo[CS.teacher_id],
      CS.token: userInfo[CS.token]
    };

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context!,
        body: body,
        apiUrl: "https://erp.triz.co.in/teacherLeaveApplicationListAPI",
        isShowProgressDialog: false,
      );
    } else {
      return;
    }

    if (resJson[CS.status].toString() == StatusCode.Success) {
      StudentLeavesApproveModel model =
          StudentLeavesApproveModel.fromJson(resJson);

      for (var i = 0; i < model.data!.length; i++) {
        studentsLeavesList.add(model.data![i]);
      }
    } else if (resJson[CS.status].toString() == StatusCode.Error) {
      showDialog(
        builder: (context) => CU.showDiloag(context, resJson[CS.message]),
        barrierDismissible: false,
        context: Get.context!,
      );
    }
    isLoading.value = false;
  }

  Future<void> callServiceReply(StudentLeaves lstData, String status) async {
    Map<String, dynamic> body = <String, dynamic>{
      CS.teacher_id: userInfo[CS.teacher_id],
      "leave_app_id": lstData.leaveAppId,
      "reply": lstData.reply?.text ?? "",
      "status": status,
      CS.sub_institute_id: userInfo[CS.sub_institute_id],
      CS.syear: userInfo["syear"] ?? syear,
      CS.token: userInfo[CS.token]
    };

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context!,
        body: body,
        apiUrl: "https://erp.triz.co.in/teacherLeaveApplicationSaveAPI",
        isShowProgressDialog: false,
      );
    } else {
      // CU.showNoInternetDiloag(context, callService);
      return;
    }

    if (resJson[CS.status].toString() == StatusCode.Success) {
      studentsLeavesList.clear();
      callService();
    } else if (resJson[CS.status].toString() == StatusCode.Error) {
      showDialog(
        builder: (context) => CU.showDiloag(context, resJson[CS.message]),
        barrierDismissible: false,
        context: Get.context!,
      );
    }
  }
}
