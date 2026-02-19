import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/api_client.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/core/utils/enum.dart';
import 'package:scholar_clone/model/student/home_data_model.dart';
import 'package:scholar_clone/model/teacher/teacher_calander_model.dart';
import 'package:scholar_clone/model/teacher/teacher_fetch_data_model.dart';

import '../../../core/utils/cs.dart';

class TeacherCalanderController extends GetxController {
  Content data = Get.arguments[0];
  Map<String, dynamic> userInfo = Get.arguments[1];

  Map<String, dynamic> resJson = {};

  final GlobalKey<FormFieldState> sectionKey = GlobalKey<FormFieldState>();

  RxList<TeacherCalander> stdList = <TeacherCalander>[].obs;
  RxList<TeacherFetchData> teacherFetchDataList = <TeacherFetchData>[].obs;
  RxList<String> stdName = <String>[].obs;
  RxList<TeacherFetchData> filterteacherList = <TeacherFetchData>[].obs;

  RxInt stdId = 0.obs;

  RxString searchSubject = "".obs;

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    callServiceStandared();
    super.onInit();
  }

  Future<void> callServiceStandared() async {
    isLoading.value = true;
    Map<String, dynamic> body = <String, dynamic>{
      CS.token: userInfo[CS.token],
      CS.teacher_id: userInfo[CS.teacher_id],
      CS.type: "API",
      CS.syear: userInfo[CS.syear] ?? syear,
      CS.sub_institute_id: userInfo[CS.sub_institute_id],
    };

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context!,
        body: body,
        apiUrl: "https://erp.triz.co.in/get_teacher_timetablewiseStandard",
        isShowProgressDialog: false,
      );
    } else {
      CU.showNoInternetDialog(Get.context!, callServiceStandared);
      return;
    }

    if (resJson[CS.status].toString() == StatusCode.Success) {
      TeacherCalanderModel model = TeacherCalanderModel.fromJson(resJson);
      stdList.value += model.data!;

      for (var i = 0; i < stdList.length; i++) {
        stdName.add(stdList[i].stdName!);
      }

      stdId.value = stdList[0].stdId!;
      callServiceFetchData();
    } else if (resJson[CS.status].toString() == StatusCode.Error) {
      showDialog(
        builder: (context) => CU.showDiloag(context, resJson[CS.message]),
        barrierDismissible: false,
        context: Get.context!,
      );
      isLoading.value = false;
    }
  }

  Future<void> callServiceFetchData() async {
    Map<String, dynamic> body = <String, dynamic>{
      CS.token: userInfo[CS.token],
      "standard_id": stdId,
      CS.syear: userInfo[CS.syear] ?? syear,
      CS.sub_institute_id: userInfo[CS.sub_institute_id],
    };

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context!,
        body: body,
        apiUrl: "https://erp.triz.co.in/calendar/TeacherFetchData",
        isShowProgressDialog: false,
      );
    } else {
      CU.showNoInternetDialog(Get.context!, callServiceStandared);
      return;
    }

    if (resJson[CS.status].toString() == StatusCode.Success) {
      TeacherFetchDataModel model = TeacherFetchDataModel.fromJson(resJson);

      teacherFetchDataList.value = model.data!;
      filterteacherList.value = teacherFetchDataList;
      isLoading.value = false;
    } else if (resJson[CS.status].toString() == StatusCode.Error) {
      showDialog(
        builder: (context) => CU.showDiloag(context, resJson[CS.message]),
        barrierDismissible: false,
        context: Get.context!,
      );
    }
  }
}
