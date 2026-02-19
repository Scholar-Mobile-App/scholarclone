import 'dart:developer';

import 'package:dio/dio.dart' as dio;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:scholar_clone/core/utils/api_client.dart';
import 'package:scholar_clone/core/utils/cs.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/core/utils/enum.dart';
import 'package:scholar_clone/model/student/home_data_model.dart';
import 'package:scholar_clone/model/teacher/assign_homework/section_model.dart';
import 'package:scholar_clone/model/teacher/assign_homework/studen_list_model.dart';

class AssignHomeworkController extends GetxController {
  @override
  void onInit() {
    if (userInfo["user_profile_name"] == "Admin") {
      callServiceSection();
    }
    if (userInfo["user_profile_name"] == "Teacher") {
      callServiceStandard(sectionID);
    }
    super.onInit();
  }

  RxString imageFile = "".obs;

  Rx<DateTime> selectedDate = DateTime.now().obs;

  RxList<String> sectionName = <String>[].obs;
  RxList<String> stdName = <String>[].obs;
  RxList<String> divName = <String>[].obs;
  RxList<String> subjectName = <String>[].obs;
  RxList<String> checkData = <String>[].obs;
  RxList<String> email = <String>[].obs;
  RxList<String> studentList = <String>[].obs;

  SectionModel? sectionModel;
  StandardModel? standardModel;
  DivisionModel? divisionModel;
  TeacherSubjectModel? teacherSubjectModel;
  StudentListModel? studentModel;

  RxInt sectionID = 0.obs;
  RxInt stdId = 0.obs;
  RxInt divId = 0.obs;
  RxInt subjectId = 0.obs;

  RxString title = "".obs;
  RxString titleError = "".obs;
  RxString discription = "".obs;
  RxString discriptionError = "".obs;
  RxString submissionDateError = "".obs;
  RxString imageError = "".obs;
  RxString studentID = "".obs;
  RxString selectSubject = "".obs;

  RxBool selectAll = false.obs;

  Content data = Get.arguments[0];
  Map<String, dynamic> userInfo = Get.arguments[1];

  Map<String, dynamic> resJson = <String, dynamic>{};

  pickPhotos() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ["jpg", "png", "pdf"],
      allowMultiple: false,
    );

    imageFile.value = result!.files.first.path!;
  }

  bool valid() {
    final RxBool isValid = true.obs;
    titleError.value = '';
    discriptionError.value = '';
    submissionDateError.value = '';
    imageError.value = '';

    if (title.isEmpty) {
      titleError.value = "Please enter a Title";
      CU.showToast(Get.context!, titleError.value);
      isValid.value = false;
    } else if (discription.isEmpty) {
      discriptionError.value = "Please enter a discription";
      CU.showToast(Get.context!, discriptionError.value);
      isValid.value = false;
    } else if (selectedDate.value.toString().isEmpty) {
      submissionDateError.value = "Please select a valid date";
      CU.showToast(Get.context!, submissionDateError.value);
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

  Future<void> callServiceStandard(sectionID) async {
    Map<String, dynamic> body = <String, dynamic>{
      CS.token: userInfo[CS.token],
      CS.teacher_id: userInfo[CS.teacher_id],
      CS.type: "API",
      CS.syear: userInfo[CS.syear] ?? syear,
      CS.sub_institute_id: userInfo[CS.sub_institute_id],
    };

    Map<String, dynamic> adminBody = <String, dynamic>{
      CS.token: userInfo[CS.token],
      CS.sub_institute_id: userInfo[CS.sub_institute_id],
      "grade_id": sectionID
    };

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context,
        body: userInfo["user_profile_name"] == "Admin" ? adminBody : body,
        apiUrl: userInfo["user_profile_name"] == "Admin"
            ? "https://erp.triz.co.in/get_adminStandard"
            : "https://erp.triz.co.in/get_teacher_timetablewiseStandard",
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
      CU.showNoInternetDialog(Get.context!, callServiceStandard);
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
    teacherSubjectModel = model;
    for (int i = 0; i < model.data!.length; i++) {
      subjectName.add(model.data![i].subName!);
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
      StudentListModel model = StudentListModel.fromJson(resJson);
      studentModel = model;
      for (var i = 0; i < model.data!.length; i++) {
        studentList.add(model.data![i].studentName!);
      }
      update();
    } else if (resJson[CS.status].toString() == StatusCode.Error) {
      showDialog(
        builder: (context) => CU.showDiloag(context, resJson[CS.message]),
        barrierDismissible: false,
        context: Get.context!,
      );
    }
  }

  Future<void> callService() async {
    if (valid()) {
      var emails = '';
      for (int i = 0; i < email.length; i++) {
        emails += '${email[i]},';
        studentID.value =
            emails.replaceRange(emails.length - 1, emails.length, '');
      }

      dio.FormData formData = dio.FormData.fromMap({
        CS.syear: userInfo[CS.syear] ?? syear,
        CS.sub_institute_id: userInfo[CS.sub_institute_id],
        CS.type: "API",
        CS.teacher_id: userInfo[CS.teacher_id],
        "title": title.value,
        "description": discription.value,
        "submission_date": selectedDate.value,
        "standard_id": stdId.value,
        "division_id": divId.value,
        "subject_id": subjectId.value,
        "image": imageFile.value.isEmpty ? null : imageFile.value,
        for (int i = 0; i < checkData.length; i++) "students[$i]": checkData[i],
        CS.token: userInfo[CS.token],
      });

      if (imageFile.value.isNotEmpty) {
        formData.files.add(
          MapEntry("image", await dio.MultipartFile.fromFile(imageFile.value)),
        );
      }

      log("...... ${formData.fields}");

      if (await CU.checkInternet()) {
        resJson = await ApiClient.call(
          Get.context!,
          body: formData,
          isFormData: false,
          apiUrl: "https://erp.triz.co.in/student/student_homework",
          isShowProgressDialog: false,
        );
      } else {
        CU.showNoInternetDialog(Get.context!, callService);
        return;
      }

      if (resJson[CS.status].toString() == StatusCode.Success) {
        Fluttertoast.showToast(
          msg: resJson[CS.message],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );

        Get.back();
      } else if (resJson[CS.status_code].toString() == StatusCode.Error ||
          resJson[CS.status].toString() == StatusCode.Authentication) {
        showDialog(
          builder: (context) => CU.showDiloag(context, resJson[CS.message]),
          barrierDismissible: false,
          context: Get.context!,
        );
      }
    }
  }
}
