import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/api_client.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/core/utils/enum.dart';
import 'package:scholar_clone/model/student/about_us_model.dart';
import 'package:scholar_clone/model/student/home_data_model.dart';

import '../../../core/utils/cs.dart';

class SchoolTimingController extends GetxController {
  Content data = Get.arguments[0];
  Map<String, dynamic> userInfo = Get.arguments[1];

  Map<String, dynamic> resJson = {};

  RxList<AboutUs> schoolTimingList = <AboutUs>[].obs;

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    callService();
    super.onInit();
  }

  callService() async {
    isLoading.value = true;
    Map<String, dynamic> body = <String, dynamic>{
      CS.token: userInfo[CS.token],
      CS.action: "School Timing",
      CS.type: "API",
      CS.student_id: userInfo[CS.student_id],
      CS.syear: userInfo[CS.syear] ?? syear,
      CS.sub_institute_id: userInfo[CS.sub_institute_id],
    };

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context,
        body: body,
        apiUrl: data.subTitleApi,
        isShowProgressDialog: false,
      );
    } else {
      CU.showNoInternetDialog(
        Get.context!,
        callService,
      );
      return;
    }

    if (resJson[CS.status].toString() == StatusCode.Success) {
      AboutUsModel model = AboutUsModel.fromJson(resJson);
      schoolTimingList.value += model.data!;
      isLoading.value = false;
    } else if (resJson[CS.status].toString() == StatusCode.Error) {
      showDialog(
        builder: (context) => CU.showDiloag(context, resJson[CS.message]),
        barrierDismissible: false,
        context: Get.context!,
      );
      isLoading.value = false;
    }
    isLoading.value = false;
  }
}
