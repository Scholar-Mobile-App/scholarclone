import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/api_client.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/core/utils/enum.dart';
import 'package:scholar_clone/model/student/home_data_model.dart';
import 'package:scholar_clone/model/student/transport_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/utils/cs.dart';

class TransportController extends GetxController {
  Content data = Get.arguments[0];
  Map<String, dynamic> userInfo = Get.arguments[1];

  RxBool isLoading = false.obs;

  Map<String, dynamic> resJson = {};

  RxList<Transport> trasportList = <Transport>[].obs;

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
      CS.token: userInfo[CS.token]
    };

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context!,
        body: body,
        apiUrl: "https://erp.triz.co.in/studentTransportAPI",
        isShowProgressDialog: false,
      );
    } else {
      return;
    }

    if (resJson["status"].toString() == StatusCode.Success.toString()) {
      TransportModel model = TransportModel.fromJson(resJson);

      for (var element in model.data!) {
        trasportList.add(element);
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

Future<void> launchGPS(String url) async {
  final Uri uri = Uri.parse(url);

  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    throw 'Could not launch $url';
  }
}


}
