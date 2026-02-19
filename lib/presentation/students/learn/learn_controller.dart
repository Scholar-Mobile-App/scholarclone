import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/api_client.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/core/utils/enum.dart';
import 'package:scholar_clone/model/student/home_data_model.dart';
import 'package:scholar_clone/model/student/lms_subject_model.dart';

import '../../../core/utils/cs.dart';

class LearnController extends GetxController {
  Content data = Get.arguments[0];
  Map<String, dynamic> userInfo = Get.arguments[1];

  LmsSubjectModel? lmsSubjectModel;

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    callService();

    super.onInit();
  }

  Map<String, dynamic> resJson = <String, dynamic>{};

  Future<void> callService() async {
    Map<String, dynamic> body = <String, dynamic>{
      CS.syear: userInfo[CS.syear] ?? syear,
      CS.token: userInfo[CS.token],
      CS.student_id: userInfo[CS.student_id],
      CS.sub_institute_id: userInfo[CS.sub_institute_id],
    };

    isLoading.value = true;

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context,
        body: jsonEncode(body),
        apiUrl: "https://erp.triz.co.in/studentSubjectAPI",
        isShowProgressDialog: false,
        isFormData: false,
      );
    } else {
      CU.showNoInternetDialog(Get.context!, callService);
      return;
    }

    if (resJson[CS.status].toString() == StatusCode.Success) {
      if (resJson[CS.data] != null) {
        LmsSubjectModel model = LmsSubjectModel.fromJson(resJson);
        lmsSubjectModel = model;

        isLoading.value = false;
      }
    } else if (resJson[CS.status].toString() == StatusCode.Error) {
      showDialog(
        builder: (context) => CU.showDiloag(context, resJson[CS.message]),
        barrierDismissible: false,
        context: Get.context!,
      );
      isLoading.value = false;
    }
  }
}
