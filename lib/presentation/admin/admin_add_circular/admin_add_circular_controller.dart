import 'dart:developer';
import 'package:dio/dio.dart' as dio;
import 'package:file_picker/file_picker.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/api_client.dart';
import 'package:scholar_clone/core/utils/cs.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/core/utils/enum.dart';
import 'package:scholar_clone/core/utils/utility.dart';
import 'package:scholar_clone/model/admin/get_admin_standard_model.dart';
import 'package:scholar_clone/model/student/home_data_model.dart';
import 'package:scholar_clone/model/teacher/assign_homework/section_model.dart';

class AdminAddCircularController extends GetxController {
  @override
  void onInit() {
    callServiceSection();
    super.onInit();
  }

  Content data = Get.arguments[0];
  Map<String, dynamic> userInfo = Get.arguments[1];

  Map<String, dynamic> resJson = <String, dynamic>{};

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

  RxInt stdId = 0.obs;
  RxInt divId = 0.obs;
  RxInt subjectId = 0.obs;
  RxInt type = 0.obs;
  RxInt sectionID = 0.obs;

  RxString title = "".obs;
  RxString message = "".obs;
  RxString selectStandard = "".obs;
  RxString selectDivision = "".obs;
  RxString selectType = "".obs;

  RxBool isLoading = false.obs;

  RxString imageFile = "".obs;

  RxString selectStandardError = "".obs;
  RxString selectDivisionError = "".obs;
  RxString submissionDateError = "".obs;
  RxString titleError = "".obs;
  RxString selectTypeError = "".obs;
  RxString messageError = "".obs;
  RxString imageError = "".obs;

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

    selectStandardError.value = "";
    selectDivisionError.value = "";
    submissionDateError.value = "";
    titleError.value = "";
    selectTypeError.value = '';
    messageError.value = '';
    imageError.value = '';

    if (selectStandard.value.isEmpty) {
      selectStandardError.value = "Please select a standerd";
      CU.showToast(Get.context!, selectStandardError.value);
      isValid.value = false;
    } else if (selectDivision.value.isEmpty) {
      selectDivisionError.value = "Please select a division";
      CU.showToast(Get.context!, selectDivisionError.value);
      isValid.value = false;
    } else if (selectedDate.value.toString().isEmpty) {
      submissionDateError.value = "Please select a valid date";
      CU.showToast(Get.context!, submissionDateError.value);
      isValid.value = false;
    } else if (title.value.isEmpty) {
      titleError.value = "Please enter a Title";
      CU.showToast(Get.context!, titleError.value);
      isValid.value = false;
    } else if (selectType.value.isEmpty) {
      selectTypeError.value = "Please select type";
      CU.showToast(Get.context!, selectTypeError.value);
      isValid.value = false;
    } else if (message.isEmpty) {
      messageError.value = "Please enter a message";
      CU.showToast(Get.context!, messageError.value);
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

  Future<void> callService(context) async {
    if (valid()) {
      log("FILE PATH ${imageFile.value}");

      dio.FormData formData = dio.FormData.fromMap({
        CS.user_id: userInfo[CS.user_id],
        "title": title.value,
        "message": message.value,
        "type": type.value,
        "date_": selectedDate.value,
        "standard_id": stdId.value,
        "division_id": divId.value,
        "attachment[0]": imageFile.value.isEmpty ? null : imageFile.value,
        CS.sub_institute_id: userInfo[CS.sub_institute_id],
        CS.syear: userInfo[CS.syear] ?? syear,
        CS.token: userInfo[CS.token],
      });
      if (imageFile.value.isNotEmpty) {
        formData.files.add(
          MapEntry("attachment[0]",
              await dio.MultipartFile.fromFile(imageFile.value)),
        );
      }

      isLoading.value = true;
      if (await CU.checkInternet()) {
        resJson = await ApiClient.call(
          Get.context,
          body: formData,
          apiUrl: "https://erp.triz.co.in/add_adminCircularAPI",
          isFormData: false,
          isShowProgressDialog: false,
        );
      } else {
        CU.showNoInternetDialog(Get.context!, callService);
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
        isLoading.value = false;
      } else if (resJson[CS.status_code].toString() == StatusCode.Error ||
          resJson[CS.status].toString() == StatusCode.Authentication) {
        showDialog(
          builder: (context) => CU.showDiloag(context, resJson[CS.message]),
          barrierDismissible: false,
          context: Get.context!,
        );
        isLoading.value = false;
      }
    }
  }
}
