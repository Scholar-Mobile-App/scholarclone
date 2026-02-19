import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/api_client.dart';
import 'package:scholar_clone/core/utils/enum.dart';
import 'package:scholar_clone/model/student/lms_subject_test_model.dart';
import 'package:scholar_clone/model/student/test_report_model.dart';

import '../../../core/utils/cs.dart';
import '../../../core/utils/cu.dart';

class TestReportListController extends GetxController {
  TestData data = Get.arguments[0];
  var userInfo = Get.arguments[1];

  Map<String, dynamic>? resJson;

  RxBool isLoading = false.obs;

  RxList<AttemptedDatum> reportList = <AttemptedDatum>[].obs;

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
      CS.question_paper_id: data.questionPaperId,
    };

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context!,
        body: jsonEncode(body),
        apiUrl: "https://erp.triz.co.in/studentAssessmentAPI",
        isShowProgressDialog: false,
        isFormData: false,
      );
    } else {
      CU.showNoInternetDialog(
        Get.context!,
        callService,
      );
      return;
    }

    if (resJson![CS.status].toString() == StatusCode.Success) {
      TestReportModel model = TestReportModel.fromJson(resJson!);

      for (var e in model.data!.attemptedData!) {
        reportList.add(e);
      }

      // resJson![CS.data]['attempted_data'].forEach((element) {
      //   list.add(AssetsmentModel.fromJson(element));
      // });
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
