import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/model/student/home_data_model.dart';
import 'dart:convert';

import 'package:scholar_clone/core/utils/api_client.dart';
import 'package:scholar_clone/core/utils/cs.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/core/utils/enum.dart';
import 'package:scholar_clone/model/teacher/teach_model.dart';
import 'package:scholar_clone/model/teacher/teach_subject_model.dart';

class TeachSubjectController extends GetxController
    with GetSingleTickerProviderStateMixin {
  Content data = Get.arguments[0];
  Map<String, dynamic> userInfo = Get.arguments[1];
  Teach teachData = Get.arguments[2];
  String standId = Get.arguments[3];

  TabController? tabController;

  RxBool isLoading = false.obs;

  TeachSubjectModel? teachSubjectModel;

  Map<String, dynamic>? resJson;

  List allPages = [
    "Learn",
    "Test",
    "Report",
  ];

  @override
  void onInit() {
    tabController = TabController(
      vsync: this,
      length: allPages.length,
    );
    callService();
    super.onInit();
  }

  Future<void> callService() async {
    Map<String, dynamic> body = <String, dynamic>{
      CS.syear: userInfo[CS.syear] ?? syear,
      CS.sub_institute_id: userInfo[CS.sub_institute_id],
      CS.token: userInfo[CS.token],
      "standard_id": standId,
      CS.type: "API",
      "subject_id": teachData.subId,
    };

    isLoading.value = true;
    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(Get.context,
          body: jsonEncode(body),
          apiUrl: "https://erp.triz.co.in/get_teacherContentAPI",
          isShowProgressDialog: false,
          isFormData: false);
    } else {
      CU.showNoInternetDialog(Get.context!, callService);
      return;
    }

    if (resJson![CS.status].toString() == StatusCode.Success) {
      teachSubjectModel = TeachSubjectModel.fromJson(resJson!);
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
}
