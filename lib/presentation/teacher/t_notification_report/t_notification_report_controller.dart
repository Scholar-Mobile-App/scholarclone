import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scholar_clone/core/utils/api_client.dart';
import 'package:scholar_clone/core/utils/cs.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/core/utils/enum.dart';
import 'package:scholar_clone/model/student/home_data_model.dart';
import 'package:scholar_clone/model/student/notification_report_model.dart';

class TeacherNotificationReportController extends GetxController {
  Content data = Get.arguments[0];
  Map<String, dynamic> userInfo = Get.arguments[1];

  RxBool isLoading = false.obs;

  RxList<NotificationReport> notificationList = <NotificationReport>[].obs;

  @override
  void onInit() {
    callService();
    super.onInit();
  }

  Rx<DateTime> fromDate = DateTime.now().obs;
  Rx<DateTime> toDate = DateTime.now().obs;

  Map<String, dynamic> resJson = {};

  Future<void> callService() async {
    isLoading.value = true;
    notificationList.clear();

    var fromDateFormat = DateFormat('yyyy-MM-dd').format(fromDate.value);
    var toDateFormat = DateFormat('yyyy-MM-dd').format(toDate.value);

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context,
        callMethod: CallMethod.get,
        apiUrl:
            "https://erp.triz.co.in/easy_com/notification_report/create?type=API&from_date=$fromDateFormat&to_date=$toDateFormat&sub_institute_id=${userInfo[CS.sub_institute_id]}&syear=${userInfo["syear"]}",
        isShowProgressDialog: false,
      );
    } else {
      CU.showNoInternetDialog(Get.context!, callService);
      return;
    }

    if (resJson[CS.status] == StatusCode.Success) {
      TeacherNotificationReportModel model =
          TeacherNotificationReportModel.fromJson(resJson);
      notificationList.value += model.data!;
    } else if (resJson[CS.status].toString() == StatusCode.Error) {}
    isLoading.value = false;
  }
}
