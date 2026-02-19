import 'package:get/get.dart';
import 'package:scholar_clone/model/student/home_data_model.dart';

import 'package:flutter/material.dart';
import 'package:scholar_clone/core/utils/api_client.dart';
import 'package:scholar_clone/core/utils/cs.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/core/utils/enum.dart';
import 'package:scholar_clone/model/teacher/assign_homework/section_model.dart';
import 'package:scholar_clone/model/teacher/teacher_exam_model.dart';

class TeacherMarkController extends GetxController {
  Content data = Get.arguments[0];
  Map<String, dynamic> userInfo = Get.arguments[1];

  Map<String, dynamic> resJson = <String, dynamic>{};

  RxList<String> sectionName = <String>[].obs;
  RxList<String> stdName = <String>[].obs;
  RxList<String> divName = <String>[].obs;
  RxList<String> termName = <String>[].obs;
  RxList<TeacherSubject> subjectList = <TeacherSubject>[].obs;
  RxList<Exam> examList = <Exam>[].obs;
  RxList<String> subjectName = <String>[].obs;
  RxList<String> examName = <String>[].obs;

  RxString term = "".obs;
  RxString selectStandard = "".obs;
  RxString selectDivision = "".obs;
  RxString selectSubject = "".obs;
  RxString selectExam = "".obs;

  RxInt stdId = 0.obs;
  RxInt divId = 0.obs;
  RxInt termId = 0.obs;
  RxInt subjectId = 0.obs;
  RxInt gradeId = 0.obs;
  RxInt examId = 0.obs;

  StandardModel? standardModel;
  DivisionModel? divisionModel;

  @override
  void onInit() {
    for (int i = 0; i < userInfo["term_data"].length; i++) {
      termName.add(userInfo["term_data"][i]["title"]);
    }

    super.onInit();
  }

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
      CU.showNoInternetDialog(Get.context!, callServiceDivision);
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

  Future<void> callServiceExam() async {
    Map<String, dynamic> body = <String, dynamic>{
      "standard_id": stdId.value,
      "term_id": termId.value,
      "grade_id": gradeId.value,
      "subject_id": 3975, //   subjectId.value,
      CS.token: userInfo[CS.token],
      CS.type: "API",
      CS.syear: userInfo[CS.syear] ?? syear,
      CS.sub_institute_id: userInfo[CS.sub_institute_id],
    };

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context!,
        body: body,
        apiUrl: "https://erp.triz.co.in/get_teacherResultExamList",
        isShowProgressDialog: false,
      );
    } else {
      CU.showNoInternetDialog(Get.context!, callServiceSubject);
      return;
    }
    ExamModel model = ExamModel.fromJson(resJson);

    examList.value = model.data!;
    for (int i = 0; i < examList.length; i++) {
      examName.add(examList[i].title!);
    }
  }
}
