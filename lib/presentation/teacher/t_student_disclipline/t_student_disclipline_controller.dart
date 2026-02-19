import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/api_client.dart';
import 'package:scholar_clone/core/utils/cs.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/core/utils/enum.dart';
import 'package:scholar_clone/model/teacher/assign_homework/section_model.dart';

import '../../../model/student/home_data_model.dart';

class TStudentDiscliplineController extends GetxController {
  Content data = Get.arguments[0];
  Map<String, dynamic> userInfo = Get.arguments[1];

  RxBool isLoading = false.obs;

  // RxString srNo = "".obs;
  // RxString mobile = "".obs;
  RxString performance = "".obs;
  RxString message = "".obs;
  RxString srNOError = "".obs;
  RxString standardError = "".obs;
  RxString divError = "".obs;
  RxString studentIDError = "".obs;
  RxString mobileError = "".obs;
  RxString performanceError = "".obs;
  RxString messageError = "".obs;

  RxInt stdId = 0.obs;
  RxInt divId = 0.obs;
  RxInt studentsId = 0.obs;

  Map<String, dynamic> resJson = <String, dynamic>{};

  StandardModel? standardModel;
  DivisionModel? divisionModel;

  RxList<String> stdName = <String>[].obs;
  RxList<String> divName = <String>[].obs;
  RxList studentList = [].obs;
  RxList<String> studentName = <String>[].obs;

  @override
  void onInit() {
    callServiceStandared();
    super.onInit();
  }

  bool valid() {
    final RxBool isValid = true.obs;
    srNOError.value = '';

    if (stdId.value == 0) {
      standardError.value = "Please select a standard";
      CU.showToast(Get.context!, standardError.value);
      isValid.value = false;
    } else if (divId.value == 0) {
      divError.value = "Please select a division";
      CU.showToast(Get.context!, divError.value);
      isValid.value = false;
    } else if (studentsId.value == 0) {
      studentIDError.value = "Please select a student name";
      CU.showToast(Get.context!, studentIDError.value);
      isValid.value = false;
    } else if (performance.value.isEmpty) {
      performanceError.value = "Please select performance";
      CU.showToast(Get.context!, performanceError.value);
      isValid.value = false;
    } else if (message.value.isEmpty) {
      messageError.value = "Please enter message";
      CU.showToast(Get.context!, messageError.value);
      isValid.value = false;
    }

    return isValid.value;
  }

  Future<void> callServiceStandared() async {
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
      CU.showNoInternetDialog(Get.context!, callServiceStandared);
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

  Future<void> callServiceDivision() async {
    Map<String, dynamic> body = <String, dynamic>{
      CS.token: userInfo[CS.token],
      CS.teacher_id: userInfo[CS.teacher_id],
      CS.type: "API",
      "standard_id": stdId,
      CS.syear: userInfo[CS.syear] ?? syear,
      CS.sub_institute_id: userInfo[CS.sub_institute_id],
    };

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context,
        body: body,
        apiUrl: "https://erp.triz.co.in/get_teacher_timetablewiseDivision",
        isShowProgressDialog: false,
      );
    } else {
      CU.showNoInternetDialog(Get.context!, callServiceStandared);
      return;
    }

    if (resJson[CS.status].toString() == StatusCode.Success) {
      DivisionModel model = DivisionModel.fromJson(resJson);
      divisionModel = model;
      for (int i = 0; i < model.data!.length; i++) {
        divName.add(model.data![i].divName!);
      }
    } else if (resJson[CS.status].toString() == StatusCode.Error) {
      showDialog(
        builder: (context) => CU.showDiloag(context, resJson[CS.message]),
        barrierDismissible: false,
        context: Get.context!,
      );
    }
  }

  Future<void> callServiceSearch() async {
    Map<String, dynamic> body = <String, dynamic>{
      CS.token: userInfo[CS.token],
      "standard_id": stdId.value,
      "division_id": divId.value,
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
      CU.showNoInternetDialog(Get.context!, callServiceSearch);
      return;
    }

    if (resJson[CS.status].toString() == StatusCode.Success) {
      studentList.value = resJson[CS.data];
      for (int i = 0; i < studentList.length; i++) {
        studentName.add(studentList[i]["student_name"]);
      }
    } else if (resJson[CS.status].toString() == StatusCode.Error) {
      showDialog(
        builder: (context) => CU.showDiloag(context, resJson[CS.message]),
        barrierDismissible: false,
        context: Get.context!,
      );
    }
  }

  Future<void> callServiceSubmit() async {
    isLoading.value = true;
    if (valid()) {
      Map<String, dynamic> body = <String, dynamic>{
        'data':
            '{"student_id":"${studentsId.value}","dicipline":"${performance.value}","message":"${message.value}"}',
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
          apiUrl: "https://erp.triz.co.in/add_teacherStudentDisciplineAPI",
          isShowProgressDialog: false,
        );
      } else {
        CU.showNoInternetDialog(Get.context!, callServiceSubmit);
        return;
      }

      if (resJson[CS.status].toString() == StatusCode.Success) {
        Fluttertoast.showToast(
          msg: resJson[CS.message],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.lightGreen,
          textColor: Colors.white,
        );
        isLoading.value = false;
        Get.back();
      } else if (resJson[CS.status].toString() == StatusCode.Error) {
        showDialog(
          builder: (context) => CU.showDiloag(context, resJson[CS.message]),
          barrierDismissible: false,
          context: Get.context!,
        );
        isLoading.value = false;
      }
      isLoading.value = false;
    }
    isLoading.value = false;
  }
}
