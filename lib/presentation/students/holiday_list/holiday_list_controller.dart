import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:scholar_clone/core/utils/api_client.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/core/utils/enum.dart';
import 'package:scholar_clone/model/student/holiday_list_model.dart';

import '../../../core/utils/cs.dart';
import '../../../model/student/home_data_model.dart';

class HolidayListController extends GetxController {
  Content data = Get.arguments[0];
  Map<String, dynamic> userInfo = Get.arguments[1];

  RxList<Holiday> holidayList = <Holiday>[].obs;

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
      CS.token: userInfo[CS.token],
      CS.action: "holiday",
      CS.type: "API",
      CS.student_id: userInfo[CS.student_id],
      CS.syear: userInfo[CS.syear] ?? syear,
      CS.sub_institute_id: userInfo[CS.sub_institute_id],
    };

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        context,
        body: body,
        apiUrl: "https://erp.triz.co.in/studentCalenderAPI",
        isShowProgressDialog: false,
      );
    } else {
      return;
    }

    if (resJson[CS.statuscode].toString() == StatusCode.Success) {
      HolidayListModel model = HolidayListModel.fromJson(resJson);

      for (var i = 0; i < model.data!.length; i++) {
        holidayList.add(model.data![i]);
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
