import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/core/utils/enum.dart';

import '../../../core/utils/api_client.dart';
import '../../../core/utils/cs.dart';

class TestResultController extends GetxController {
  Map<String, dynamic> resJson = <String, dynamic>{};

  Map<String, dynamic> data = Get.arguments[0];
  var userInfo = Get.arguments[1];

  // RxList<dynamic> practiceList = <dynamic>[].obs;

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    resJson.addAll(<String, dynamic>{CS.data: data[CS.data]});
    super.onInit();
  }

  getSkipAnswer() {
    int k = 0;
    for (int i = 0; i < resJson[CS.data].length; i++) {
      if (CU.isEmptyOrNull(resJson[CS.data][i][CS.given_ans])) k++;
    }
    return k.toString();
  }

  Future<void> callService() async {
    isLoading.value = true;

    Map<String, dynamic> body = <String, dynamic>{
      CS.token: userInfo["token"],
      CS.id: data[CS.id],
      CS.user_id: userInfo[CS.lms_user_id],
    };

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context,
        body: jsonEncode(body),
        apiUrl: CS.practiceReport,
        isShowProgressDialog: false,
        isFormData: false,
      );
    } else {
      CU.showNoInternetDialog(Get.context!, callService);
      return;
    }
    if (resJson[CS.status].toString() == StatusCode.Success) {
      // practiceList.value = resJson[CS.data]["online_answer_data"];
    } else if (resJson[CS.status].toString() == StatusCode.Error) {
      showDialog(
        builder: (context) => CU.showDiloag(context, resJson[CS.message]),
        barrierDismissible: false,
        context: Get.context!,
      );
    }
    isLoading.value = false;
  }
}
