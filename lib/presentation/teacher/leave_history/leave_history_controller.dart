import 'package:get/get.dart';
import 'package:scholar_clone/model/student/home_data_model.dart';
import 'package:scholar_clone/core/utils/api_client.dart';
import 'package:scholar_clone/core/utils/cs.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/model/student/my_leave_history_model.dart';
import 'package:scholar_clone/model/teacher/leave_type_model.dart';

class LeaveHistoryController extends GetxController {
  Content data = Get.arguments[0];
  Map<String, dynamic> userInfo = Get.arguments[1];

  RxBool isLoading = false.obs;

  RxList<MyLeaveHistoryModel> leaveHistoryList = <MyLeaveHistoryModel>[].obs;
  final Rx<LeaveTypeModel> laveType = LeaveTypeModel().obs;

  Map<String, dynamic> resJson = {};

  @override
  void onInit() {
    callServiceMyLeaveHistory();
    super.onInit();
  }

  Future<void> callServiceMyLeaveHistory({int? leaveTypeId}) async {
    isLoading.value = true;

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context!,
        callMethod: CallMethod.get,
        apiUrl: "https://erp.triz.co.in/lms_data",
        body: {
          "table": "hrms_emp_leaves",
          "filters": {
            "user_id": (userInfo["user_profile_name"] == "Teacher")
                ? userInfo[CS.teacher_id]
                : userInfo["user_id"],
            "sub_institute_id": userInfo[CS.sub_institute_id],
            if (leaveTypeId != null) "leave_type_id": leaveTypeId
          },
          "order_by": {"column": "id", "direction": "desc"}
        },
        isShowProgressDialog: false,
      );
    } else {
      CU.showNoInternetDialog(Get.context!, callServiceMyLeaveHistory);
      return;
    }

    if (resJson['data'] is List) {
      if (resJson['data'][0]["message"] == null) {
        leaveHistoryList.value = List<MyLeaveHistoryModel>.from(
            resJson['data'].map((x) => MyLeaveHistoryModel.fromJson(x)));
      }
    }

    isLoading.value = false;
  }
}
