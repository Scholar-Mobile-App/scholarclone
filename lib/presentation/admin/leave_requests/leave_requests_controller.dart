import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scholar_clone/model/admin/leave_authorisation_model.dart';
import 'package:scholar_clone/model/student/home_data_model.dart';
import 'package:scholar_clone/core/utils/api_client.dart';
import 'package:scholar_clone/core/utils/cs.dart';
import 'package:scholar_clone/core/utils/cu.dart';

class LeaveRequestsController extends GetxController {
  Content data = Get.arguments[0];
  Map<String, dynamic> userInfo = Get.arguments[1];

  final Rx<DateTime> fromDate = DateTime.now().obs;
  final Rx<DateTime> toDate = DateTime.now().obs;

  RxBool isLoading = false.obs;

  RxList<GetEmployeeLeaveList> leaveRequestList = <GetEmployeeLeaveList>[].obs;

  Map<String, dynamic> resJson = {};

  @override
  void onInit() {
    callServiceLeaveRequest();
    super.onInit();
  }

  Future<void> callServiceLeaveRequest() async {
    isLoading.value = true;

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context!,
        callMethod: CallMethod.post,
        apiUrl: "https://erp.triz.co.in/show-leave-authorisation",
        body: {
          'type': 'API',
          'sub_institute_id': userInfo[CS.sub_institute_id],
          'from_date': DateFormat("yyyy-MM-dd").format(fromDate.value),
          'to_date': DateFormat("yyyy-MM-dd").format(toDate.value),
          'leave_status': 'pending',
        },
        isShowProgressDialog: false,
      );
    } else {
      CU.showNoInternetDialog(Get.context!, callServiceLeaveRequest);
      return;
    }

    LeaveAuthorizationModel model = LeaveAuthorizationModel.fromJson(resJson);
    leaveRequestList.value = model.getEmployeeLeaveLists ?? [];

    isLoading.value = false;
  }
}
