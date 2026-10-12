import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scholar_clone/core/utils/api_client.dart';
import 'package:scholar_clone/core/utils/cs.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/core/utils/enum.dart';

/// Request body shared by every MIS call: logged-in user + selected date.
Map<String, dynamic> misBaseBody(
        Map<String, dynamic> userInfo, DateTime date) =>
    {
      CS.token: userInfo[CS.token],
      CS.sub_institute_id: userInfo[CS.sub_institute_id],
      CS.syear: userInfo[CS.syear] ?? syear,
      "date": DateFormat('yyyy-MM-dd').format(date),
    };

Future<Map<String, dynamic>?> misPost(
  Map<String, dynamic> body,
  String api,
  Future<void> Function() retry,
) async {
  if (!await CU.checkInternet()) {
    CU.showNoInternetDialog(Get.context!, retry);
    return null;
  }
  return await ApiClient.call(
    Get.context!,
    body: body,
    apiUrl: "https://erp.triz.co.in/$api",
    isShowProgressDialog: false,
  );
}

class MisReportController extends GetxController {
  Map<String, dynamic> userInfo = Get.arguments[1];

  Rx<DateTime> date = DateTime.now().obs;
  RxBool isLoading = true.obs;
  RxString instituteName = "".obs;
  RxInt totalStudents = 0.obs;
  RxList<Map<String, dynamic>> modules = <Map<String, dynamic>>[].obs;

  /// Key of the row whose drill-down is open below it ("" = none).
  RxString expanded = "".obs;

  @override
  void onInit() {
    load();
    super.onInit();
  }

  void toggle(String key) => expanded.value = expanded.value == key ? "" : key;

  Future<void> pickDate() async {
    final picked = await showDatePicker(
      context: Get.context!,
      initialDate: date.value,
      firstDate: DateTime(2018),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      date.value = picked;
      load();
    }
  }

  Future<void> load() async {
    isLoading.value = true;
    expanded.value = "";
    final res =
        await misPost(misBaseBody(userInfo, date.value), "get_misReport", load);
    isLoading.value = false;
    if (res == null) return;

    if (res[CS.status].toString() == StatusCode.Success) {
      instituteName.value = (res["institute_name"] ?? "").toString();
      totalStudents.value = int.tryParse(res["total_students"].toString()) ?? 0;
      modules.value = List<Map<String, dynamic>>.from(
          (res[CS.data] as List).map((e) => Map<String, dynamic>.from(e)));
    } else {
      log("get_misReport response: $res");
      showDialog(
        builder: (context) => CU.showDiloag(context,
            (res[CS.message] ?? "Unable to load MIS report").toString()),
        context: Get.context!,
      );
    }
  }
}
