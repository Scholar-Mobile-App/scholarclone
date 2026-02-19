import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scholar_clone/core/utils/api_client.dart';
import 'package:scholar_clone/core/utils/cs.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/model/student/home_data_model.dart';
import 'package:scholar_clone/model/teacher/leave_type_model.dart';

class ApplyLeaveController extends GetxController {
  Content data = Get.arguments[0];
  Map<String, dynamic> userInfo = Get.arguments[1];

  Map<String, dynamic>? resJson;

  final TextEditingController comment = TextEditingController();
  final Rx<LeaveTypeModel> laveType = LeaveTypeModel().obs;
  final RxString selectDayType = "".obs;
  final RxString selectSlot = "".obs;
  final Rx<DateTime> fromDate = DateTime.now().obs;
  final Rx<DateTime> toDate = DateTime.now().obs;

  final RxBool isLoading = false.obs;

  Future<void> callServiceApplyLeave() async {
    isLoading.value = true;

    Map<String, dynamic> body = <String, dynamic>{
      'type': 'API',
      'type_leave': 'Self',
      'leave_type': laveType.value.id,
      'day_type': selectDayType.value.toLowerCase(),
      'from_date': DateFormat("yyyy-MM-dd").format(fromDate.value),
      if (selectDayType.value == "Full")
        'to_date': DateFormat("yyyy-MM-dd").format(toDate.value),
      if (selectDayType.value == "Half")
        'slot': selectSlot.value == "First Half" ? "first_half" : "second_half",
      'comment': comment.text.trim(),
      'user_id': (userInfo["user_profile_name"] == "Teacher")
          ? userInfo[CS.teacher_id]
          : userInfo["user_id"],
      // 'department_id': '118',
      'sub_institute_id': userInfo[CS.sub_institute_id],
      'token': userInfo[CS.token]
    };

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context,
        body: body,
        apiUrl: "https://erp.triz.co.in/leave-apply",
        isShowProgressDialog: false,
      );
    } else {
      CU.showNoInternetDialog(Get.context!, callServiceApplyLeave);
      return;
    }

    if (resJson!["status"] == "1") {
      Fluttertoast.showToast(
        msg: resJson?["message"] ?? "",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
    Get.back();

    isLoading.value = false;
  }
}
