import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scholar_clone/model/student/home_data_model.dart';
import 'package:scholar_clone/core/utils/api_client.dart';
import 'package:scholar_clone/core/utils/cs.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/model/teacher/attendances_model.dart';

class MyAttendanceController extends GetxController {
  Content data = Get.arguments[0];
  Map<String, dynamic> userInfo = Get.arguments[1];

  RxBool isLoading = false.obs;
  final Rxn<DateTime> fromDate = Rxn<DateTime>();

  RxList<AttendancesModel> attendancesList = <AttendancesModel>[].obs;

  Map<String, dynamic> resJson = {};

  @override
  void onInit() {
    callServiceMyAttendance();
    super.onInit();
  }

  Future<void> callServiceMyAttendance() async {
    int id = (userInfo["user_profile_name"] == "Teacher")
        ? userInfo[CS.teacher_id]
        : userInfo["user_id"];
    isLoading.value = true;

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context!,
        callMethod: CallMethod.get,
        apiUrl: "https://erp.triz.co.in/lms_data",
        body: {
          "table": "hrms_attendances",
          "filters": {
            "user_id": id,
            "sub_institute_id": userInfo[CS.sub_institute_id],
            if (fromDate.value != null)
              "day": DateFormat("MMM-yyyy").format(fromDate.value!)
          },
          "order_by": {"column": "day", "direction": "desc"}
        },
        isShowProgressDialog: false,
      );
    } else {
      CU.showNoInternetDialog(Get.context!, callServiceMyAttendance);
      return;
    }

    if (resJson['data'] is List) {
      if (resJson['data'][0]["message"] == null) {
        attendancesList.value = List<AttendancesModel>.from(
            resJson['data'].map((x) => AttendancesModel.fromJson(x)));
      }
    }

    isLoading.value = false;
  }
}
