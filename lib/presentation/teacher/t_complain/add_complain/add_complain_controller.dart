import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:scholar_clone/core/utils/api_client.dart';
import 'package:scholar_clone/core/utils/cs.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/core/utils/enum.dart';
import 'package:scholar_clone/core/utils/utility.dart';
import 'package:scholar_clone/model/student/home_data_model.dart';
import 'package:scholar_clone/model/teacher/visitor_type_model.dart';

import 'package:dio/dio.dart' as dio;

class AddComplainController extends GetxController {
  Content data = Get.arguments[0];
  Map<String, dynamic> userInfo = Get.arguments[1];

  final GlobalKey<FormFieldState> allocatedKey = GlobalKey<FormFieldState>();

  RxList<ToMeetArray> toMeetList = <ToMeetArray>[].obs;
  RxList<String> allocateNameList = <String>[].obs;

  Rx<DateTime> selectedDate = DateTime.now().obs;

  RxString title = "".obs;
  RxString description = "".obs;
  RxString imageFile = "".obs;

  RxInt allocate = 0.obs;

  Map<String, dynamic> resJson = {};

  @override
  void onInit() {
    callServiceAllocate();
    super.onInit();
  }

  bool valid() {
    final RxBool isValid = true.obs;

    if (title.value.isEmpty) {
      CU.showToast(Get.context!, "Please enter title");
      isValid.value = false;
    } else if (allocate.value == 0) {
      CU.showToast(Get.context!, "Please select a allocated to");
      isValid.value = false;
    }

    return isValid.value;
  }

  pickPhotos() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ["jpg", "png", "pdf"],
      allowMultiple: false,
    );

    imageFile.value = result!.files.first.path!;
  }

  Future<void> callServiceAllocate() async {
    Map<String, dynamic> body = <String, dynamic>{
      CS.token: userInfo[CS.token],
      CS.type: "API",
      CS.sub_institute_id: userInfo[CS.sub_institute_id],
    };

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context!,
        body: body,
        apiUrl: "https://erp.triz.co.in/get_visitorTypeAPI",
        isShowProgressDialog: false,
      );
    } else {
      CU.showNoInternetDialog(
        Get.context!,
        callServiceAllocate,
      );
      return;
    }

    VisitorTypeModel model = VisitorTypeModel.fromJson(resJson);

    toMeetList.value = model.toMeetArray!;

    if (toMeetList.isNotEmpty) {
      for (var i = 0; i < model.toMeetArray!.length; i++) {
        allocateNameList.add(toMeetList[i].staffName!);
      }
    }
  }

  Future<void> callService(context) async {
    if (valid()) {
      dio.FormData formData = dio.FormData.fromMap({
        if (userInfo["user_profile_name"] == "Teacher")
          CS.teacher_id: userInfo[CS.teacher_id],
        if (userInfo["user_profile_name"] == "Admin")
          "admin_id": userInfo["user_id"],
        "title": title.value,
        "description": description.value,
        "date": selectedDate.value,
        "allocated_to": allocate.value,
        CS.sub_institute_id: userInfo[CS.sub_institute_id],
        CS.syear: userInfo[CS.syear] ?? syear,
        CS.token: userInfo[CS.token],
        "attachment": imageFile.value.isEmpty ? null : imageFile.value,
      });

      if (imageFile.value.isNotEmpty) {
        formData.files.add(
          MapEntry(
              "attachment", await dio.MultipartFile.fromFile(imageFile.value)),
        );
      }

      if (await CU.checkInternet()) {
        resJson = await ApiClient.call(
          context,
          body: formData,
          apiUrl: userInfo["user_profile_name"] == "Admin"
              ? "https://erp.triz.co.in/add_complaintAPI"
              : "https://erp.triz.co.in/add_teachercomplaintAPI",
          isShowProgressDialog: false,
          isFormData: false,
        );
      } else {
        CU.showNoInternetDialog(context, callService);
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
      } else if (resJson[CS.status_code].toString() == StatusCode.Error ||
          resJson[CS.status].toString() == StatusCode.Authentication) {
        showDialog(
          builder: (context) => CU.showDiloag(context, resJson[CS.message]),
          barrierDismissible: false,
          context: context,
        );
      }
    }
  }
}
