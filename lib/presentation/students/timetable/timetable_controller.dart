import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scholar_clone/core/utils/api_client.dart';
import 'package:scholar_clone/core/utils/cs.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/core/utils/enum.dart';
import 'package:scholar_clone/model/student/home_data_model.dart';
import 'package:scholar_clone/model/student/time_table_model.dart';

class TimeTableController extends GetxController {
  Content data = Get.arguments[0];
  Map<String, dynamic> userInfo = Get.arguments[1];

  @override
  void onInit() {
    callService();
    super.onInit();
  }

  RxList<TimeTable> timeTableList = <TimeTable>[].obs;
  RxList tempLstData = [].obs;
  RxString selectDay = "".obs;

  dynamic lstData;

  Map<String, dynamic>? resJson;

  RxBool isLoading = false.obs;

  Future<void> callService() async {
    Map<String, dynamic> body = <String, dynamic>{
      CS.token: userInfo[CS.token],
      CS.action: "Homework",
      CS.student_id: userInfo[CS.student_id],
      CS.syear: userInfo[CS.syear] ?? syear,
      CS.sub_institute_id: userInfo[CS.sub_institute_id],
    };

    isLoading.value = true;

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context!,
        body: body,
        apiUrl: data.subTitleApi,
        isShowProgressDialog: false,
      );
    } else {
      CU.showNoInternetDialog(Get.context!, callService);
      return;
    }

    if (resJson![CS.status].toString() == StatusCode.Success) {
      // for (var i = 0; i < resJson![CS.data].length; i++) {
      //   timeTableList.add(resJson![CS.data][i]);
      // }
      lstData = resJson![CS.data];
      var date = DateTime.now();
      log(DateFormat('EEE').format(date));
      filterListday(resJson![CS.data], DateFormat('EEE').format(date));

      isLoading.value = false;
    } else if (resJson![CS.status].toString() == StatusCode.Error) {
      showDialog(
        builder: (context) => CU.showDiloag(context, resJson![CS.message]),
        barrierDismissible: false,
        context: Get.context!,
      );
      isLoading.value = false;
    }
  }

  filterListday(var arrList, String day) {
    if (arrList != null) {
      tempLstData.value = arrList
          .where((item) =>
              item[CS.weekday].toString().toUpperCase() == day.toUpperCase())
          .toList();
      selectDay.value = day;
    }
  }
}
