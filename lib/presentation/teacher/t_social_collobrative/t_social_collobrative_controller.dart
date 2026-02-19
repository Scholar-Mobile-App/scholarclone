import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:scholar_clone/core/utils/api_client.dart';
import 'package:scholar_clone/core/utils/cs.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/core/utils/enum.dart';
import 'package:scholar_clone/model/student/home_data_model.dart';
import 'package:scholar_clone/model/teacher/teacher_social_collobrative_model.dart';

class TeacherSocialCollobrativeController extends GetxController {
  Content data = Get.arguments[0];
  Map<String, dynamic> userInfo = Get.arguments[1];

  Map<String, dynamic> resJson = {};

  RxBool isLoading = false.obs;

  TeacherSocialCollobrativeModel? socialCollobrativeModel;

  @override
  void onInit() {
    callService();
    super.onInit();
  }

  Future<void> callService() async {
    isLoading.value = true;
    Map<String, dynamic> body = <String, dynamic>{
      CS.teacher_id: userInfo[CS.teacher_id],
      CS.sub_institute_id: userInfo[CS.sub_institute_id],
      CS.syear: userInfo["syear"] ?? syear,
      CS.type: "API",
      CS.token: userInfo[CS.token]
    };

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        context,
        body: body,
        apiUrl: "https://erp.triz.co.in/teacherSocialCollabrativeAPI",
        isShowProgressDialog: false,
      );
    } else {
      // CU.showNoInternetDiloag(context, callService);
      return;
    }

    if (resJson[CS.status].toString() == StatusCode.Success) {
      socialCollobrativeModel =
          TeacherSocialCollobrativeModel.fromJson(resJson);
      isLoading.value = false;
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
