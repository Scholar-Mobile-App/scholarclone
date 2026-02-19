import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/api_client.dart';
import 'package:scholar_clone/core/utils/cs.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/core/utils/enum.dart';
import 'package:scholar_clone/model/student/home_data_model.dart';
import 'package:scholar_clone/model/student/parent_communication_model.dart';

class ParentCommunicationController extends GetxController {
  Content data = Get.arguments[0];
  Map<String, dynamic> userInfo = Get.arguments[1];

  @override
  void onInit() {
    callServiceData();
    super.onInit();
  }

  TextEditingController subjectCon = TextEditingController();
  TextEditingController questionCon = TextEditingController();
  RxString subjectError = "".obs;
  RxString questionError = "".obs;

  Map<String, dynamic>? resJson;

  RxList<Communication> communicationList = <Communication>[].obs;
  RxBool isLoading = false.obs;

  bool valid() {
    RxBool isValid = true.obs;

    if (subjectCon.text.isEmpty) {
      subjectError.value = "Please enter subject";
      isValid.value = false;
    }

    if (questionCon.text.isEmpty) {
      questionError.value = "Please enter question";
      isValid.value = false;
    }

    return isValid.value;
  }

  Future<void> callService() async {
    Map<String, dynamic> body = <String, dynamic>{
      CS.student_id: userInfo[CS.student_id],
      CS.syear: userInfo[CS.syear] ?? syear,
      CS.message: questionCon.text,
      CS.title: subjectCon.text,
      CS.sub_institute_id: userInfo[CS.sub_institute_id],
      CS.type: "API",
      CS.token: userInfo[CS.token],
    };

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context,
        body: body,
        apiUrl: CS.add_communication,
        isShowProgressDialog: false,
      );
    } else {
      CU.showNoInternetDialog(Get.context!, callService);
      return;
    }

    if (resJson![CS.status].toString() == StatusCode.Success) {
      Fluttertoast.showToast(
        msg: resJson![CS.message],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      Get.back();
    } else if (resJson![CS.status_code].toString() == StatusCode.Error ||
        resJson![CS.status].toString() == StatusCode.Authentication) {
      showDialog(
        builder: (context) => CU.showDiloag(context, resJson![CS.message]),
        barrierDismissible: false,
        context: Get.context!,
      );
    }
  }

  Future<void> callServiceData() async {
    Map<String, dynamic> body = <String, dynamic>{
      CS.syear: userInfo[CS.syear] ?? syear,
      CS.student_id: userInfo[CS.student_id],
      CS.token: userInfo[CS.token],
      CS.sub_institute_id: userInfo[CS.sub_institute_id],
      CS.type: "API",
    };

    isLoading.value = true;

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context!,
        body: body,
        apiUrl: CS.add_communication_data,
        isShowProgressDialog: false,
      );
    } else {
      CU.showNoInternetDialog(Get.context!, callService);
      return;
    }
    if (resJson!['status_code'].toString() == StatusCode.Success) {
      resJson![CS.data].forEach((element) {
        communicationList.add(Communication.fromJson(element));
      });

      isLoading.value = false;
    } else if (resJson![CS.status_code].toString() == StatusCode.Error ||
        resJson![CS.status].toString() == StatusCode.Authentication) {
      showDialog(
        builder: (context) => CU.showDiloag(context, resJson![CS.message]),
        barrierDismissible: false,
        context: Get.context!,
      );
      isLoading.value = false;
    }
  }
}
