import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scholar_clone/core/utils/api_client.dart';
import 'package:scholar_clone/core/utils/cs.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/model/admin/leave_authorisation_model.dart';
import 'package:scholar_clone/model/student/home_data_model.dart';
import 'package:scholar_clone/presentation/admin/leave_requests/leave_requests_controller.dart';

class LeaveRequestsDetailsController extends GetxController {
  Content data = Get.arguments[0];
  Map<String, dynamic> userInfo = Get.arguments[1];
  GetEmployeeLeaveList leaveRequest = Get.arguments[2];

  final TextEditingController leaveType = TextEditingController();
  final TextEditingController dayType = TextEditingController();
  final TextEditingController fromDate = TextEditingController();
  final TextEditingController toDate = TextEditingController();
  final TextEditingController slot = TextEditingController();
  final TextEditingController hrRemark = TextEditingController();
  final TextEditingController hodRemark = TextEditingController();

  Map<String, dynamic>? resJson;

  final RxString selectStatus = "".obs;

  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    if (leaveRequest.id != null) {
      leaveType.text = leaveRequest.leaveType ?? "";
      dayType.text = leaveRequest.dayType == "0.5" ? "Half Day" : "Full Day";
      fromDate.text = DateFormat("yyyy-MM-dd")
          .format(leaveRequest.fromDate ?? DateTime.now());
      if (leaveRequest.toDate != null) {
        toDate.text = DateFormat("yyyy-MM-dd")
            .format(leaveRequest.toDate ?? DateTime.now());
      }

      if (leaveRequest.slot != null) {
        slot.text =
            leaveRequest.slot == "first_half" ? "First Half" : "Second Half";
      }
    }
    super.onInit();
  }

  Future<void> callServiceACtionLeave() async {
    isLoading.value = true;

    Map<String, dynamic> body = <String, dynamic>{
      'type': 'API',
      'user_id': userInfo["user_id"],
      'sub_institute_id': userInfo[CS.sub_institute_id],
      'id': leaveRequest.id,
      'hod_comment': hodRemark.text.trim(),
      'hr_remarks': hrRemark.text.trim(),
      'single_leave_status': selectStatus.value.toLowerCase()
    };

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context,
        body: body,
        apiUrl: "https://erp.triz.co.in/leave-authorisation-store",
        isShowProgressDialog: false,
      );
    } else {
      CU.showNoInternetDialog(Get.context!, callServiceACtionLeave);
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
    Get.find<LeaveRequestsController>().callServiceLeaveRequest();
    Get.back();

    isLoading.value = false;
  }
}
