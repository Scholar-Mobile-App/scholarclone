import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/core/utils/enum.dart';
import 'package:scholar_clone/model/student/result_of_practice_model.dart';
import 'package:scholar_clone/model/student/test_report_model.dart';

import '../../../core/utils/api_client.dart';
import '../../../core/utils/cs.dart';

class TestReportController extends GetxController {
  AttemptedDatum data = Get.arguments[0];
  var userInfo = Get.arguments[1];

  RxList<dynamic> practiceList = <dynamic>[].obs;

  Map<String, dynamic>? resJson;

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    callService();
    super.onInit();
  }

  Future<void> callService() async {
    isLoading.value = true;
    Map<String, dynamic> body = <String, dynamic>{
      CS.syear: userInfo[CS.syear] ?? syear,
      CS.sub_institute_id: userInfo[CS.sub_institute_id],
      CS.student_id: userInfo[CS.student_id],
      CS.token: userInfo[CS.token],
      "online_exam_id": data.onlineExamId
    };

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context!,
        body: jsonEncode(body),
        apiUrl: "https://erp.triz.co.in/studentAssessmentDetailAPI",
        isShowProgressDialog: false,
        isFormData: false,
      );
    } else {
      CU.showNoInternetDialog(Get.context!, callService);
      return;
    }

    if (resJson![CS.status].toString() == StatusCode.Success) {
      ResultOfPractice model = ResultOfPractice.fromJson(resJson!);

      practiceList.value = resJson![CS.data]["online_answer_data"];

      // practiceList = resJson[CS.data]["online_answer_data"];
    } else if (resJson![CS.status].toString() == StatusCode.Error) {
      showDialog(
        builder: (context) => CU.showDiloag(context, resJson![CS.message]),
        barrierDismissible: false,
        context: Get.context!,
      );
    }

    isLoading.value = false;
  }
}
