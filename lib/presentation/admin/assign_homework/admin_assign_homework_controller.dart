import 'package:dio/dio.dart' as dio;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:scholar_clone/core/utils/api_client.dart';
import 'package:scholar_clone/core/utils/cs.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/core/utils/enum.dart';
import 'package:scholar_clone/model/admin/get_admin_standard_model.dart';
import 'package:scholar_clone/model/admin/get_admin_student_list_model.dart';
import 'package:scholar_clone/model/student/home_data_model.dart';
import 'package:scholar_clone/model/teacher/assign_homework/section_model.dart';

class AdminAssignHomeworkController extends GetxController {
  @override
  void onInit() {
    callServiceSection();
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
  GetAdminStandardModel? standardModel;
  GetAdminDivisionModel? divisionModel;
  GetAdminSubjectModel? teacherSubjectModel;
  GetAdminStudentListModel? studentModel;

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
    } else if (imageFile.value.isEmpty) {
      imageError.value = "Please select a Images";
      CU.showToast(Get.context!, imageError.value);
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

  Future<void> callServiceSubject(standardId) async {
    Map<String, dynamic> body = <String, dynamic>{
      "standard_id": standardId,
      CS.token: await userInfo[CS.token],
      CS.sub_institute_id: userInfo[CS.sub_institute_id],
    };

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context!,
        body: body,
        apiUrl: "https://erp.triz.co.in/get_adminSubject",
        isShowProgressDialog: false,
      );
    } else {
      CU.showNoInternetDialog(Get.context!, callServiceSubject);
      return;
    }

    GetAdminSubjectModel model = GetAdminSubjectModel.fromJson(resJson);
    teacherSubjectModel = model;
    for (int i = 0; i < model.data!.length; i++) {
      subjectName.add(model.data![i].subjectName!);
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
        apiUrl: "https://erp.triz.co.in/get_adminStudentList",
        isShowProgressDialog: false,
      );
    } else {
      CU.showNoInternetDialog(Get.context!, callServiceSearch);
      return;
    }

    if (resJson[CS.status].toString() == StatusCode.Success) {
      GetAdminStudentListModel model =
          GetAdminStudentListModel.fromJson(resJson);
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
        CS.user_id: userInfo[CS.user_id],
        "title": title.value,
        "description": discription.value,
        "submission_date": selectedDate.value,
        "standard_id": stdId.value,
        "division_id": divId.value,
        "subject_id": subjectId.value,
        "image": imageFile.value.isEmpty ? null : imageFile.value,
        "students[]": studentID.value,
        CS.sub_institute_id: userInfo[CS.sub_institute_id],
        CS.syear: userInfo[CS.syear] ?? syear,
        CS.type: "API",
        CS.token: userInfo[CS.token],
      });

      if (imageFile.value.isNotEmpty) {
        formData.files.add(
          MapEntry("image", await dio.MultipartFile.fromFile(imageFile.value)),
        );
      }

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
