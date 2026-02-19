import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/api_client.dart';
import 'package:scholar_clone/core/utils/cs.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/core/utils/enum.dart';
import 'package:scholar_clone/model/admin/get_admin_standard_model.dart';
import 'package:scholar_clone/model/teacher/assign_homework/section_model.dart';

import '../../../model/student/home_data_model.dart';

class AdminStudentDiscliplineController extends GetxController {
  Content data = Get.arguments[0];
  Map<String, dynamic> userInfo = Get.arguments[1];

  RxBool isLoading = false.obs;

  RxString mobile = "".obs;
  RxString performance = "".obs;
  RxString message = "".obs;
  RxString standardError = "".obs;
  RxString divError = "".obs;
  RxString studentIDError = "".obs;
  RxString mobileError = "".obs;
  RxString performanceError = "".obs;
  RxString messageError = "".obs;

  RxInt stdId = 0.obs;
  RxInt divId = 0.obs;
  RxInt studentsId = 0.obs;
  RxInt sectionID = 0.obs;

  Map<String, dynamic> resJson = <String, dynamic>{};

  SectionModel? sectionModel;
  GetAdminStandardModel? standardModel;
  GetAdminDivisionModel? divisionModel;

  RxList<String> sectionName = <String>[].obs;
  RxList<String> stdName = <String>[].obs;
  RxList<String> divName = <String>[].obs;
  RxList studentList = [].obs;
  RxList<String> studentName = <String>[].obs;

  final GlobalKey<FormFieldState> sectionKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> standardKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> divKey = GlobalKey<FormFieldState>();

  @override
  void onInit() {
    callServiceSection();
    super.onInit();
  }

  bool valid() {
    final RxBool isValid = true.obs;

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
    } else if (mobile.value.isEmpty) {
      mobileError.value = "Please enter valid mobile number";
      CU.showToast(Get.context!, mobileError.value);
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
    stdName.value = [];
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

  Future<void> callServiceSearch() async {
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
        CS.teacher_id: userInfo[CS.user_id],
        CS.type: "API",
        CS.syear: userInfo[CS.syear] ?? syear,
        CS.sub_institute_id: userInfo[CS.sub_institute_id],
      };

      if (await CU.checkInternet()) {
        resJson = await ApiClient.call(Get.context,
            body: body,
            apiUrl: "https://erp.triz.co.in/add_teacherStudentDisciplineAPI",
            isShowProgressDialog: false);
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
