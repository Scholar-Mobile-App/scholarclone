import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scholar_clone/core/utils/api_client.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/core/utils/enum.dart';
import 'package:scholar_clone/model/student/home_data_model.dart';
import 'package:scholar_clone/model/teacher/admin_academic_section_model.dart';
import 'package:scholar_clone/model/teacher/admin_standard_model.dart';
import 'package:scholar_clone/model/teacher/assign_homework/studen_list_model.dart';
import 'package:scholar_clone/model/teacher/exam_type_model.dart';
import 'package:scholar_clone/presentation/widgets/download_manager.dart';

import '../../../core/utils/cs.dart';

class FeesCollectController extends GetxController {
  Content data = Get.arguments[0];
  Map<String, dynamic> userInfo = Get.arguments[1];

  final GlobalKey<FormFieldState> sectionKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> standardKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> divisionKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> examKey = GlobalKey<FormFieldState>();

  RxList<AcademicSection> sectionList = <AcademicSection>[].obs;
  RxList<String> sectionNameList = <String>[].obs;
  RxList<String> stdName = <String>[].obs;
  RxList<String> divName = <String>[].obs;
  RxList<String> examName = <String>[].obs;
  RxList<AdminStandard> stdList = <AdminStandard>[].obs;
  RxList divList = [].obs;
  RxList<Student> studentList = <Student>[].obs;
  RxList<ExamType> examTypeList = <ExamType>[].obs;

  RxString setction = "".obs;
  RxString standard = "".obs;
  RxString selectExamName = "".obs;

  RxInt sectionID = 0.obs;
  RxInt stdID = 0.obs;
  RxInt divID = 0.obs;
  RxInt examID = 0.obs;

  Rx<DateTime> fromDate = DateTime.now().obs;
  Rx<DateTime> toDate = DateTime.now().obs;

  Map<String, dynamic> resJson = {};

  @override
  void onInit() {
    callServiceSection();

    super.onInit();
  }

  Future<void> callServiceSection() async {
    sectionNameList.clear();
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

    AdminAcademicSectionModel model =
        AdminAcademicSectionModel.fromJson(resJson);

    sectionList.value = model.data!;

    for (var i = 0; i < sectionList.length; i++) {
      sectionNameList.add(sectionList[i].shortName!);
    }
  }

  Future<void> callServiceStandard(int sectionId) async {
    stdName.value = [];
    Map<String, dynamic> body = <String, dynamic>{
      CS.token: userInfo[CS.token],
      CS.sub_institute_id: userInfo[CS.sub_institute_id],
      "grade_id": sectionId
    };

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context!,
        body: body,
        apiUrl: "https://erp.triz.co.in/get_adminStandard",
        isShowProgressDialog: false,
      );
    } else {
      CU.showNoInternetDialog(Get.context!, callServiceStandard);
      return;
    }

    if (resJson[CS.status].toString() == StatusCode.Success) {
      AdminStandardModel model = AdminStandardModel.fromJson(resJson);

      stdList.value = model.data!;

      for (int i = 0; i < stdList.length; i++) {
        if (!stdName.contains(stdList[i].name.toString())) {
          stdName.add(stdList[i].name.toString());
        }
      }
    } else if (resJson[CS.status].toString() == StatusCode.Error) {
      showDialog(
        builder: (context) => CU.showDiloag(context, resJson[CS.message]),
        barrierDismissible: false,
        context: Get.context!,
      );
    }
  }

  Future<void> callServiceDivision(int stdId) async {
    Map<String, dynamic> body = <String, dynamic>{
      CS.token: userInfo[CS.token],
      "standard_id": stdId,
      CS.sub_institute_id: userInfo[CS.sub_institute_id],
    };

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context!,
        body: body,
        apiUrl: "https://erp.triz.co.in/get_adminDivision",
        isShowProgressDialog: false,
      );
    } else {
      CU.showNoInternetDialog(Get.context!, callServiceDivision);
      return;
    }

    if (resJson[CS.status].toString() == StatusCode.Success) {
      divList.value = resJson[CS.data];

      for (int i = 0; i < divList.length; i++) {
        if (!divName.contains(divList[i]["name"])) {
          divName.add(divList[i]["name"]);
        }
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
      "grade_id": sectionID,
      "standard_id": stdID.value,
      "division_id": divID.value,
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
      CU.showNoInternetDialog(Get.context!, callServiceSearch);
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

  Future<void> callServiceReport(int id) async {
    Map<String, dynamic> body = <String, dynamic>{
      CS.student_id: id,
      CS.sub_institute_id: userInfo[CS.sub_institute_id],
      CS.type: "API",
      "from_date": DateFormat('yyyy-MM-dd').format(fromDate.value),
      "to_date": DateFormat('yyyy-MM-dd').format(toDate.value),
      CS.syear: userInfo[CS.syear] ?? syear,
      CS.token: userInfo[CS.token],
      if (selectExamName.value.isNotEmpty) "exam_type": examID.value,
    };

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context,
        body: body,
        apiUrl: "https://erp.triz.co.in/get_wrtreportAPI",
        isShowProgressDialog: false,
      );
    } else {
      CU.showNoInternetDialog(Get.context!, callServiceReport);
      return;
    }

    if (resJson[CS.status].toString() == StatusCode.Success) {
      downloadExport(
        context: Get.context!,
        fileUrl: resJson[CS.data]["file_name"],
        filename: resJson[CS.data]["file_name"],
        open: true,
      );
    } else if (resJson[CS.status].toString() == StatusCode.Error) {
      showDialog(
        builder: (context) => CU.showDiloag(context, resJson[CS.message]),
        barrierDismissible: false,
        context: Get.context!,
      );
    }
  }

  Future<void> callExamType(standardID) async {
    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context,
        callMethod: CallMethod.get,
        apiUrl:
            "https://erp.triz.co.in/result/exam_master?type=API&sub_institute_id=${userInfo[CS.sub_institute_id]}&standard_id=$standardID",
        isShowProgressDialog: false,
      );
    } else {
      CU.showNoInternetDialog(Get.context!, callServiceReport);
      return;
    }

    ExamTypeModel model = ExamTypeModel.fromJson(resJson);
    examTypeList.value += model.data!;

    for (var i = 0; i < examTypeList.length; i++) {
      examName.add(examTypeList[i].examTitle!);
    }
  }
}
