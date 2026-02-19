import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:scholar_clone/core/utils/api_client.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/core/utils/enum.dart';
import 'package:scholar_clone/model/student/home_data_model.dart';
import 'package:scholar_clone/model/teacher/teacher_resource_model.dart';

import '../../../core/utils/cs.dart';

class TeacherResourceController extends GetxController {
  Content data = Get.arguments[0];
  Map<String, dynamic> userInfo = Get.arguments[1];

  RxList<TeacherResource> resourceList = <TeacherResource>[].obs;

  RxBool isLoading = false.obs;

  Map<String, dynamic> resJson = {};

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
      CS.teacher_id: userInfo[CS.teacher_id],
      CS.token: userInfo[CS.token],
    };

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        context,
        body: body,
        apiUrl: "https://erp.triz.co.in/get_teacherResourceAPI",
        isShowProgressDialog: false,
      );
    } else {
      return;
    }

    if (resJson[CS.status].toString() == StatusCode.Success) {
      TeacherResourceModel model = TeacherResourceModel.fromJson(resJson);
      resourceList.value = model.data!;
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
