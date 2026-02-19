import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/api_client.dart';
import 'package:scholar_clone/core/utils/cs.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/core/utils/enum.dart';
import 'package:scholar_clone/model/student/home_data_model.dart';
import 'package:scholar_clone/model/teacher/assign_homework/section_model.dart';
import 'package:scholar_clone/model/teacher/circular_list_model.dart';

class CircularListController extends GetxController {
  Content data = Get.arguments[0];
  Map<String, dynamic> userInfo = Get.arguments[1];

  RxBool isLoading = false.obs;

  RxList<CircularList> circularList = <CircularList>[].obs;
  RxList<String> stdName = <String>[].obs;
  RxInt stdId = 0.obs;

  StandardModel? standardModel;

  @override
  void onInit() {
    callServiceStandard();
    super.onInit();
  }

  Map<String, dynamic> resJson = {};

  Future<void> callServiceStandard() async {
    Map<String, dynamic> body = <String, dynamic>{
      CS.token: userInfo[CS.token],
      CS.teacher_id: userInfo[CS.teacher_id],
      CS.type: "API",
      CS.syear: userInfo[CS.syear] ?? syear,
      CS.sub_institute_id: userInfo[CS.sub_institute_id],
    };

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context,
        body: body,
        apiUrl: "https://erp.triz.co.in/get_teacher_timetablewiseStandard",
        isShowProgressDialog: false,
      );
    } else {
      CU.showNoInternetDialog(Get.context!, callServiceStandard);
      return;
    }

    if (resJson[CS.status].toString() == StatusCode.Success) {
      StandardModel model = StandardModel.fromJson(resJson);

      standardModel = model;

      for (int i = 0; i < model.data!.length; i++) {
        stdName.add(model.data![i].stdName!);
      }
    } else if (resJson[CS.status].toString() == StatusCode.Error) {
      showDialog(
        builder: (context) => CU.showDiloag(context, resJson[CS.message]),
        barrierDismissible: true,
        context: Get.context!,
      );
    }
  }

  Future<void> callService(int standardID) async {
    isLoading.value = true;
    circularList.clear();

    Map<String, dynamic> body = <String, dynamic>{
      CS.token: userInfo[CS.token],
      CS.sub_institute_id: userInfo[CS.sub_institute_id],
      "syear": userInfo[CS.syear] ?? syear,
      "standard_id": standardID,
    };

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context,
        callMethod: CallMethod.post,
        body: body,
        apiUrl: "https://erp.triz.co.in/circular/TeacherFetchData",
        isShowProgressDialog: false,
      );
    } else {
      CU.showNoInternetDialog(Get.context!, callService);
      return;
    }

    if (resJson[CS.status] == "1") {
      CircularListModel model = CircularListModel.fromJson(resJson);
      circularList.value += model.data!;
    } else if (resJson[CS.status].toString() == StatusCode.Error) {
      Get.back();
    }
    isLoading.value = false;
  }
}
