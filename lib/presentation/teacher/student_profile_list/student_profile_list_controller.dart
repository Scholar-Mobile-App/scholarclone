import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/enum.dart';
import 'package:scholar_clone/model/student/home_data_model.dart';
import 'package:scholar_clone/model/teacher/assign_homework/studen_list_model.dart';

import '../../../core/utils/api_client.dart';
import '../../../core/utils/cs.dart';
import '../../../core/utils/cu.dart';

class StudentProfileListController extends GetxController {
  Content data = Get.arguments[0];
  Map<String, dynamic> userInfo = Get.arguments[1];

  Map<String, dynamic> resJson = <String, dynamic>{};

  RxList<String> divList = <String>[].obs;
  RxList<Student> studentList = <Student>[].obs;

  RxString section = "".obs;
  RxString standard = "".obs;
  RxString stdDiv = "".obs;

  @override
  void onInit() {
    var list = userInfo["standard_division"].split(",");
    var div = userInfo["standard_division_title"].split(",");
    for (int i = 0; i < list.length; i++) {
      if (list[i] != "") {
        divList.add(div[i].replaceAll("||", "-"));
      }
    }
    super.onInit();
  }

  Future<void> callServiceAllocate(stdDiv) async {
    var string = stdDiv;
    var ans = string.split("||");
    Map<String, dynamic> body = <String, dynamic>{
      CS.token: userInfo[CS.token],
      "standard_id": ans[0].trim(),
      "division_id": ans[1].trim(),
      CS.teacher_id: userInfo[CS.teacher_id],
      CS.syear: userInfo[CS.syear] ?? syear,
      CS.type: "API",
      CS.sub_institute_id: userInfo[CS.sub_institute_id],
    };

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context,
        body: body,
        apiUrl: "https://erp.triz.co.in/allStudentListAPI",
        isShowProgressDialog: false,
      );
    } else {
      CU.showNoInternetDialog(Get.context!, callServiceAllocate);
      return;
    }

    if (resJson[CS.status].toString() == StatusCode.Success) {
      resJson[CS.data].forEach((s) {
        studentList.add(Student.fromJson(s));
      });
    } else if (resJson[CS.status].toString() == StatusCode.Error) {
      showDialog(
        builder: (context) => CU.showDiloag(context, resJson[CS.message]),
        barrierDismissible: false,
        context: Get.context!,
      );
    }
  }
}
