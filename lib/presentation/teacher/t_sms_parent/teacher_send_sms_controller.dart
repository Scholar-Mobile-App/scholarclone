import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/model/student/home_data_model.dart';
import 'package:scholar_clone/model/teacher/assign_homework/studen_list_model.dart';
import 'package:flutter/material.dart';
import 'package:scholar_clone/core/utils/api_client.dart';
import 'package:scholar_clone/core/utils/cs.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/core/utils/enum.dart';

class SendSMSController extends GetxController {
  Content data = Get.arguments[0];
  Map<String, dynamic> userInfo = Get.arguments[1];

  Map<String, dynamic> resJson = <String, dynamic>{};

  RxList<Student> studentList = <Student>[].obs;
  RxList<String> checkData = <String>[].obs;
  RxList<String> email = <String>[].obs;
  RxList<String> keyList = <String>[].obs;
  RxList<String> valueList = <String>[].obs;

  RxBool selectAll = false.obs;
  RxBool isLoading = false.obs;

  RxString message = "".obs;

  @override
  void onInit() {
    callServiceAllocate();
    super.onInit();
  }

  Future<void> callServiceAllocate() async {
    isLoading.value = true;

    var string = userInfo[CS.standard_division];
    var ans = string.split("||");
    Map<String, dynamic> body = <String, dynamic>{
      CS.token: userInfo[CS.token],
      "standard_id": ans[0].trim(),
      "division_id": ans[1].trim(),
      CS.teacher_id: userInfo[CS.teacher_id],
      CS.syear: userInfo[CS.syear] ?? syear,
      CS.type: "API",
      CS.sub_institute_id: userInfo[CS.sub_institute_id],
    };

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context,
        body: body,
        apiUrl: "https://erp.triz.co.in/allStudentListAPI",
        isShowProgressDialog: false,
      );
    } else {
      CU.showNoInternetDialog(Get.context!, callServiceAllocate);
      return;
    }

    if (resJson[CS.status].toString() == StatusCode.Success) {
      resJson[CS.data].forEach((s) {
        studentList.add(Student.fromJson(s));
      });
    } else if (resJson[CS.status].toString() == StatusCode.Error) {
      showDialog(
        builder: (context) => CU.showDiloag(context, resJson[CS.message]),
        barrierDismissible: false,
        context: Get.context!,
      );
    }

    isLoading.value = false;
  }

  Future<void> callServiceSendNoti(context) async {
    List emailIds = [];
    for (int i = 0; i < email.length; i++) {
      emailIds.add(email[i]);
    }

    Map<String, dynamic> body = <String, dynamic>{
      CS.teacher_id: userInfo[CS.teacher_id],
      for (int i = 0; i < keyList.length; i++) keyList[i]: valueList[i],
      "sms_text": message.value,
      CS.sub_institute_id: userInfo[CS.sub_institute_id],
      CS.syear: userInfo[CS.syear] ?? syear,
      CS.type: "API",
      CS.token: userInfo[CS.token]
    };

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        context,
        body: body,
        apiUrl: "https://erp.triz.co.in/teacherSendSmsParentsAPI",
        isShowProgressDialog: false,
      );
    } else {
      CU.showNoInternetDialog(context, callServiceSendNoti);
      return;
    }

    if (resJson[CS.status].toString() == StatusCode.Success) {
      Fluttertoast.showToast(
        msg: resJson[CS.message],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      Get.back();
    } else if (resJson[CS.status].toString() == StatusCode.Error) {
      showDialog(
        builder: (context) => CU.showDiloag(context, resJson[CS.message]),
        barrierDismissible: false,
        context: context,
      );
    }
  }
}
