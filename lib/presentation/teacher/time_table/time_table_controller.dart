import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scholar_clone/core/utils/api_client.dart';
import 'package:scholar_clone/core/utils/cs.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/core/utils/enum.dart';
import 'package:scholar_clone/model/student/home_data_model.dart';
import 'package:scholar_clone/model/teacher/teacher_time_table.dart';

class TeacherTimetableController extends GetxController {
  @override
  void onInit() {
    callService();
    super.onInit();
  }

  Content data = Get.arguments[0];
  Map<String, dynamic> userInfo = Get.arguments[1];

  Map<String, dynamic> resJson = <String, dynamic>{};

  RxList tempLstData = [].obs;
  dynamic lstData;

  RxString selectDay = DateFormat('EEE').format(DateTime.now()).obs;
  TeacherTimeTable? teacherTimeTable;

  RxBool isLoading = false.obs;

  Future<void> callService() async {
    isLoading.value = true;

    Map<String, dynamic> body = <String, dynamic>{
      CS.token: userInfo[CS.token],
      CS.type: "API",
      CS.teacher_id: userInfo[CS.teacher_id],
      CS.syear: userInfo[CS.syear] ?? syear,
      CS.sub_institute_id: userInfo[CS.sub_institute_id],
    };

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context,
        body: body,
        apiUrl: "https://erp.triz.co.in/teacherTimetableAPI",
        isShowProgressDialog: false,
      );
    } else {
      CU.showNoInternetDialog(Get.context!, callService);
      return;
    }

    if (resJson["status_code"].toString() == StatusCode.Success) {
      TeacherTimeTable model = TeacherTimeTable.fromJson(resJson);
      teacherTimeTable = model;
      lstData = resJson[CS.data];
      var date = DateTime.now();
      filterListday(resJson[CS.data], DateFormat('EEE').format(date));

      // this.lstData = resJson[CS.data];
      // var date = DateTime.now();
      // log('Ankitc--> ${DateFormat('EEE').format(date)[0]}');
      // filterListday(resJson[CS.data], DateFormat('EEE').format(date));
    } else if (resJson[CS.status].toString() == StatusCode.Error) {
      showDialog(
        builder: (context) => CU.showDiloag(context, resJson[CS.message]),
        barrierDismissible: false,
        context: Get.context!,
      );
    }

    isLoading.value = false;
  }

  filterListday(dynamic arrList, String day) {
    if (arrList != null) {
      tempLstData.value = arrList
          .where((item) =>
              item["week_day"].toString().toUpperCase() == day[0].toUpperCase())
          .toList();
      if (day == "Thu") {
        day = "H";
      }
      selectDay.value = day;
    }
  }
}
