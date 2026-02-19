import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scholar_clone/core/utils/api_client.dart';
import 'package:scholar_clone/core/utils/enum.dart';
import 'package:scholar_clone/core/utils/utility.dart';
import 'package:scholar_clone/model/student/home_data_model.dart';
import 'package:scholar_clone/model/student/wrt_progress_report_model.dart';
import 'package:scholar_clone/model/teacher/exam_type_model.dart';

import '../../../core/utils/cs.dart';
import '../../../core/utils/cu.dart';

class WRTProgressReportController extends GetxController {
  Content data = Get.arguments[0];
  Map<String, dynamic> userInfo = Get.arguments[1];

  final GlobalKey<FormFieldState> examKey = GlobalKey<FormFieldState>();

  RxList<ExamType> examTypeList = <ExamType>[].obs;
  RxList<String> examName = <String>[].obs;

  RxBool isLoading = false.obs;

  RxString selectExamName = "".obs;

  RxInt examID = 0.obs;

  Map<String, dynamic> resJson = {};

  RxString fromDate = "".obs;
  RxString toDate = "".obs;

  WrtProgress? wrtProgress;

  @override
  void onInit() async {
    await callExamType();

    super.onInit();
  }

  bool isValidated(context) {
    bool isValid = true;

    if (fromDate.value.isEmpty) {
      showToast(
        message: "Please select from date.",
        context: context,
      );
      isValid = false;
    } else if (toDate.value.isEmpty) {
      showToast(
        message: "Please select to date.",
        context: context,
      );
      isValid = false;
    }

    return isValid;
  }

  Future<void> callService(context) async {
    isLoading.value = true;
    Map<String, dynamic> body = <String, dynamic>{
      "from_date": fromDate.value.isEmpty
          ? null
          : DateFormat('yyyy-MM-dd').format(DateTime.parse(fromDate.value)),
      "to_date": toDate.value.isEmpty
          ? null
          : DateFormat('yyyy-MM-dd').format(DateTime.parse(toDate.value)),
      CS.syear: userInfo[CS.syear] ?? syear,
      CS.sub_institute_id: userInfo[CS.sub_institute_id],
      CS.student_id: userInfo[CS.student_id],
      CS.token: userInfo[CS.token],
      CS.type: "API",
      "exam_type": examID.value == 0 ? null : examID.value,
    };

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context,
        body: body,
        apiUrl: "https://erp.triz.co.in/get_wrtreportAPI",
        isShowProgressDialog: false,
      );
    } else {
      return;
    }

    if (resJson[CS.status].toString() == StatusCode.Success) {
      WrtProgressReportModel model = WrtProgressReportModel.fromJson(resJson);
      wrtProgress = model.data;
      isLoading.value = false;
    }
  }

  Future<void> callExamType() async {
    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context,
        callMethod: CallMethod.get,
        apiUrl:
            "https://erp.triz.co.in/result/exam_master?type=API&sub_institute_id=${userInfo[CS.sub_institute_id]}&standard_id=${userInfo["standard_id"]}",
        isShowProgressDialog: false,
      );
    } else {
      CU.showNoInternetDialog(Get.context!, callExamType);
      return;
    }

    ExamTypeModel model = ExamTypeModel.fromJson(resJson);
    examTypeList.value += model.data!;

    for (var i = 0; i < examTypeList.length; i++) {
      examName.add(examTypeList[i].examTitle!);
    }
  }
}
