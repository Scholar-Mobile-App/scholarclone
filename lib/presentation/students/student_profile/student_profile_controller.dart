import 'dart:developer';

import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/api_client.dart';
import 'package:scholar_clone/core/utils/cs.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/core/utils/enum.dart';
import 'package:scholar_clone/presentation/students/student_main/student_main_controller.dart';

class StudentProfileController extends GetxController {
  StudentMainController studentProfileController = Get.find();

  @override
  void onInit() {
    callService();
    super.onInit();
  }

  Map<String, dynamic>? resJson;

  callService() async {
    Map<String, dynamic> body = <String, dynamic>{
      CS.token: studentProfileController.data[CS.token],
      CS.student_id: studentProfileController.data[CS.student_id],
      CS.mobile_no: studentProfileController.data[CS.mobile],
      CS.syear: studentProfileController.data[CS.syear] ?? syear,
      CS.sub_institute_id: studentProfileController.data[CS.sub_institute_id],
    };
    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(Get.context,
          body: body,
          apiUrl: "https://erp.triz.co.in/notificationHubAPI",
          isShowProgressDialog: false);
    } else {
      CU.showNoInternetDialog(Get.context!, callService);
      return;
    }

    if (resJson![CS.status].toString() == StatusCode.Success.toString()) {
      log(resJson.toString());
    } else if (resJson![CS.status].toString() == StatusCode.Error) {}
  }
}
