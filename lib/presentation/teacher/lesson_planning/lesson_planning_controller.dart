import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/api_client.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/core/utils/enum.dart';
import 'package:scholar_clone/core/utils/utility.dart';
import 'package:scholar_clone/model/student/home_data_model.dart';
import 'package:scholar_clone/model/teacher/assign_homework/section_model.dart';

import '../../../core/utils/cs.dart';

class LessonPlanningController extends GetxController {
  Content data = Get.arguments[0];
  Map<String, dynamic> userInfo = Get.arguments[1];

  RxBool isLoading = false.obs;

  RxList<Standard> stdList = <Standard>[].obs;
  RxList<Division> divList = <Division>[].obs;
  RxList<TeacherSubject> subjectList = <TeacherSubject>[].obs;
  RxList<String> stdName = <String>[].obs;
  RxList<String> divName = <String>[].obs;
  RxList<String> subjectName = <String>[].obs;

  RxInt stdID = 0.obs;
  RxInt divID = 0.obs;
  RxInt subjectId = 0.obs;

  RxString standard = "".obs;
  RxString selectSubject = "".obs;
  RxString title = "".obs;

  Rx<DateTime> selectedDate = DateTime.now().obs;

  final GlobalKey<FormFieldState> standardKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> divisionKey = GlobalKey<FormFieldState>();

  Map<String, dynamic> resJson = {};

  @override
  void onInit() {
    callServiceStandared();
    super.onInit();
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
      stdList.value = model.data!;
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
      "standard_id": stdID.value,
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
      divList.value = model.data!;
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

  Future<void> callServiceSubject(standardId) async {
    Map<String, dynamic> body = <String, dynamic>{
      CS.teacher_id: userInfo[CS.teacher_id],
      "standard_id": standardId,
      CS.token: userInfo[CS.token],
      CS.type: "API",
      CS.syear: userInfo[CS.syear] ?? syear,
      CS.sub_institute_id: userInfo[CS.sub_institute_id],
    };

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context!,
        body: body,
        apiUrl: "https://erp.triz.co.in/get_teacher_timetablewiseSubject",
        isShowProgressDialog: false,
      );
    } else {
      CU.showNoInternetDialog(Get.context!, callServiceSubject);
      return;
    }

    TeacherSubjectModel model = TeacherSubjectModel.fromJson(resJson);
    subjectList.value = model.data!;
    for (int i = 0; i < model.data!.length; i++) {
      subjectName.add(model.data![i].subName!);
    }
  }

  Future<void> callServiceSubmit(context) async {
    Map<String, dynamic> body = <String, dynamic>{
      CS.syear: userInfo[CS.syear] ?? syear,
      CS.token: userInfo[CS.token],
      CS.type: "API",
      CS.sub_institute_id: userInfo[CS.sub_institute_id],
      CS.teacher_id: userInfo[CS.teacher_id],
      CS.user_profile_id: userInfo[CS.user_profile_id],
      "standard_id": standard.value,
      "subject_id": subjectId.value,
      "division_id": divID.value,
      "date": selectedDate.value,
      "title": title.value
    };

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context,
        body: body,
        apiUrl: "https://erp.triz.co.in/add_teacherLessonPlanning",
        isShowProgressDialog: false,
      );
    } else {
      CU.showNoInternetDialog(Get.context!, callServiceStandared);
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
    } else if (resJson[CS.status].toString() == StatusCode.Error) {
      showDialog(
        builder: (context) => CU.showDiloag(context, resJson[CS.message]),
        barrierDismissible: true,
        context: Get.context!,
      );
    }
  }
}
