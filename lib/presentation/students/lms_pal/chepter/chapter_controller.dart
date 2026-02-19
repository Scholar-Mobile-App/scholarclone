import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/api_client.dart';
import 'package:scholar_clone/core/utils/cs.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/core/utils/enum.dart';
import 'package:scholar_clone/model/student/lms_subject_learn_model.dart';
import 'package:scholar_clone/model/student/lms_subject_model.dart';

class ChapterController extends GetxController {
  Subject data = Get.arguments[0];
  Map<String, dynamic> userInfo = Get.arguments[1];

  LmsSubjectLearnModel? lmsSubjectLearnModel;

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    callService();
    // callAssessmentService();
    super.onInit();
  }

  Map<String, dynamic>? resJson;
  Map<String, dynamic>? resAssessmentData;

  Future<void> callService() async {
    Map<String, dynamic> body = <String, dynamic>{
      CS.syear: userInfo[CS.syear] ?? syear,
      CS.sub_institute_id: userInfo[CS.sub_institute_id],
      CS.student_id: userInfo[CS.student_id],
      CS.token: userInfo[CS.token],
      CS.subject_id: data.subjectId,
    };

    isLoading.value = true;
    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(Get.context,
          body: jsonEncode(body),
          apiUrl: "https://erp.triz.co.in/studentContentAPI",
          isShowProgressDialog: false,
          isFormData: false);
    } else {
      CU.showNoInternetDialog(Get.context!, callService);
      return;
    }

    if (resJson![CS.status].toString() == StatusCode.Success) {
      lmsSubjectLearnModel = LmsSubjectLearnModel.fromJson(resJson!);

      isLoading.value = false;
    } else if (resJson![CS.status].toString() == StatusCode.Error) {
      showDialog(
        builder: (context) => CU.showDiloag(context, resJson![CS.message]),
        barrierDismissible: false,
        context: Get.context!,
      );
      isLoading.value = false;
    }

    isLoading.value = false;
  }

  // Future<void> callAssessmentService() async {
  //   Map<String, dynamic> body = <String, dynamic>{
  //     CS.syear: userInfo[CS.syear] ?? syear,
  //     CS.token: userInfo[CS.token],
  //     CS.student_id: userInfo[CS.student_id],
  //     CS.sub_institute_id: userInfo[CS.sub_institute_id],
  //     CS.subject_id: data.subjectId,
  //   };
  //   isTestLoading.value = true;
  //   if (await CU.checkInternet()) {
  //     resAssessmentData = await ApiClient.call(
  //       Get.context,
  //       body: jsonEncode(body),
  //       apiUrl: "https://erp.triz.co.in/studentQuestionPaperListAPI",
  //       isShowProgressDialog: false,
  //       isFormData: false,
  //     );
  //   } else {
  //     CU.showNoInternetDialog(Get.context!, callAssessmentService);
  //     return;
  //   }
  //   log(resAssessmentData![CS.status].toString());
  //   log(StatusCode.Success.toString());
  //   if (resAssessmentData![CS.status].toString() ==
  //       StatusCode.Success.toString()) {
  //     log("Gautam");
  //     LmsSubjectTestModel model =
  //         LmsSubjectTestModel.fromJson(resAssessmentData!);
  //     lmsSubjectTestModel = model;
  //     isTestLoading.value = false;

  //     log("+++++++++++++ IsTestLoding +++++++++++  ${isTestLoading.value}");
  //   } else if (resAssessmentData![CS.status].toString() == StatusCode.Error) {
  //     showDialog(
  //       builder: (context) =>
  //           CU.showDiloag(context, resAssessmentData![CS.message]),
  //       barrierDismissible: false,
  //       context: Get.context!,
  //     );
  //     isTestLoading.value = false;
  //   }
  // }
}
