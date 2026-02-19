import 'dart:developer';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scholar_clone/core/utils/api_client.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/model/student/home_data_model.dart';
import 'package:scholar_clone/model/teacher/proxy_management_model.dart';

import '../../../core/utils/cs.dart';

class TProxyManagementController extends GetxController {
  Content data = Get.arguments[0];
  Map<String, dynamic> userInfo = Get.arguments[1];

  RxBool isLoading = false.obs;

  RxList<Proxy> proxyList = <Proxy>[].obs;

  @override
  void onInit() {
    callService();
    super.onInit();
  }

  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();

  Map<String, dynamic> resJson = {};

  Future<void> callService() async {
    isLoading.value = true;
    proxyList.value = [];

    Map<String, dynamic> body = <String, dynamic>{
      CS.token: userInfo[CS.token],
      CS.sub_institute_id: userInfo[CS.sub_institute_id],
      if (userInfo["user_profile_name"] == "Teacher")
        CS.teacher_id: userInfo[CS.teacher_id],
      // if (userInfo["user_profile_name"] == "Teacher")
      "from_date": DateFormat('yyyy-MM-dd').format(fromDate),
      // if (userInfo["user_profile_name"] == "Teacher")
      "to_date": DateFormat('yyyy-MM-dd').format(toDate)
    };

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context,
        body: body,
        apiUrl: userInfo["user_profile_name"] == "Admin"
            ? "https://erp.triz.co.in/get_adminTodaysProxyListAPI"
            : "https://erp.triz.co.in/get_proxy_master",
        isShowProgressDialog: false,
      );
    } else {
      CU.showNoInternetDialog(Get.context!, callService);
      return;
    }

    // if (resJson[CS.status] == StatusCode.Success) {
    log("......................vbn");
    ProxyManagementModel model = ProxyManagementModel.fromJson(resJson);
    proxyList.value = model.data!;
    log("......................vbn......${proxyList.length}");
    // } else if (resJson[CS.status].toString() == StatusCode.Error) {
    //   log("............................${proxyList.length}");
    //   // showDialog(
    //   //     builder: (context) => CU.showDiloag(context, resJson[CS.message]),
    //   //     barrierDismissible: false,
    //   //     context: context);

    //   isLoading.value = false;
    // }
    isLoading.value = false;
  }
}
