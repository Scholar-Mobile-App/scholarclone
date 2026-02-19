import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/api_client.dart';
import 'package:scholar_clone/core/utils/enum.dart';
import 'package:scholar_clone/core/utils/utility.dart';
import 'package:scholar_clone/model/student/home_data_model.dart';

import 'package:dio/dio.dart' as dio;

import '../../../core/utils/cs.dart';
import '../../../core/utils/cu.dart';

class StudentFaceAttendanceController extends GetxController {
  Content data = Get.arguments[0];
  Map<String, dynamic> userInfo = Get.arguments[1];

  RxBool isLoading = false.obs;
  RxBool isChange = false.obs;
  RxBool isSetFromNetworkImage = false.obs;

  // RxList<FaceAttendance> faceAttendanceList = <FaceAttendance>[].obs;
  RxList<String> imagePath = <String>[].obs;
  Map<String, dynamic> resJson = <String, dynamic>{};

  @override
  void onInit() {
    callServiceGetPhotos();
    super.onInit();
  }

  Future<void> callServiceGetPhotos() async {
    isLoading.value = true;
    dio.FormData formData = dio.FormData.fromMap({
      CS.student_id: userInfo[CS.student_id],
      CS.sub_institute_id: userInfo[CS.sub_institute_id],
      CS.syear: userInfo[CS.syear] ?? syear,
      CS.token: userInfo[CS.token],
    });

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        Get.context,
        body: formData,
        isFormData: false,
        apiUrl: "https://erp.triz.co.in/get_studentCapturePhotosAPI",
        isShowProgressDialog: false,
      );
    } else {
      CU.showNoInternetDialog(Get.context!, callServiceGetPhotos);
      return;
    }

    if (resJson[CS.status].toString() == StatusCode.Success) {
      if (resJson[CS.data] != null) {
        for (int i = 0; i < resJson[CS.data].length; i++) {
          imagePath.add(resJson[CS.data][i]['stu_image']);
        }
        isSetFromNetworkImage.value = true;
      }
    } else if (resJson[CS.status_code].toString() == StatusCode.Error ||
        resJson[CS.status].toString() == StatusCode.Authentication) {
      showDialog(
        builder: (context) => CU.showDiloag(context, resJson[CS.message]),
        barrierDismissible: false,
        context: Get.context!,
      );
    }
    isLoading.value = false;
  }

  Future<void> callServiceSubmit(context) async {
    Map<String, dynamic> resJson = <String, dynamic>{};

    dio.FormData formData = dio.FormData.fromMap({
      CS.student_id: userInfo[CS.student_id],
      CS.sub_institute_id: userInfo[CS.sub_institute_id],
      CS.syear: userInfo[CS.syear] ?? syear,
      CS.token: userInfo[CS.token],
    });
    for (int i = 0; i < imagePath.length; i++) {
      formData.files.addAll([
        MapEntry(
            "stu_image[$i]", await dio.MultipartFile.fromFile(imagePath[i])),
      ]);
    }

    if (await CU.checkInternet()) {
      resJson = await ApiClient.call(
        context,
        body: formData,
        isFormData: false,
        apiUrl: "https://erp.triz.co.in/add_studentCapturePhotosAPI",
        isShowProgressDialog: false,
      );
    } else {
      CU.showNoInternetDialog(Get.context!, callServiceSubmit);
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
