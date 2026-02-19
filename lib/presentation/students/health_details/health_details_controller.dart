import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/api_client.dart';
import 'package:scholar_clone/model/student/health_details_model.dart';
import 'package:scholar_clone/model/student/home_data_model.dart';

import '../../../core/utils/cs.dart';
import '../../../core/utils/cu.dart';
import '../../../core/utils/enum.dart';

class HealthDetailsController extends GetxController {
  @override
  void onInit() {
    callService();
    super.onInit();
  }

  Content data = Get.arguments[0];
  Map<String, dynamic> userInfo = Get.arguments[1];

  Map<String, dynamic> resJson = {};

  RxList<Doctor> healthList = <Doctor>[].obs;

  RxBool isLoading = false.obs;

  Future<void> callService() async {
    isLoading.value = true;

    Map<String, dynamic> body = <String, dynamic>{
      CS.token: userInfo[CS.token],
      CS.student_id: userInfo[CS.student_id],
      CS.syear: userInfo[CS.syear] ?? syear,
      CS.sub_institute_id: userInfo[CS.sub_institute_id],
      CS.type: "API",
    };

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context,
        body: body,
        apiUrl: data.subTitleApi,
        isShowProgressDialog: false,
      );
    } else {
      CU.showNoInternetDialog(Get.context!, callService);
      return;
    }

    if (resJson[CS.status].toString() == StatusCode.Success) {
      HealthDetailsModel model = HealthDetailsModel.fromJson(resJson);

      for (var i = 0; i < model.data!.length; i++) {
        healthList.add(model.data![i]);
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
}
