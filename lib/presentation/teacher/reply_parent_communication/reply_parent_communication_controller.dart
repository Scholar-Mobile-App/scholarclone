import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/api_client.dart';
import 'package:scholar_clone/core/utils/cs.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/core/utils/enum.dart';
import 'package:scholar_clone/model/student/home_data_model.dart';
import 'package:scholar_clone/model/teacher/reply_parent_comm.dart';

class ReplyParentCommunicationController extends GetxController {
  Content data = Get.arguments[0];
  Map<String, dynamic> userInfo = Get.arguments[1];

  RxBool isLoading = false.obs;

  Map<String, dynamic> resJson = <String, dynamic>{};

  RxList<ReplyParent> dataList = <ReplyParent>[].obs;

  // TextEditingController messageController = TextEditingController();

  dynamic message;

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
      if (userInfo["user_profile_name"] == "Teacher")
        CS.teacher_id: userInfo[CS.teacher_id],
      if (userInfo["user_profile_name"] == "Teacher") CS.type: "API",
      CS.token: userInfo[CS.token],
    };

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context,
        body: body,
        apiUrl: userInfo["user_profile_name"] == "Admin"
            ? "https://erp.triz.co.in/get_adminParentCommunicationListAPI"
            : "https://erp.triz.co.in/teacherParentcommunicationListAPI",
        isShowProgressDialog: false,
      );
    } else {
      return;
    }

    if (resJson[CS.status].toString() == StatusCode.Success) {
      ReplyParentComModel model = ReplyParentComModel.fromJson(resJson);

      for (var i = 0; i < model.data!.length; i++) {
        dataList.add(model.data![i]);
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

  Future<void> callServiceReply(ReplyParent lstData, context) async {
    Map<String, dynamic> body = <String, dynamic>{
      CS.teacher_id: userInfo[CS.teacher_id],
      "parent_comm_id": lstData.parentCommId,
      "reply": lstData.reply!.text,
      CS.type: "API",
      CS.sub_institute_id: userInfo[CS.sub_institute_id],
      CS.syear: userInfo["syear"] ?? syear,
      "reply_on": DateTime.now(),
      CS.token: userInfo[CS.token]
    };

    Map<String, dynamic> adminBody = <String, dynamic>{
      "admin_id": userInfo["user_id"],
      "parent_communication_id": lstData.parentCommId,
      "reply": lstData.reply!.text,
      CS.sub_institute_id: userInfo[CS.sub_institute_id],
      CS.syear: userInfo["syear"] ?? syear,
      CS.token: userInfo[CS.token]
    };

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context,
        body: userInfo["user_profile_name"] == "Admin" ? adminBody : body,
        apiUrl: userInfo["user_profile_name"] == "Admin"
            ? "https://erp.triz.co.in/add_adminParentCommunicationSaveAPI"
            : "https://erp.triz.co.in/teacherParentcommunicationSaveAPI",
        isShowProgressDialog: false,
      );
    } else {
      CU.showNoInternetDialog(context, callServiceReply);
      return;
    }

    if (resJson["status_code"].toString() == StatusCode.Success ||
        resJson[CS.status].toString() == StatusCode.Success) {
      dataList.clear();
      callService();
    } else if (resJson[CS.status].toString() == StatusCode.Error) {
      showDialog(
        builder: (context) => CU.showDiloag(context, resJson[CS.message]),
        barrierDismissible: false,
        context: Get.context!,
      );
    }
  }
}
