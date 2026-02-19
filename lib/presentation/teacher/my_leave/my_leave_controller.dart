import 'dart:developer';

import 'package:get/get.dart';
import 'package:scholar_clone/model/student/home_data_model.dart';
import 'package:scholar_clone/core/utils/api_client.dart';
import 'package:scholar_clone/core/utils/cs.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/core/utils/enum.dart';
import 'package:scholar_clone/model/student/my_leave_model.dart';
import 'package:scholar_clone/model/teacher/leave_type_model.dart';

class MyLeaveController extends GetxController {
  Content data = Get.arguments[0];
  Map<String, dynamic> userInfo = Get.arguments[1];

  RxBool isLoading = false.obs;

  RxList<LeaveType> leaveTypeList = <LeaveType>[].obs;
  Rx<LeaveSummary> leaveSummary = LeaveSummary().obs;
  RxList<LeaveTypeModel> typeOfLeaveList = <LeaveTypeModel>[].obs;

  Map<String, dynamic> resJson = {};

  @override
  void onInit() {
    callServiceMyLeaves();
    callServiceLeaveType();
    super.onInit();
  }

  Future<void> callServiceMyLeaves() async {
    isLoading.value = true;

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context!,
        callMethod: CallMethod.get,
        apiUrl:
            "https://erp.triz.co.in/hrms/myleave/${(userInfo["user_profile_name"] == "Teacher") ? userInfo[CS.teacher_id] : userInfo["user_id"]}",
        isShowProgressDialog: false,
      );
    } else {
      CU.showNoInternetDialog(Get.context!, callServiceMyLeaves);
      return;
    }

    if (resJson[CS.status].toString() == StatusCode.Success) {
      MyLeaveModel model = MyLeaveModel.fromJson(resJson);
      leaveTypeList.value = model.data?.leaveTypes ?? [];
      leaveSummary.value = model.data?.leaveSummary ?? LeaveSummary();
    } else if (resJson[CS.status].toString() == StatusCode.Error) {
      isLoading.value = false;
    }
    isLoading.value = false;
  }

  Future<void> callServiceLeaveType() async {
    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context!,
        callMethod: CallMethod.get,
        apiUrl: "https://erp.triz.co.in/lms_data",
        body: {
          "table": "hrms_leave_types",
          "filters": {
            "user_id": (userInfo["user_profile_name"] == "Teacher")
                ? userInfo[CS.teacher_id]
                : userInfo["user_id"],
            "sub_institute_id": userInfo[CS.sub_institute_id]
          },
          "order_by": {"column": "id", "direction": "desc"}
        },
        isShowProgressDialog: false,
      );
    } else {
      CU.showNoInternetDialog(Get.context!, callServiceLeaveType);
      return;
    }

    if (resJson['data'] is List) {
      typeOfLeaveList.value = List<LeaveTypeModel>.from(
          resJson['data'].map((x) => LeaveTypeModel.fromJson(x)));

      log("typeOfLeaveList ${typeOfLeaveList.length}");
    }
  }
}
