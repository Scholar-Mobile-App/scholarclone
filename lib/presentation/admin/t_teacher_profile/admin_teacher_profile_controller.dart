import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/api_client.dart';
import 'package:scholar_clone/core/utils/cs.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/core/utils/enum.dart';
import 'package:scholar_clone/model/admin/admin_teacher_model.dart';
import 'package:scholar_clone/model/student/home_data_model.dart';

class AdminTeacherProfileController extends GetxController {
  Content data = Get.arguments[0];
  Map<String, dynamic> userInfo = Get.arguments[1];

  Map<String, dynamic> resJson = {};

  RxList<AdminTeacherProfile> teacherProfileList = <AdminTeacherProfile>[].obs;

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    callService();
    super.onInit();
  }

  Future<void> callService() async {
    Map<String, dynamic> body = <String, dynamic>{
      CS.token: userInfo[CS.token],
      CS.sub_institute_id: userInfo[CS.sub_institute_id],
    };

    isLoading.value = true;

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(Get.context,
          body: body,
          apiUrl: "https://erp.triz.co.in/get_adminTeacherList",
          isShowProgressDialog: false);
    } else {
      CU.showNoInternetDialog(Get.context!, callService);
      return;
    }

    if (resJson[CS.status].toString() == StatusCode.Success) {
      AdminTeacherProfileModel model =
          AdminTeacherProfileModel.fromJson(resJson);

      teacherProfileList.value += model.data!;

      isLoading.value = false;
    } else if (resJson[CS.status].toString() == StatusCode.Error) {
      showDialog(
        builder: (context) => CU.showDiloag(context, resJson[CS.message]),
        barrierDismissible: false,
        context: Get.context!,
      );
      isLoading.value = false;
    }
  }
}
