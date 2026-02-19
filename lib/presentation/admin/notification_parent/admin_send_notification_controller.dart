import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/utility.dart';
import 'package:scholar_clone/model/student/home_data_model.dart';
import 'package:scholar_clone/model/teacher/assign_homework/section_model.dart';
import 'package:scholar_clone/model/teacher/assign_homework/studen_list_model.dart';
import 'package:flutter/material.dart';
import 'package:scholar_clone/core/utils/api_client.dart';
import 'package:scholar_clone/core/utils/cs.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/core/utils/enum.dart';

import '../../../model/admin/get_admin_standard_model.dart';

class AdminSendNotificationController extends GetxController {
  Content data = Get.arguments[0];
  Map<String, dynamic> userInfo = Get.arguments[1];

  Map<String, dynamic> resJson = <String, dynamic>{};

  RxList<String> sectionName = <String>[].obs;
  RxList<Student> studentList = <Student>[].obs;
  RxList<String> checkData = <String>[].obs;
  RxList<String> email = <String>[].obs;
  RxList<String> keyList = <String>[].obs;
  RxList<String> valueList = <String>[].obs;
  RxList<String> stdName = <String>[].obs;
  RxList<String> divName = <String>[].obs;

  SectionModel? sectionModel;
  GetAdminStandardModel? standardModel;
  GetAdminDivisionModel? divisionModel;

  RxBool selectAll = false.obs;
  RxBool isLoading = false.obs;
  RxBool isStudentLoading = false.obs;
  RxBool isAPIcalling = false.obs;

  RxString message = "".obs;
  RxString studentId = "".obs;

  RxInt sectionID = 0.obs;
  RxInt stdId = 0.obs;
  RxInt divId = 0.obs;

  @override
  void onInit() {
    callServiceSection();
    super.onInit();
  }

  Future<void> callServiceSection() async {
    Map<String, dynamic> body = <String, dynamic>{
      CS.token: userInfo[CS.token],
      CS.sub_institute_id: userInfo[CS.sub_institute_id],
    };

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context!,
        body: body,
        apiUrl: "https://erp.triz.co.in/get_adminAcademicSection",
        isShowProgressDialog: false,
      );
    } else {
      CU.showNoInternetDialog(Get.context!, callServiceSection);
      return;
    }

    SectionModel model = SectionModel.fromJson(resJson);
    sectionModel = model;
    for (var i = 0; i < model.data!.length; i++) {
      sectionName.add(model.data![i].shortName!);
    }
  }

  Future<void> callServiceStandared(sectionID) async {
    Map<String, dynamic> adminBody = <String, dynamic>{
      CS.token: userInfo[CS.token],
      CS.sub_institute_id: userInfo[CS.sub_institute_id],
      "grade_id": sectionID
    };

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context,
        body: adminBody,
        apiUrl: "https://erp.triz.co.in/get_adminStandard",
        isShowProgressDialog: false,
      );
    } else {
      CU.showNoInternetDialog(Get.context!, callServiceStandared);
      return;
    }

    if (resJson[CS.status].toString() == StatusCode.Success) {
      GetAdminStandardModel model = GetAdminStandardModel.fromJson(resJson);
      standardModel = model;
      for (int i = 0; i < model.data!.length; i++) {
        stdName.add(model.data![i].name!);
      }
    } else if (resJson[CS.status].toString() == StatusCode.Error) {
      showDialog(
        builder: (context) => CU.showDiloag(context, resJson[CS.message]),
        barrierDismissible: true,
        context: Get.context!,
      );
    }
  }

  Future<void> callServiceDivision(standardId) async {
    Map<String, dynamic> body = <String, dynamic>{
      CS.token: userInfo[CS.token],
      "standard_id": standardId,
      CS.sub_institute_id: userInfo[CS.sub_institute_id],
    };

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context,
        body: body,
        apiUrl: "https://erp.triz.co.in/get_adminDivision",
        isShowProgressDialog: false,
      );
    } else {
      CU.showNoInternetDialog(Get.context!, callServiceStandared);
      return;
    }

    if (resJson[CS.status].toString() == StatusCode.Success) {
      GetAdminDivisionModel model = GetAdminDivisionModel.fromJson(resJson);
      divisionModel = model;
      for (int i = 0; i < model.data!.length; i++) {
        divName.add(model.data![i].name!);
      }
    } else if (resJson[CS.status].toString() == StatusCode.Error) {
      showDialog(
        builder: (context) => CU.showDiloag(context, resJson[CS.message]),
        barrierDismissible: false,
        context: Get.context!,
      );
    }
  }

  Future<void> callServiceAllocate() async {
    isStudentLoading.value = true;

    Map<String, dynamic> body = <String, dynamic>{
      CS.token: userInfo[CS.token],
      "grade_id": sectionID.value,
      "standard_id": stdId.value,
      "division_id": divId.value,
      CS.syear: userInfo[CS.syear] ?? syear,
      CS.sub_institute_id: userInfo[CS.sub_institute_id],
    };

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context,
        body: body,
        apiUrl: "https://erp.triz.co.in/get_adminStudentList",
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

    isStudentLoading.value = false;
  }

  Future<void> callServiceSendNoti(context) async {
    isAPIcalling.value = true;

    var emails = '';
    for (int i = 0; i < email.length; i++) {
      emails += '${email[i]},';
      studentId.value =
          emails.replaceRange(emails.length - 1, emails.length, '');
    }

    Map<String, dynamic> body = <String, dynamic>{
      CS.user_id: userInfo[CS.user_id],
      CS.student_id: studentId.value,
      "description": message.value,
      CS.sub_institute_id: userInfo[CS.sub_institute_id],
      CS.syear: userInfo[CS.syear] ?? syear,
      CS.token: userInfo[CS.token]
    };

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        context,
        body: body,
        apiUrl: "https://erp.triz.co.in/add_SendNotificationAPI",
        isShowProgressDialog: false,
      );
    } else {
      CU.showNoInternetDialog(context, callServiceSendNoti);
      return;
    }

    if (resJson[CS.status].toString() == StatusCode.Success) {
      showToast(
        context: context,
        message: resJson[CS.message],
        color: Colors.green,
        icons: Icons.check_circle_outline,
      );
      Get.back();
      isAPIcalling.value = false;
    } else if (resJson[CS.status].toString() == StatusCode.Error) {
      showDialog(
        builder: (context) => CU.showDiloag(context, resJson[CS.message]),
        barrierDismissible: false,
        context: context,
      );
      isAPIcalling.value = false;
    }
  }
}
