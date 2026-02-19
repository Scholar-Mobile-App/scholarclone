import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/enum.dart';
import 'package:scholar_clone/model/admin/get_admin_standard_model.dart';
import 'package:scholar_clone/model/student/home_data_model.dart';
import 'package:scholar_clone/model/teacher/assign_homework/section_model.dart';
import 'package:scholar_clone/model/teacher/assign_homework/studen_list_model.dart';

import '../../../core/utils/api_client.dart';
import '../../../core/utils/cs.dart';
import '../../../core/utils/cu.dart';

class AdminStudentProfileListController extends GetxController {
  Content data = Get.arguments[0];
  Map<String, dynamic> userInfo = Get.arguments[1];

  Map<String, dynamic> resJson = <String, dynamic>{};

  GetAdminStandardModel? standardModel;
  GetAdminDivisionModel? divisionModel;

  RxList<String> sectionNameList = <String>[].obs;
  RxList<Section> sectionList = <Section>[].obs;
  RxList<String> divList = <String>[].obs;
  RxList<String> divName = <String>[].obs;
  RxList<Student> studentList = <Student>[].obs;
  RxList<String> stdName = <String>[].obs;

  RxInt sectionID = 0.obs;
  RxInt stdId = 0.obs;
  RxInt divId = 0.obs;

  RxString section = "".obs;
  RxString standard = "".obs;
  RxString stdDiv = "".obs;

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

    sectionList.value = model.data!;
    for (int i = 0; i < sectionList.length; i++) {
      sectionNameList.add(sectionList[i].shortName!);
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

  Future<void> callServiceAllocate(stdDiv) async {
    var string = stdDiv;
    var ans = string.split("||");
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
  }
}
