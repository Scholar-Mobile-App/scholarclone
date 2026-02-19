import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/api_client.dart';
import 'package:scholar_clone/core/utils/cs.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/core/utils/enum.dart';
import 'package:scholar_clone/model/student/home_data_model.dart';
import 'package:scholar_clone/model/teacher/assign_homework/section_model.dart';
import 'package:scholar_clone/model/teacher/assign_homework/studen_list_model.dart';

class TeacherCapturePhotoController extends GetxController {
  Content data = Get.arguments[0];
  Map<String, dynamic> userInfo = Get.arguments[1];
  bool isAttedance = Get.arguments[2];

  Map<String, dynamic> resJson = <String, dynamic>{};

  RxInt stdID = 0.obs;
  RxInt divID = 0.obs;
  RxInt subjectId = 0.obs;

  RxList<String> sectionList = <String>[].obs;
  RxList<String> divList = <String>[].obs;
  RxList<Student> studentList = <Student>[].obs;

  RxString section = "".obs;
  RxString standard = "".obs;
  RxString stdDiv = "".obs;
  RxString selectSubject = "".obs;

  @override
  void onInit() {
    callServiceSection();

    var list = userInfo["standard_division"].split(",");
    var div = userInfo["standard_division_title"].split(",");
    for (int i = 0; i < list.length; i++) {
      if (list[i] != "") {
        divList.add(div[i].replaceAll("||", "-"));
      }
    }
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

    for (int i = 0; i < model.data!.length; i++) {
      sectionList.add(model.data![i].shortName!);
    }
  }

  Future<void> callServiceAllocate(stdDiv) async {
    var string = stdDiv;
    var ans = string.split("||");
    Map<String, dynamic> body = <String, dynamic>{
      CS.token: userInfo[CS.token],
      "standard_id": ans[0].trim(),
      "division_id": ans[1].trim(),
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
