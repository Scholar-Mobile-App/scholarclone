import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/core/utils/enum.dart';
import 'package:scholar_clone/model/student/teacher_model.dart';

import '../../../core/utils/api_client.dart';
import '../../../core/utils/cs.dart';

class TeacherListController extends GetxController {
  Map<String, dynamic> userInfo = Get.arguments;
  Map<String, dynamic> resJson = <String, dynamic>{};

  RxList<Teacher> filterteacherList = <Teacher>[].obs;
  RxList<Teacher> teacherList = <Teacher>[].obs;

  RxBool isLoading = false.obs;

  String selectedSubject = "All";
  String searchSubject = "";

  @override
  void onInit() {
    callService();
    super.onInit();
  }

  Future<void> callService() async {
    Map<String, dynamic> body = <String, dynamic>{
      CS.syear: userInfo[CS.syear] ?? syear,
      CS.sub_institute_id: userInfo[CS.sub_institute_id],
      CS.student_id: userInfo[CS.student_id],
      CS.token: userInfo[CS.token],
      CS.type: "API"
    };
    isLoading.value = true;
    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context,
        body: body,
        apiUrl: "https://erp.triz.co.in/studentTeacherListAPI",
        isShowProgressDialog: false,
      );
    } else {
      return;
    }

    if (resJson[CS.status].toString() == StatusCode.Success) {
      resJson[CS.data].forEach((element) {
        teacherList.add(Teacher.fromJson(element));
      });
      filterteacherList = teacherList;
      update();

      isLoading.value = false;
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
