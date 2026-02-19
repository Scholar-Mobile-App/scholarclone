import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/api_client.dart';
import 'package:scholar_clone/core/utils/enum.dart';
import 'package:scholar_clone/model/student/certificate_model.dart';
import 'package:scholar_clone/model/student/home_data_model.dart';

import '../../../core/utils/cs.dart';
import '../../../core/utils/cu.dart';

class CertificateController extends GetxController {
  Content data = Get.arguments[0];
  Map<String, dynamic> userInfo = Get.arguments[1];

  RxBool isLoading = false.obs;

  Map<String, dynamic> resJson = {};

  RxList<Certificate> certificateList = <Certificate>[].obs;

  @override
  void onInit() {
    callService();
    super.onInit();
  }

  Future<void> callService() async {
    isLoading.value = true;

    Map<String, dynamic> body = <String, dynamic>{
      CS.syear: userInfo[CS.syear] ?? syear,
      CS.sub_institute_id: userInfo[CS.sub_institute_id],
      CS.student_id: userInfo[CS.student_id],
      CS.token: userInfo[CS.token],
      CS.type: "API"
    };

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context,
        body: body,
        apiUrl: data.subTitleApi,
        isShowProgressDialog: false,
      );
    } else {
      return;
    }

    if (resJson[CS.status_code].toString() == StatusCode.Success) {
      CertificateListModel model = CertificateListModel.fromJson(resJson);

      for (var i = 0; i < model.data!.length; i++) {
        certificateList.add(model.data![i]);
      }
    } else if (resJson[CS.status].toString() == StatusCode.Error) {
      showDialog(
        builder: (context) => CU.showDiloag(context, resJson[CS.message]),
        barrierDismissible: false,
        context: Get.context!,
      );
    }
    isLoading.value = false;
  }
}
